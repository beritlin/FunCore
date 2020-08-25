##### ranking #####

setwd("/work1/home/peiyu/FunCoreTest/NewScore")
result <- read.csv("/work1/home/peiyu/FunCoreTest/NEWalnRes.m8",header = F,sep = "\t")

library(igraph)
df <- read.csv("Louvain_Clustering_s1.txt",header = F, sep = " ")
df_bs <- read.csv("7_Louvain_Clustering_bs.txt",header = F, sep = " ")
df_ev <- read.csv("7_Louvain_Clustering_ev.txt",header = F, sep = " ")

#### species ####

species <- read.table("species_s1.txt",header = F, sep = " ")


species[species>0] <- 1
df2 <- data.frame(apply(species,1,sum))

species_bs[species_bs>0] <- 1
dfbs <- data.frame(apply(species_bs,1,sum))

species_ev[species_ev>0] <- 1
dfev <- data.frame(apply(species_ev,1,sum))

#### Louvain ####

it <- data.frame(result[,c(1,2,14)])
it1 <- as.vector(result[,c(14)])
clustergraph <- graph_from_data_frame(it, directed = F, vertices = NULL)
clusterlouvain <- cluster_louvain(clustergraph,weights = it1)
print(clusterlouvain)
sizeL <- data.frame(sizes(clusterlouvain))
size_it <- sizeL[sizeL$Freq>1,]

bs <- data.frame(result[,c(1,2,12)])
bs1 <- as.vector(result[,c(12)])
clustergraph <- graph_from_data_frame(bs, directed = F, vertices = NULL)
clusterlouvain <- cluster_louvain(clustergraph,weights = bs1)
print(clusterlouvain)
sizeL <- data.frame(sizes(clusterlouvain))
size_bs <- sizeL[sizeL$Freq>1,]


ev <- data.frame(result[,c(1,2,11)])
ev1 <- as.vector(result[,c(11)])
clustergraph <- graph_from_data_frame(ev, directed = F, vertices = NULL)
clusterlouvain <- cluster_louvain(clustergraph,weights = ev1)
print(clusterlouvain)
sizeL <- data.frame(sizes(clusterlouvain))
size_ev <- sizeL[sizeL$Freq>1,]

#### nodes ####
r_it <- cbind(size_it,df2[2:c(dim(df2)[1]),])
colnames(r_it)[1] <- "group"
colnames(r_it)[2] <- "nodes"
colnames(r_it)[3] <- "species"

r_bs <- cbind(size_bs,dfbs[2:c(dim(dfbs)[1]),])
colnames(r_bs)[1] <- "group"
colnames(r_bs)[2] <- "nodes"
colnames(r_bs)[3] <- "species"

r_ev <- cbind(size_ev,dfev[2:c(dim(dfev)[1]),])
colnames(r_ev)[1] <- "group"
colnames(r_ev)[2] <- "nodes"
colnames(r_ev)[3] <- "species"

#### average edges ####
it_m <- data.frame(clusterlouvain$names,clusterlouvain$membership)
colnames(it_m)[1] <- "V1"
colnames(it_m)[2] <- "group"
it_m2 <- merge(it,it_m,by="V1")

it_m3 <- data.frame(r_it[,1])
colnames(it_m3)[1] <- "group"
it_m4 <- merge(it_m3,it_m2,by="group")

sim_it <- data.frame(matrix(NA,dim(r_it)[1],1))
sim_it <- cbind(it_m3,sim_it)
u <- unique(it_m3$group)

for (i in 1:length(u)) {
  sim_it[sim_it$group==u[i],2] <- mean(it_m4[it_m4$group==u[i],4])
  print(i)
}

colnames(sim_it)[2] <- "mean_edge"
r_it <- merge(sim_it,r_it,by="group")

#
bs_m <- data.frame(clusterlouvain$names,clusterlouvain$membership)
colnames(bs_m)[1] <- "V1"
colnames(bs_m)[2] <- "group"
bs_m2 <- merge(bs,bs_m,by="V1")

bs_m3 <- data.frame(r_bs[,1])
colnames(bs_m3)[1] <- "group"
bs_m4 <- merge(bs_m3,bs_m2,by="group")

sim_bs <- data.frame(matrix(NA,dim(r_bs)[1],1))
sim_bs <- cbind(bs_m3,sim_bs)
u <- unique(bs_m3$group)

for (i in 1:length(u)) {
  sim_bs[sim_bs$group==u[i],2] <- mean(bs_m4[bs_m4$group==u[i],4])
  print(i)
}

colnames(sim_bs)[2] <- "mean_edge"
r_bs <- merge(sim_bs,r_bs,by="group")

#
ev_m <- data.frame(clusterlouvain$names,clusterlouvain$membership)
colnames(ev_m)[1] <- "V1"
colnames(ev_m)[2] <- "group"
ev_m2 <- merge(ev,ev_m,by="V1")

ev_m3 <- data.frame(r_ev[,1])
colnames(ev_m3)[1] <- "group"
ev_m4 <- merge(ev_m3,ev_m2,by="group")

sim_ev <- data.frame(matrix(NA,dim(r_ev)[1],1))
sim_ev <- cbind(ev_m3,sim_ev)
u <- unique(ev_m3$group)

for (i in 1:length(u)) {
  sim_ev[sim_ev$group==u[i],2] <- mean(ev_m4[ev_m4$group==u[i],4])
}

colnames(sim_ev)[2] <- "mean_edge"
colnames(r_ev)[1] <- "group"
r_ev <- merge(sim_ev,r_ev,by="group")


#### average nodes' edges ####

#
deg_it <- data.frame(matrix(NA,dim(r_it)[1],3))
deg_it <- cbind(it_m3,deg_it)
u <- unique(it_m3$group)

for (i in 1:length(u)) {
  clustergraphda2<-graph_from_data_frame(it_m4[it_m4$group==u[i],c(2:4)])
  test.graph.adj<-get.adjacency(clustergraphda2,sparse=F)
  test.graph.properties<-GenInd(test.graph.adj)
  deg_it[deg_it$group==u[i],2] <- test.graph.properties$Ltot
  deg_it[deg_it$group==u[i],3] <- test.graph.properties$LD
  deg_it[deg_it$group==u[i],4] <- test.graph.properties$C
  print(i)
}
colnames(deg_it)[2] <- "links"
colnames(deg_it)[3] <- "density"
colnames(deg_it)[4] <- "connectance"

r_it <- merge(deg_it,r_it,by="group")

#

deg_bs <- data.frame(matrix(NA,dim(r_bs)[1],3))
deg_bs <- cbind(bs_m3,deg_bs)
u <- unique(bs_m3$group)

for (i in 1:length(u)) {
  clustergraphda2<-graph_from_data_frame(bs_m4[bs_m4$group==u[i],c(2:4)])
  test.graph.adj<-get.adjacency(clustergraphda2,sparse=F)
  test.graph.properties<-GenInd(test.graph.adj)
  deg_bs[deg_bs$group==u[i],2] <- test.graph.properties$Ltot
  deg_bs[deg_bs$group==u[i],3] <- test.graph.properties$LD
  deg_bs[deg_bs$group==u[i],4] <- test.graph.properties$C
  print(i)
}
colnames(deg_bs)[2] <- "links"
colnames(deg_bs)[3] <- "density"
colnames(deg_bs)[4] <- "connectance"

r_bs <- merge(deg_bs,r_bs,by="group")

#

deg_ev <- data.frame(matrix(NA,dim(r_ev)[1],3))
deg_ev <- cbind(ev_m3,deg_ev)
u <- unique(ev_m3$group)

for (i in 5783:length(u)) {
  clustergraphda2<-graph_from_data_frame(ev_m4[ev_m4$group==u[i],c(2:4)])
  test.graph.adj<-get.adjacency(clustergraphda2,sparse=F)
  test.graph.properties<-GenInd(test.graph.adj)
  deg_ev[deg_ev$group==u[i],2] <- test.graph.properties$Ltot
  deg_ev[deg_ev$group==u[i],3] <- test.graph.properties$LD
  deg_ev[deg_ev$group==u[i],4] <- test.graph.properties$C
  print(i)
}
colnames(deg_ev)[2] <- "links"
colnames(deg_ev)[3] <- "density"
colnames(deg_ev)[4] <- "connectance"

r_ev <- merge(deg_ev,r_ev,by="group")


#### validation ####
DEG_IT <- read.csv("6m6_DEG.m8",header = F,sep = "\t")
DEG_IT <- DEG_IT[DEG_IT$V11<=10e-10,]

df_it[is.na(df_it)] <- 0
U <- as.character(unique(DEG_IT$V1))

colnames(DEG_IT)[1] <- "V1"
it_m6 <- merge(DEG_IT,it_m, by="V1")
u <- unique(it_m6$group)
inDEG_it <- data.frame(matrix(NA,dim(r_it)[1]),r_it$group)

for (i in 1:length(u)){
    for (j in 1:dim(inDEG_it)[1]) {
        if (u[i]==inDEG_it[j,2]) {
           inDEG_it[j,1] <- "YES"
        } 
    }
}

inDEG_it[is.na(inDEG_it)] <- "NO"

colnames(inDEG_it)[1] <- "inDEG"
colnames(inDEG_it)[2] <- "group"
r_it <- merge(inDEG_it,r_it,by="group")

##
DEG_BS <- read.csv("7m7_DEG_bs.m8",header = F,sep = "\t")
DEG_BS <- DEG_BS[DEG_BS$V11<=10e-10,]

df_bs[is.na(df_bs)] <- 0
U <- as.character(unique(DEG_BS$V1))

colnames(DEG_BS)[1] <- "V1"
bs_m6 <- merge(DEG_BS,bs_m, by="V1")
u <- unique(bs_m6$group)
inDEG_bs <- data.frame(matrix(NA,dim(r_bs)[1]),r_bs$group)

for (i in 1:length(u)){
    for (j in 1:dim(inDEG_bs)[1]) {
        if (u[i]==inDEG_bs[j,2]) {
           inDEG_bs[j,1] <- "YES"
        } else {
           inDEG_bs[j,1] <- "NO"
        }
    }
}

inDEG_bs[is.na(inDEG_bs)] <- "NO"

colnames(inDEG_bs)[1] <- "inDEG"
colnames(inDEG_bs)[2] <- "group"
r_bs <- merge(inDEG_bs,r_bs,by="group")

#
DEG_EV <- read.csv("7m7_DEG_ev.m8",header = F,sep = "\t")
DEG_EV <- DEG_EV[DEG_EV$V11<=10e-10,]

df_ev[is.na(df_ev)] <- 0
U <- as.character(unique(DEG_EV$V1))

colnames(DEG_EV)[1] <- "V1"
ev_m6 <- merge(DEG_EV,ev_m, by="V1")
u <- unique(ev_m6$group)
inDEG_ev <- data.frame(matrix(NA,dim(r_ev)[1]),r_ev$group)

for (i in 1:length(u)){
    for (j in 1:dim(inDEG_ev)[1]) {
        if (u[i]==inDEG_ev[j,2]) {
           inDEG_ev[j,1] <- "YES"
        } else {
           inDEG_ev[j,1] <- "NO"
        }
    }
}
inDEG_ev[is.na(inDEG_ev)] <- "NO"
colnames(inDEG_ev)[1] <- "inDEG"
colnames(inDEG_ev)[2] <- "group"
r_ev <- merge(inDEG_ev,r_ev,by="group")

#### prediction ####
md <- read.table("/work1/home/peiyu/FunCoreTest/model.txt",header=T)
glm_it <-glm(formula =as.numeric(as.factor(md$inDEG))-1~species+nodes+mean_edge, family = binomial,data = md)
pre_it <- data.frame(predict(glm_it, r_it, type="response"))
rank_it <- data.frame(r_it$group, pre_it)
rank_it <- rank_it[order(-rank_it[,2]), ]
rank_it2 <- data.frame(matrix(1:dim(rank_it)[1],dim(rank_it)[1]))
rank_it <- cbind(rank_it2,rank_it)
colnames(rank_it)[1] <- "rank"
colnames(rank_it)[2] <- "group"
colnames(rank_it)[3] <- "probability"
rank_it <- merge(r_it,rank_it,by="group")

write.table(rank_it,"7m7_rank_it.txt",col.names=T,row.names=F)

#
md <- read.table("/work1/home/peiyu/FunCoreTest/model.txt",header=T)
glm_bs <-glm(formula =as.numeric(as.factor(md$inDEG))-1~species+nodes+mean_edge, family = binomial,data = md)
pre_bs <- data.frame(predict(glm_bs, r_bs, type="response"))
rank_bs <- data.frame(r_bs$group, pre_bs)
rank_bs <- rank_bs[order(-rank_bs[,2]), ]
rank_bs2 <- data.frame(matrix(1:dim(rank_bs)[1],dim(rank_bs)[1]))
rank_bs <- cbind(rank_bs2,rank_bs)
colnames(rank_bs)[1] <- "rank"
colnames(rank_bs)[2] <- "group"
colnames(rank_bs)[3] <- "probability"
rank_bs <- merge(r_bs,rank_bs,by="group")

write.table(rank_bs,"7m7_rank_bs.txt",col.names=T,row.names=F)

#
md <- read.table("/work1/home/peiyu/FunCoreTest/model.txt",header=T)
glm_ev <-glm(formula =as.numeric(as.factor(md$inDEG))-1~species+nodes+mean_edge+connectance,family = binomial, data = md)
pre_ev <- data.frame(predict(glm_ev, r_ev, type="response"))
rank_ev <- data.frame(r_ev$group, pre_ev)
rank_ev <- rank_ev[order(-rank_ev[,2]), ]
rank_ev2 <- data.frame(matrix(1:dim(rank_ev)[1],dim(rank_ev)[1]))
rank_ev <- cbind(rank_ev2,rank_ev)
colnames(rank_ev)[1] <- "rank"
colnames(rank_ev)[2] <- "group"
colnames(rank_ev)[3] <- "probability"
rank_ev <- merge(r_ev,rank_ev,by="group")

write.table(rank_ev,"7m7_rank_ev.txt",col.names=T,row.names=F)
###
library(ggplot2)

#as.numeric(as.factor(rank_it1$inDEG))-1

ggplot(r_it, aes(connectance,as.numeric(as.factor(r_it$inDEG))-1)) +
  stat_smooth(method="glm", family=binomial, formula=y~x,
              alpha=0.2, size=2) +
  geom_point(position=position_jitter(height=0.03, width=0)) +
  xlab("connectance") + ylab("Pr (inDEG)")

model_weight <-glm(formula =as.numeric(as.factor(r_it$inDEG))-1~species+nodes+mean_edge, family = binomial,data = r_it)
model_weight <-glm(formula =as.numeric(as.factor(r_bs$inDEG))-1~species+nodes+mean_edge,family = binomial, data = r_bs)
model_weight <-glm(formula =as.numeric(as.factor(r_it$inDEG))-1~species+nodes*links, data = r_it)

summary(model_weight)


rank_bs_new <- data.frame(predict(model_weight, rank_bs, type="response"))
rank_bs_new <- data.frame(rank_bs$group, rank_bs_new)
rank_bs_new <- rank_bs_new[order(-rank_bs_new[,2]), ]
rank_bs_new1 <- data.frame(matrix(NA,dim(rank_bs_new)[1],1))
rank_bs_new2 <- data.frame(matrix(1:5961,dim(rank_bs_new)[1],1))

rank_bs_new <- cbind(rank_bs_new2,rank_bs_new)
colnames(rank_bs_new)[1] <- "rank"
colnames(rank_bs_new)[2] <- "group"
colnames(rank_bs_new)[3] <- "probability" 
colnames(rank_bs_new)[4] <- "inDEG" 
ggplot(rank_bs_new,aes(rank,as.numeric(as.factor(rank_bs_new$inDEG))-1)) +
  geom_line(aes(rank,probability))+
  geom_point(position=position_jitter(height=0.03, width=0))+
  xlab("rank") + ylab("Pr (inDEG)")+
  xlim(1,2000)

rank_bs_new <- rank_bs_new[,c(2,4)]
rank_bs_new3 <- read.table("rank_new.txt",header = T)
write.table(rank_bs_new, "rank_new.txt", col.names = T,row.names = F)

#
rank_it_test <- merge(rank_it_new,r_it,by="group")
rank_it_test <- rank_it_test[,c(2,1,3,11,10)]
write.table(rank_it_test, "rank_it_test.csv", col.names = T,row.names = F)

it_member <- data.frame(clusterlouvain$names,clusterlouvain$names,clusterlouvain$membership)

library(reshape)
it_member <- within(it_member, clusterlouvain.names<-data.frame(do.call('rbind', strsplit(as.character(clusterlouvain.names), '|', fixed=TRUE))))
it_member$Species <- it_member$Species[,1]
colnames(it_member)[1] <- "Species"
colnames(it_member)[2] <- "SeqID"
colnames(it_member)[3] <- "group"
it_member <- merge(it_member,rank_it_test, by="group")
it_member <- it_member[,c(3,2,1,5)]
write.table(it_member, "it_member_test.csv", col.names = T,row.names = F)

#

rank_it_new <- read.table("rank_it_new.txt",header = T)

rank_it_new1 <- data.frame(matrix(NA,dim(rank_it_new)[1],1))
rank_it_new2 <- data.frame(matrix(1:5803,dim(rank_it_new)[1],1))

rank_it_new <- cbind(rank_it_new2,rank_it_new)
colnames(rank_it_new)[1] <- "rank"
colnames(rank_it_new)[2] <- "group"
colnames(rank_it_new)[3] <- "probability" 
colnames(rank_it_new)[4] <- "inDEG" 

write.table(rank_it_new,"rank_it_new.txt",col.names = T,row.names = F)

#
rank_ev_new <- data.frame(predict(model_weight, rank_bs, type="response"))
rank_bs_new <- data.frame(rank_bs$group, rank_bs_new)
rank_bs_new <- rank_bs_new[order(-rank_bs_new[,2]), ]
rank_bs_new1 <- data.frame(matrix(NA,dim(rank_bs_new)[1],1))
rank_bs_new2 <- data.frame(matrix(1:5961,dim(rank_bs_new)[1],1))

rank_ev_new <- read.table("rank_ev_new.txt",header = T)

rank_ev_new1 <- data.frame(matrix(NA,dim(rank_ev_new)[1],1))
rank_ev_new2 <- data.frame(matrix(1:6780,dim(rank_ev_new)[1],1))

rank_ev_new <- cbind(rank_ev_new2,rank_ev_new)
colnames(rank_ev_new)[1] <- "rank"
colnames(rank_ev_new)[2] <- "group"
colnames(rank_ev_new)[3] <- "probability" 
colnames(rank_ev_new)[4] <- "inDEG" 

write.table(rank_ev_new,"rank_ev_new1.txt",col.names = T,row.names = F)


ggplot(rank_ev_new,aes(rank,as.numeric(as.factor(rank_ev_new$inDEG))-1)) +
  geom_line(aes(rank,probability))+
  geom_point(position=position_jitter(height=0.03, width=0))+
  xlab("rank") + ylab("Pr (inDEG)")+
  xlim(1,2000)



write.table(rank_bs_new, "rank_new.txt", col.names = T,row.names = F)
#species+nodes+links+mean_edge+density+connectance

xweight <- seq(0, 5000,100)
yweight <- predict(model_weight, list(name = xweight),type="response")

plot(r_it$group,as.numeric(as.factor(r_ev$inDEG))-1~ species, pch = 16)
lines(xweight, yweight)


# Call:
#   glm(formula = as.numeric(as.factor(r_it$inDEG)) - 1 ~ 1, data = r_it)
# Deviance Residuals: 
#   Min       1Q   Median       3Q      Max  
# -0.1859  -0.1859  -0.1859  -0.1859   0.8141  
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 0.185916   0.005827   31.91   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# (Dispersion parameter for gaussian family taken to be 0.1513853)
# Null deviance: 674.88  on 4458  degrees of freedom
# Residual deviance: 674.88  on 4458  degrees of freedom
# AIC: 4238.8
#Number of Fisher Scoring iterations: 2

# Call:
#   glm(formula = as.numeric(as.factor(r_it$inDEG)) - 1 ~ species, data = r_it)
# Deviance Residuals: 
#   Min        1Q    Median        3Q       Max  
# -0.38136  -0.26686  -0.03785   0.07665   1.07665  
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.191157   0.012175  -15.70   <2e-16 ***
#   species      0.114503   0.003345   34.23   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# (Dispersion parameter for gaussian family taken to be 0.1198965)
# Null deviance: 674.88  on 4458  degrees of freedom
# Residual deviance: 534.38  on 4457  degrees of freedom
# AIC: 3200
# Number of Fisher Scoring iterations: 2


# Call:
#   glm(formula = as.numeric(as.factor(r_it$inDEG)) - 1 ~ species + nodes, data = r_it)
# Deviance Residuals: 
#   Min        1Q    Median        3Q       Max  
# -1.21497  -0.25553  -0.03526   0.07365   1.03908  
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.1850148  0.0120522  -15.35   <2e-16 ***
#   species      0.1089006  0.0033526   32.48   <2e-16 ***
#   nodes        0.0012345  0.0001213   10.18   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# (Dispersion parameter for gaussian family taken to be 0.1171996)
# Null deviance: 674.88  on 4458  degrees of freedom
# Residual deviance: 522.24  on 4456  degrees of freedom
# AIC: 3099.5
# Number of Fisher Scoring iterations: 2

# Call:
#   glm(formula = as.numeric(as.factor(r_it$inDEG)) - 1 ~ species + nodes + mean_edge, data = r_it)
# Deviance Residuals: 
#   Min        1Q    Median        3Q       Max  
# -1.25875  -0.25623  -0.04582   0.07754   1.06233  
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -0.309783   0.037196  -8.328  < 2e-16 ***
#   species      0.115245   0.003796  30.355  < 2e-16 ***
#   nodes        0.001329   0.000124  10.713  < 2e-16 ***
#   mean_edge    0.178509   0.050354   3.545 0.000397 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# (Dispersion parameter for gaussian family taken to be 0.1168962)
# Null deviance: 674.88  on 4458  degrees of freedom
# Residual deviance: 520.77  on 4455  degrees of freedom
# AIC: 3089
# Number of Fisher Scoring iterations: 2




ggplot(rank_it_new) +
  geom_density(rank_it_new,aes(x=rank,y=inDEG)) + scale_colour_grey() + theme_classic(base_size = 18)
  geom_line(aes(x=rank,y = probability)) + 
  scale_y_continuous(sec.axis = sec_axis(~.+10))

ggplot(rank_bs_new, aes(x=rank, fill=inDEG ,color=inDEG)) +
  geom_density(alpha=0.4) + scale_colour_grey() + theme_classic(base_size = 18)+
  labs(x="Rank",y="Density") + ylim(0,6e-4) + scale_fill_grey()

ggplot(rank_ev_new, aes(x=rank, linetype=inDEG)) +
  geom_density() + scale_colour_grey() + theme_classic(base_size = 18)+
  labs(x="Rank",y="Density") + ylim(0,6e-4)

ggplot(rank_it_new) +
  geom_density(aes(x=rank, fill=inDEG ,color=inDEG),alpha=0.4)+
  scale_colour_grey() + theme_classic(base_size = 18)+
  scale_y_continuous(name= "Density", limits = c(0,6.5e-4), sec.axis = sec_axis(~.*1500, name = "Probability"))+
  labs(x="Rank") + scale_fill_grey()+
  geom_line(aes(x=rank,y = probability/1500),linetype="dotted",size=1.2)


ggplot(rank_bs_new) +
  geom_density(aes(x=rank, fill=inDEG ,color=inDEG),alpha=0.4)+
  geom_line(aes(x=rank,y = probability/1500),linetype="dotted",size=1.2)+
  scale_colour_grey() + theme_classic(base_size = 18)+
  scale_y_continuous(name= "Density", limits = c(0,6.5e-4), sec.axis = sec_axis(~.*1500, name = "Probability"))+
  labs(x="Rank") + scale_fill_grey()

ggplot(rank_ev_new) +
  geom_density(aes(x=rank, fill=inDEG ,color=inDEG),alpha=0.4)+
  geom_line(aes(x=rank,y = probability/1500),linetype="dotted",size=1.2)+
  scale_colour_grey() + theme_classic(base_size = 18)+
  scale_y_continuous(name= "Density", limits = c(0,6.5e-4), sec.axis = sec_axis(~.*1500, name = "Probability"))+
  labs(x="Rank") + scale_fill_grey()

####

r_it_g <- r_it[order(-r_it[,7], -r_it[,6], -r_it[,5]),]
r_bs_g <- r_bs[order(-r_bs[,8], -r_bs[,7], -r_bs[,6]),]
r_ev_g <- r_ev[order(-r_ev[,7], -r_ev[,6], r_ev[,5], -r_ev[,4]),]


r_it_g1 <- data.frame(matrix(1:c(dim(r_it_g)[1]),dim(r_it_g)[1],1))
r_bs_g1 <- data.frame(matrix(1:c(dim(r_bs_g)[1]),dim(r_bs_g)[1],1))
r_ev_g1 <- data.frame(matrix(1:c(dim(r_ev_g)[1]),dim(r_ev_g)[1],1))

r_it_g <- cbind(r_it_g1,r_it_g)
r_bs_g <- cbind(r_bs_g1,r_bs_g)
r_ev_g <- cbind(r_ev_g1,r_ev_g)

r_it_g <- r_it_g[,c(1,2)]
r_bs_g <- r_bs_g[,c(1,2,3)]
r_ev_g <- r_ev_g[,c(1,2)]

colnames(r_ev_g)[1] <- "group"

r_it_g <- merge(r_it_g,rank_it_new,by="group")
r_ev_g <- merge(r_ev_g,rank_ev_new,by="group")

r_it_g <- r_it_g[,c(1,2,5)]
r_ev_g <- r_ev_g[,c(1,2,5)]

ggplot(r_it_g) +
  geom_density(aes(x=Rank, fill=inDEG ,color=inDEG),alpha=0.4)+
  scale_colour_grey() + theme_classic(base_size = 18)+
  labs(x="Rank") + scale_fill_grey() + ylim(0,6.5e-4)

ggplot(r_bs_g) +
  geom_density(aes(x=Rank, fill=inDEG ,color=inDEG),alpha=0.4)+
  scale_colour_grey() + theme_classic(base_size = 18)+
  labs(x="Rank") + scale_fill_grey()+ ylim(0,6.5e-4)

ggplot(r_ev_g) +
  geom_density(aes(x=Rank, fill=inDEG ,color=inDEG),alpha=0.4)+
  scale_colour_grey() + theme_classic(base_size = 18)+
  labs(x="Rank") + scale_fill_grey()+ ylim(0,6.5e-4)

library(ROCR)
library(pROC)

pROC_obj <- roc(r_it_g$inDEG,r_it_g$Rank, smoothed = TRUE, ci=TRUE, ci.alpha=0.9, stratified=FALSE,
                plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,print.auc=TRUE, show.thres=TRUE)

pROC_obj <- roc(r_bs_g$inDEG,r_bs_g$Rank, smoothed = TRUE, ci=TRUE, ci.alpha=0.9, stratified=FALSE,
                plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,print.auc=TRUE, show.thres=TRUE)

pROC_obj <- roc(r_ev_g$inDEG,r_ev_g$Rank, smoothed = TRUE, ci=TRUE, ci.alpha=0.9, stratified=FALSE,
                plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,print.auc=TRUE, show.thres=TRUE)

## Random
r_bs_g <- r_bs[order(r_bs[,1]),]

r_it_g1 <- data.frame(matrix(1:c(dim(r_it_g)[1]),dim(r_it_g)[1],1))
r_bs_g1 <- data.frame(matrix(1:c(dim(r_bs_g)[1]),dim(r_bs_g)[1],1))
r_ev_g1 <- data.frame(matrix(1:c(dim(r_ev_g)[1]),dim(r_ev_g)[1],1))

r_it_g <- cbind(r_it_g1,r_it_g)
r_bs_g <- cbind(r_bs_g1,r_bs_g)
r_ev_g <- cbind(r_ev_g1,r_ev_g)

colnames(r_bs_g)[1] <- "rank"

ggplot(r_it_g) +
  geom_density(aes(x=rank, fill=inDEG ,color=inDEG),alpha=0.4)+
  scale_colour_grey() + theme_classic(base_size = 18)+
  labs(x="Rank") + scale_fill_grey() + ylim(0,6.5e-4)

ggplot(r_bs_g) +
  geom_density(aes(x=rank, fill=inDEG ,color=inDEG),alpha=0.4)+
  scale_colour_grey() + theme_classic(base_size = 18)+
  labs(x="Rank") + scale_fill_grey() + ylim(0,6.5e-4)

ggplot(r_ev_g) +
  geom_density(aes(x=rank, fill=inDEG ,color=inDEG),alpha=0.4)+
  scale_colour_grey() + theme_classic(base_size = 18)+
  labs(x="Rank") + scale_fill_grey() + ylim(0,6.5e-4)

pROC_obj <- roc(r_it_g$inDEG,r_it_g$rank, smoothed = TRUE, ci=TRUE, ci.alpha=0.9, stratified=FALSE,
                plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,print.auc=TRUE, show.thres=TRUE)

pROC_obj <- roc(r_bs_g$inDEG,r_bs_g$rank, smoothed = TRUE, ci=TRUE, ci.alpha=0.9, stratified=FALSE,
                plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,print.auc=TRUE, show.thres=TRUE)

pROC_obj <- roc(r_ev_g$inDEG,r_ev_g$rank, smoothed = TRUE, ci=TRUE, ci.alpha=0.9, stratified=FALSE,
                plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,print.auc=TRUE, show.thres=TRUE)
