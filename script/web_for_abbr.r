# web crawling using R
library(rvest)
library(dplyr)

# jgi website
url <- "https://mycocosm.jgi.doe.gov/fungi/fungi.info.html"


# get the text from the link <a herf="link">text</a> 
fungi_name <- read_html(url) %>% 
  html_nodes("table") %>% 
  html_nodes("a") %>% 
   # get text from the link
    html_text()  %>% 
    data.frame()

head(fungi_name)

# get the first link from  <a herf="link">text</a> for each td subnode
fungi_link <- read_html(url) %>% 
  html_nodes("table") %>% 
  html_nodes("td") %>% 
  html_nodes("a") %>% 
  html_attr("href") %>% 
  data.frame()
head(fungi_link)

# # keep the data only start with "/"
# fungi_link <- fungi_link %>% filter(grepl("^/", fungi_link$.))
# head(fungi_link)

# combine the name and link
fungi <- cbind(fungi_name, fungi_link)

head(fungi)
colnames(fungi) <- c("Name", "Abbv")

# read table
jgi <- read.table("/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/20240729_merge_list.csv", sep = ",", header = TRUE)
head(jgi)

# merge the two table by the name
fungi <- merge(fungi, jgi, by.x = "Name", by.y = "Name")
head(fungi)
dim(fungi)

# remove "/" in the column Abbv
fungi$Abbv <- gsub("/", "", fungi$Abbv)


# write the table
write.csv(fungi, "/work1/home/peiyu/2024_FunCore/Sample/20240805_merge_list.csv", row.names = FALSE)


