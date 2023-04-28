library(data.table)
library(tidyverse)
library(MASS)
library(pROC)

## read network structure table
network <- fread("network.csv") 
## read deg table
deg <- fread("deg.csv")
## bind the table together
network_deg <- merge(network,deg,by="group")

## leave-one-out prediction
loo_predict <- function(obj) {
yhat <- foreach(i = 1:nrow(obj$data), .combine = rbind) %dopar% {
predict(update(obj, data = obj$data[-i, ]), obj$data[i,], type = "response")
}
return(data.frame(result = yhat[, 1], row.names = NULL))
}

network_deg_data <- network_deg[,-1] ## remove group label

### build up the null glm model
null_glm <- glm(formula =DEG~1,family = binomial, data = network_deg_data)
summary(null_glm)

### build up the full glm model
full_glm <- glm(formula =DEG~.,family = binomial, data = network_deg_data)
summary(full_glm)

### select the best glm model
step_glm <- stepAIC(full_glm, direction = "both", trace = T) 

### prediction
pre_glm <- loo_predict(step_glm)

## rank the candidate EG
rank_eg <- data.frame(network_deg[,'group'], pre_glm)
# order by predicted probability score
rank_eg <- rank_eg[order(-rank_eg[,2]), ] #
colnames(rank_eg)[1:2] <- c("group","probability")
rank_eg$rank <- c(1:dim(rank_eg)[1])
rank_eg <- merge(deg,rank_eg,by="group")

### plot the roc and auc
pROC_glm_all <- roc(rank_eg$DEG,rank_eg$probability)
plot(pROC_glm_all, print.auc = TRUE)


