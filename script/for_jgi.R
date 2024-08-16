# generate the txt
# fungi <- read.csv("/work1/home/peiyu/2024_FunCore/Sample/20240805_merge_list.csv")
fungi <- read.table("/work1/home/peiyu/tools/jgi-query/list.txt",header = T, sep = "\t")
head(fungi)
fungi$Abbv <- gsub("/", "", fungi$Abbv)

# loop through the table and write the command to a txt file
for (i in 1:nrow(fungi)) {
    # line <- paste0("python3 jgi-query.py ", fungi$Abbv[i], " -r 'GeneCatalog_proteins.*\\.aa.fasta.gz$'")
     line <- paste0("python3 jgi-query.py ", fungi$Abbv[i], " -r '.proteins.fasta.gz$'")
    write(line, file = "/work1/home/peiyu/2024_FunCore/Sample/jgi-query.sh", append = TRUE)
}
