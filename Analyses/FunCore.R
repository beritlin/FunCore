##### Core gene clusters  #####
##### 2020.05.13  #####
##### Pei-Yu Lin  #####

setwd("/work1/home/peiyu/FunCoreTest/FunCore/Louvain")  

# packages
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

# import mmseqs2 output-1,2
result1 <- fread("all_fungi_bs_1.m8",header = F)
result2 <- fread("all_fungi_bs_2.m8",header = F)
result <- rbind(result1,result2)
rm(result1)
rm(result2)


##### change data format to graph-1,2
a1 <-   mclapply(result,unique)
a <- c(a1[[1]],a1[[2]])
vertex.attrs <- list(name = a)
edges <- rbind(match(result$V1, vertex.attrs$name),match(result$V2,vertex.attrs$name))
G <- graph.empty(n = 0, directed = F)
G <- add.vertices(G, length(vertex.attrs$name), attr = vertex.attrs)
G <- add.edges(G, edges)
remove(edges)
remove(vertex.attrs)
print("change data to graph1,2")


# import mmseqs2 output-3
result3 <- fread("all_fungi_bs_3.m8",header = F)

##### change data format to graph-3
a1 <-   mclapply(result3,unique)
a <- c(a1[[1]],a1[[2]])
vertex.attrs <- list(name = a)
edges <- rbind(match(result3$V1, vertex.attrs$name),match(result3$V2,vertex.attrs$name))
G3 <- graph.empty(n = 0, directed = F)
G3 <- add.vertices(G3, length(vertex.attrs$name), attr = vertex.attrs)
G3 <- add.edges(G3, edges)
remove(edges)
remove(vertex.attrs)
G <- union(G, G3)
result <- rbind(result,result3)
rm(result3)
print("change data to graph3")

# import mmseqs2 output-4
result4 <- fread("all_fungi_bs_4.m8",header = F)

##### change data format to graph-4
a1 <-   mclapply(result4,unique)
a <- c(a1[[1]],a1[[2]])
vertex.attrs <- list(name = a)
edges <- rbind(match(result4$V1, vertex.attrs$name),match(result4$V2,vertex.attrs$name))
G4 <- graph.empty(n = 0, directed = F)
G4 <- add.vertices(G4, length(vertex.attrs$name), attr = vertex.attrs)
G4 <- add.edges(G4, edges)
remove(edges)
remove(vertex.attrs)
G <- union(G, G4)
print("change data to graph4")
result <- rbind(result,result4)
rm(result4)

# import mmseqs2 output-5
result5 <- fread("all_fungi_bs_5.m8",header = F)

##### change data format to graph-5
a1 <-   mclapply(result5,unique)
a <- c(a1[[1]],a1[[2]])
vertex.attrs <- list(name = a)
edges <- rbind(match(result5$V1, vertex.attrs$name),match(result5$V2,vertex.attrs$name))
G5 <- graph.empty(n = 0, directed = F)
G5 <- add.vertices(G5, length(vertex.attrs$name), attr = vertex.attrs)
G5 <- add.edges(G5, edges)
remove(edges)
remove(vertex.attrs)
G <- union(G, G5)
print("change data to graph5")
result <- rbind(result,result5)
rm(result5)
dim(result)


##### Louvain
wit <- as.matrix(result[,3])
clusterlouvain <- cluster_louvain(G,weights = wit)
rm(wit)
rm(G)
print(clusterlouvain)

sizeL <- data.frame(sizes(clusterlouvain))
size_hn <- sizeL[sizeL$Freq>1,]
rm(sizeL)

##### Output to dataframe
f <- function(i) {
  as.factor(clusterlouvain[[c(size_hn[i,1])]])
}

cores <- detectCores()
cl <- makeForkCluster(cores)
df1 <- as.data.frame(t(stri_list2matrix(parSapply(cl,1:dim(size_hn)[1], f))))
stopCluster(cl)
rm(cores)
rm(cl)

dfhn <- cbind(size_hn,df1)

print("finish table")

##### estimate mean_edge_weigth, edges, triplets
r_hn <- dfhn[,1:2]
hn_m <- data.frame(clusterlouvain$names,clusterlouvain$membership)
colnames(hn_m) <- c("V1","group")
colnames(hndt) <-  c("V1","V2","V11")
hn_m2 <- merge(hndt,hn_m,by="V1")
rm(clusterlouvain)
rm(hndt)

hn_m3 <- data.frame(dfhn[,1])
colnames(hn_m3)[1] <- "group"
hn_m4 <- merge(hn_m3,hn_m2,by="group")
u <- unique(hn_m3$group)

net <- function(i){
  clustergraphda2<-graph_from_data_frame(hn_m4[hn_m4$group==u[i],c(2:4)])
  test.graph.adj<-get.adjacency(clustergraphda2,sparse=F)
  test.graph.properties<-GenInd(test.graph.adj)
  simean <-  mean(as.numeric(as.matrix(hn_m4[hn_m4$group==u[i],4])))
  link <- test.graph.properties$Ltot
  trip <-  length(triangles(clustergraphda2))/3
  return(data.frame(simean,link,trip))
}

cl <- makeCluster(80)
registerDoParallel(cl)
deg_hn <- foreach(x=1:length(u),.combine='rbind',.packages = c('igraph','NetIndices')) %dopar% net(x)
stopCluster(cl)
rm(cl)
>
r_hn <- cbind(r_hn,deg_hn)

rm(hn_m2)
rm(hn_m3)
rm(hn_m4)
rm(deg_hn)

print("finishing estimate mean_edge_weigth, edges, triplets")

##### estimate species
input_names = names(dfhn)[3:dim(dfhn)[2]]
new_names = expand.grid(input_names, 1:2) %>% 
  unite(v, Var1, Var2, sep=".") %>% 
  pull(v) %>% 
  sort()

dfhn1 <-
  dfhn %>%
  unite_("v", input_names) %>%                  
  mutate(v = gsub("NA", "NA/NA", v)) %>%        
  separate(v, new_names, convert = F) 

dfhn1 <- dfhn1[3:dim(dfhn1)[2]]
dfhn1 <- dfhn1[,seq(1,ncol(dfhn1), 2) ]
rm(new_names)
rm(input_names)

dfhn2 <- as.data.frame(apply(dfhn1,1, function(x)length(unique(x))))
dfhn <- dfhn2-1
rm(dfhn1)
rm(dfhn2)
print("finishing estimate speceis")

r_hn <- cbind(r_hn,dfhn)
rm(dfhn)
colnames(r_hn) <- c("group","nodes","mean_edge","links","triplet","species")

print("saving")
write.table(r_hn,"rank_all_fungi_bs.txt",col.names=T,row.names=F)
