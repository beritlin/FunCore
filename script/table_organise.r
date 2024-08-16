## Table organise
## Pei-Yu Lin
## 2024-07-29

library(data.table)

# read new data
new_data <- read.csv("/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/20240729_JGI_list.csv")
head(new_data)
dim(new_data)

# if character count in Published is zero, then set it to NA
new_data$Published[new_data$Published == ""] <- NA

# read old data
old_data <- read.csv("/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/new/20220104_datamerge_all.csv")
head(old_data)
dim(old_data)

# keep only first and Acknowledgement columns
old_data <- old_data[,c("Name", "Acknowledgement")]
old_data$orignal <- "old"

# merge new and old data base on new data
merged_data <- merge(new_data, old_data, by = "Name", all.x = TRUE)

# remove the row with no value in both Published and Acknowledgement columns
merged_data <- merged_data[!is.na(merged_data$Published) | !is.na(merged_data$Acknowledgement),]

# add "new" to the orignal column
merged_data$orignal[is.na(merged_data$orignal)] <- "new"

#remove NA from Acknowledgement column
merged_data$Acknowledgement[is.na(merged_data$Acknowledgement)] <- ""

# seperate the Published column by "," and keep the first one to Published column and second one to "Year" column
merged_data$Year <- NA
merged_data$Published <- as.character(merged_data$Published)
for (i in 1:nrow(merged_data)){
  if (!is.na(merged_data$Published[i])){
    temp <- unlist(strsplit(merged_data$Published[i], "et al.,"))
    merged_data$Published[i] <- temp[1]
    merged_data$Year[i] <- temp[2]
  }
}

# seperate the Name colum by " " using data.table package
setDT(merged_data)
merged_data <- merged_data[, c("epithet", "generic", paste0("P",1:8)) := tstrsplit(Name, " ", fixed = TRUE)]

# merge the generic and epithet columns to "Species" column and sperate by " "
merged_data$Species <- paste(merged_data$generic, merged_data$epithet, sep = " ")

# remove the P1 to P8 columns
merged_data <- merged_data[, -c(paste0("P",1:8))]

# if the species count is greater than 1, then keep the one with "old" in the orignal column
dim(merged_data)
merged_data <- merged_data[!(duplicated(merged_data$Species) & merged_data$orignal == "new"),]
dim(merged_data)

# if the species count is greater than 1, then keep the one with higher Published year
merged_data$Year <- as.numeric(merged_data$Year)
merged_data <- merged_data[order(merged_data$Year, decreasing = TRUE),]
merged_data <- merged_data[!duplicated(merged_data$Species),]


# write to file
write.csv(merged_data, "/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/20240729_merge_list.csv", row.names = FALSE)

head(merged_data)
dim(merged_data)
tail(merged_data)