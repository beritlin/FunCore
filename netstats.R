# # Loading packages
# foo <- function(x){
#   for( i in x ){
#     #  require returns TRUE invisibly if it was able to load package
#     if( ! require( i , character.only = TRUE , quietly = TRUE) ){
#       #  If package was not able to be loaded then re-install
#       install.packages( i , dependencies = TRUE )
#       #  Load package after installing
#       require( i , character.only = TRUE , quietly = TRUE)
#     }
#   }
# }
# foo( c("argparser" , "data.table", "dplyr", "tidyr", "igraph","parallel","progress") )

# # Create a parser
# p <- arg_parser("Search")

# # Add command line arguments
# p <- add_argument(p, "graph", help="input  FASTA/FASTQ file", type="character")
# p <- add_argument(p, "membership", help="input  FASTA/FASTQ DB", type="character")
# p <- add_argument(p, "output", help="output file", type="character")

# # Parse the command line arguments
# argv <- parse_args(p)

## read graph
G <- read_graph(argv$graph, "ncol",directed=FALSE)
## membership table
hn_m <- fread(argv$membership,header=TRUE)

# infile <- as.character(gsub(" ", "", paste(argv$output,".txt")))


u <- unique(hn_m$group)
# pb <- progress_bar$new(total = length(u), clear = FALSE,format = "[:bar] :current / :total :percent :eta")
hn_m <- data.frame(hn_m)
deg_hn <- data.frame()
## Calculating network structures

for (i in 1:length(u)) {
  ## get the subnet from network
  g <- induced_subgraph(G, hn_m[hn_m$group==u[i],"protein"])
  ## calculate the mean similarity (edge weight) of subnet
  mean_edge <-  mean(strength(g, mode="out"))
  ## calculate the edge number 
  links <- gsize(g)
  ## calculate the triplet number 
  triplet <-  length(triangles(g))/3
  ## calculate the cluster coefficient 
  lcc <- transitivity(g, type = "localundirected")
  cc <- mean(replace(lcc, is.na(lcc), 0))
  ## calculate the cluster coefficient 
  n <- data.frame(group=u[i],mean_edge=mean_edge,links=links,triplet=triplet,nodes=unique(hn_m[hn_m$group==u[i],"X.nodes"]),cc=cc)
  ## bind the data frame
  deg_hn <- rbind(deg_hn, n)
  write.table(deg_hn,infile,col.names=T,row.names=F)
  # pb$tick()
}


# ## faster method
# cl <- makeCluster(detectCores()-1)      # 開啟的執行緒數量
# registerDoParallel(cl) 

# deg_hn <- foreach(i = 1:length(u),.combine = rbind,.packages = "igraph")%dopar%{
#   g <- induced_subgraph(G, hn_m[hn_m$group==u[i],"protein"])
#   mean_edge <-  mean(strength(g, mode="out"))
#   links <- gsize(g)
#   triplet <-  length(triangles(g))/3
#   lcc <- transitivity(g, type = "localundirected")
#   cc <- mean(replace(lcc, is.na(lcc), 0))
#   n <- data.frame(group=u[i],mean_edge=mean_edge,links=links,triplet=triplet,nodes=unique(hn_m[hn_m$group==u[i],"X.nodes"]),cc=cc)
#   pb$tick()
#   return(n)
# }
# stopCluster(cl)                        # 關閉平行運算

# write.table(deg_hn,infile,col.names=T,row.names=F)

# ##

## calculate density
deg_hn$Edensity <- deg_hn$links/((deg_hn$nodes*(deg_hn$nodes-1))/2)

## calculate species number
hn_m1 <- setDT(hn_m)[, paste0("n", 1:2) := tstrsplit(protein, "|", type.convert = TRUE, fixed = TRUE)]

deg_hn$species <- NA
deg_hn <- as.data.frame(deg_hn)
pb <- progress_bar$new(total = length(u), clear = FALSE,format = "[:bar] :current / :total :percent :eta")
cat("Calculating species numner","\n")
for (i in 1:length(u)) {
    deg_hn[i,9]<- as.numeric(dim(unique(hn_m1[hn_m1$group==u[i],'n1']))[1])
    pb$tick()
}

## calculate gene per species
deg_hn$persp <-  deg_hn$nodes/deg_hn$species

write.table(deg_hn,infile,col.names=T,row.names=F)

