# Loading packages
foo <- function(x){
  for( i in x ){
    #  require returns TRUE invisibly if it was able to load package
    if( ! require( i , character.only = TRUE ) ){
      #  If package was not able to be loaded then re-install
      install.packages( i , dependencies = TRUE )
      #  Load package after installing
      require( i , character.only = TRUE , quietly = TRUE)
    }
  }
}
foo( c("argparser" , "data.table", "dplyr", "tidyr", "igraph","parallel","lubridate") )

cat("[",format(Sys.time(), "%X"),"]","Start proccessing","\n")
p <- arg_parser("Louvain")

# Add command line arguments
p <- add_argument(p, "input", ,help="input mmeaqs2 result")
p <- add_argument(p, "-e",, help="similarity of evalue", type="numeric",default="1e-5")
p <- add_argument(p, "-i", help="similarity of identity", type="numeric",default="0.5")
#p <- add_argument(p, "-sep", help="name",default="|")

p <- add_argument(p, "output", help="output file", type="character")


# Parse the command line arguments
argv <- parse_args(p)

###
ptm <- proc.time()
mmseq <- as.data.table(fread(argv$input))
cat(paste("Time for read data:",seconds_to_period(as.numeric(proc.time() - ptm)[3]) ,"\n"))
#mmseq <- read.csv(argv$input)

## remove AA
ptm <- proc.time()
mmseq <- mmseq[V1!=V2]
invisible(gc())

## remove unsimilar pair
mmseq <- mmseq[mmseq$V11<=argv$e&mmseq$V3>=argv$i,]
invisible(gc())

## remove AB-BA
mmseq <- mmseq[!duplicated(t(apply(mmseq[,1:2], 1, sort))),]
invisible(gc())

## sperate the ortholog ####
mmseq1 <- setDT(mmseq)[, paste0("n1", 1:2) := tstrsplit(V1, "|", type.convert = TRUE, fixed = TRUE)]
mmseq2 <- setDT(mmseq)[, paste0("n2", 1:2) := tstrsplit(V2, "|", fixed = TRUE)]

mmseq <- mmseq[,c("n11","n12","n21","n22","V12","V11")]
rm(mmseq1,mmseq2)
invisible(gc())

mmseq_orth <- mmseq[n11!=n21]

mmseq_orth <- unite(mmseq_orth,"V1",n11:n12,sep = "|",remove = T)
mmseq_orth <- unite(mmseq_orth,"V2",n21:n22,sep = "|",remove = T)

cat(paste("Time for processing data:",seconds_to_period(as.numeric(proc.time() - ptm)[3]) ,"\n"))

ptm <- proc.time()
a1 <-   mclapply(mmseq_orth,unique)
a <- c(a1[[1]],a1[[2]])
vertex.attrs <- list(name = a)
edges <- rbind(match(mmseq_orth$V1, vertex.attrs$name),match(mmseq_orth$V2,vertex.attrs$name))
G <- graph.empty(n = 0, directed = F)
G <- add.vertices(G, length(vertex.attrs$name), attr = vertex.attrs)
G <- add.edges(G, edges)
E(G)$weight <- mmseq_orth$V12
rm(a1)
rm(a)
rm(edges)
rm(vertex.attrs)
invisible(gc())
cat("[",format(Sys.time(), "%X"),"]","The network contains ", length(V(G)), " of nodes and", gsize(G),"of edges","\n")

## louvain clustering
e_edge <- as.matrix(mmseq_orth)[,3]
clusterlouvain <- cluster_louvain(G,weights = e_edge)
rm(e_edge)
invisible(gc())
cat(paste("Time for clustering:",seconds_to_period(as.numeric(proc.time() - ptm)[3]) ,"\n"))

## nodes
size_all <- data.frame(sizes(clusterlouvain))
size <- size_all[size_all$Freq>2,]
rm(size_all)

## member
colnames(size) <- c("group","#nodes")
hn_m <- data.frame(clusterlouvain$names,clusterlouvain$membership)
colnames(hn_m) <- c("protein","group")
hn_m <- merge(hn_m,size,by="group")
hn_m <- hn_m[,c(1,3,2)]
invisible(gc())
cat("[",format(Sys.time(), "%X"),"]","The network is clustered into", length(unique(hn_m$group)),"subnets","\n")

infile <- as.character(gsub(" ", "", paste(argv$output,".txt")))
ingraph <- as.character(gsub(" ", "", paste(argv$output,"_graph.txt")))

ptm <- proc.time()
write.table(hn_m,infile,col.names=T,row.names=F,fileEncoding="UTF-8")
write_graph(G, ingraph, "ncol")
cat(paste("Time for save data:",seconds_to_period(as.numeric(proc.time() - ptm)[3]) ,"\n"))
cat("[",format(Sys.time(), "%X"),"]","Done.","\n")

# Rscript louvain.R ~/test/examples/output.m8 ~/test/examples/louvain