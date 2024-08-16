## merge mutiple data by R

# read table
species <- read.csv("/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/20240805_merge_list.csv")
head(species)

# read mutiple data from a folder
setwd("/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/Tree")
files <- list.files(pattern = "*.csv")
files

# create a data frame to store the count of species, Assembly.Length and X..Genes
tree <- data.frame(Name = character(), Genome_size = numeric(), Genes = numeric())

# merge data and fill the count_species
for (i in 1:length(files)){
  data <- read.csv(files[i])
  data <- data[,c("Name", "Assembly.Length", "X..Genes")]
  count_species <- merge(species[,1:2], data, by = "Name")
  count_species$clade <- files[i]
  tree <- rbind(tree, count_species)
}

head(tree)

# reamove the "," between the number
tree$Assembly.Length <- as.numeric(gsub(",", "", tree$Assembly.Length))
tree$X..Genes <- as.numeric(gsub(",", "", tree$X..Genes))

# write the data to a csv file
write.csv(tree, "/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/20240814_merge_tree.csv", row.names = F)

# calcuate the mean of Assembly.Length and X..Genes by clade
mean_tree <- aggregate(tree[,3:4], by = list(tree$clade), mean)

