library(data.table)
library(dplyr)
library(tidyr)
library(mclust)


#### organising data: select only arabidopsis genes (DEG2003xxxx)
deg <- fread("deg.m8")

deg <- setDT(deg)[, paste0("n", 1:11) := tstrsplit(V2, "", type.convert = TRUE, fixed = TRUE)]
deg <- unite(deg,"n",n1:n7,sep = "",remove = T)
deg_arabi <- deg[deg$n=="DEG2003",]
deg_arabi_map <- setDT(deg_arabi)[, .SD[which.max(V12)], by=V2]  ## select only the most similar one
fwrite(deg_arabi_map,"plants_deg.m8")

#### add DEG information to data
member <- fread("node_membership_table.tsv")

colnames(member)[3] <- "V1"
member_deg <- merge(member[,c(1,3)],deg_arabi_map[,c(1,2)], by="V1")
member_deg <-  distinct(member_deg, group)
member_deg$DEG <- 1 ## if the subnet contain known EG than label "1"
u <- data.frame(group=unique(member$group))
member_deg <- merge(u,member_deg, by="group",all.x=T)
member_deg[is.na(member_deg)] <- 0 ## if the subnet does not contain known EG than label "0"
member_deg$DEG <- as.factor(member_deg$DEG)
fwrite(member_deg,"plants_deg.txt",row.names=F)


### find the local and global subnets
deg_sp <- member_deg_sp[member_deg_sp$DEG=="1","num.orgs"]
gmm <- densityMclust(deg_sp,G=1:2)