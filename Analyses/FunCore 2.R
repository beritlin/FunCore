##### Core gene clusters  #####
##### for uniqe species  #####
##### 2020.09.16  #####
##### Pei-Yu Lin  #####
library(igraph)
library(NetIndices)
library(data.table)
library(parallel)
library(stringi)
library(stringr)
library(tidyr)
library(doParallel)
library(foreach)
library(dplyr)
library(gtools)
library(compiler)

setwd("/work1/home/peiyu/FunCoreTest/FunCore/mmseq2")


files = list.files(pattern="*.m8")
files <- files[2:33]

#data_list = lapply(files, fread, header = F)
#df <- do.call(rbind, data_list)

readmm <- function(f) {
   file <- fread(files[f],header = F)
   file <- file[file$V11<=1e-10&file$V12>=500,c(1,2,12)]
   file <- file[V1!=V2]
   return(data.table(file))
}

cl <- makeCluster(10)
registerDoParallel(cl)
result <- foreach(x=1:length(files),.combine='rbind',.packages = 'data.table') %dopar% readmm(x)
stopCluster(cl)
rm(cl)
dim(result)
gc()
##### change data format 

a1 <-   mclapply(result,unique)
a <- c(a1[[1]],a1[[2]])
vertex.attrs <- list(name = a)
edges <- rbind(match(result$V1, vertex.attrs$name),match(result$V2,vertex.attrs$name))
G <- graph.empty(n = 0, directed = F)
G <- add.vertices(G, length(vertex.attrs$name), attr = vertex.attrs)
G <- add.edges(G, edges)
rm(a1)
rm(a)
rm(edges)
rm(vertex.attrs)
gc()
##### louvain clustering
e_edge <- as.matrix(result)[,3]
clusterlouvain <- cluster_louvain(G,weights = e_edge)
rm(G)
rm(e_edge)
gc()

##### nodes
size_all <- data.frame(sizes(clusterlouvain))
size <- size_all[size_all$Freq>1,]
dim(size)
rm(size_all)

#dfev <- data.frame(size$Community.sizes)
#df1 <- data.frame(matrix(NA,dim(dfev)[1],max(size$Freq)))

#f <- function(i) {
#   as.factor(clusterlouvain[[c(size[i,1])]])
#}

#cores <- detectCores()
#cl <- makeForkCluster(cores)
#df1 <- as.data.frame(t(stri_list2matrix(parSapply(cl,1:dim(size)[1], f))))
#stopCluster(cl)


colnames(size) <- c("group","nodes")
hn_m <- data.frame(clusterlouvain$names,clusterlouvain$membership)
colnames(hn_m) <- c("V1","group")
hn_m <- merge(hn_m,size,by="group")
# result <- fread("/work1/home/peiyu/FunCoreTest/FunCore/mmseq2/715FunCore.m8",header=F)
# hn_m <- fread("/work1/home/peiyu/FunCoreTest/FunCore/membership.txt",header=T)
# hn_m <- hn_m[,2:3]
colnames(result) <-  c("V1","V2","V12")
#hn_m2 <- merge(hn_m,as.data.frame(result),by="V1")
hn_m2 <- inner_join(hn_m,result,by="V1")
rm(clusterlouvain)
rm(result)
gc()

# hn_m3 <- data.frame(dfhn[,1])
# colnames(hn_m3)[1] <- "group"
u <- unique(hn_m2$group)

m <-function(x){
  sum(as.numeric(as.matrix(hn_m2[hn_m2$group==x,4])))/length(as.numeric(as.matrix(hn_m2[hn_m2$group==x,4])))
}
lm <- cmpfun(m)

net <- function(i){
  clustergraphda2<-graph_from_data_frame(hn_m2[hn_m2$group==u[i],c(1,3,4)])
  test.graph.adj<-get.adjacency(clustergraphda2,sparse=F)
  test.graph.properties<-GenInd(test.graph.adj)
  mean_edge <-  lm(u[i])
  links <- test.graph.properties$Ltot
  triplet <-  length(triangles(clustergraphda2))/3
  species <- length(unique(separate(as.data.frame(hn_m[hn_m$group==u[i]]), V1, into = c("sp", "n"), sep = "\\|")[,2]))
  nodes <- dim(as.data.frame(hn_m[hn_m$group==u[i],'V1']))[1]
  return(data.frame(u[i],species,nodes,mean_edge,links,triplet))
}

deg_hn <- data.frame()
for (i in 1:length(u)){
  n <- net(i)
  deg_hn <- smartbind(deg_hn, n)
  print(i)
  write.table(deg_hn,'/work1/home/peiyu/FunCoreTest/FunCore/GLM/715net.txt',col.names=T,row.names=F)
}


# cl <- makeCluster(20)
# registerDoParallel(cl)
# deg_hn <- foreach(x=1:length(u),.combine='rbind',.packages = c('igraph','NetIndices','tidyr')) %dopar% net(x)
# stopCluster(cl)
# rm(cl)
gc()
colnames(deg_hn)[1] <- c("group")
r_hn <- merge(hn_m2,deg_hn,by="group")

rm(hn_m2)
rm(deg_hn)
rm(u)
gc()

write.table(r_hn,"/work1/home/peiyu/FunCoreTest/FunCore/Louvain/FunCore715/715FunCore.txt",col.names=F,row.names=F)

