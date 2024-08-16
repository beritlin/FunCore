# web crawling using R
library(rvest)
library(dplyr)
library(RSelenium)
library(data.table)


# NCBI website
url <- "https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi"
fungi <- read.csv("/work1/home/peiyu/2024_FunCore/Sample/20240805_merge_list.csv")

# split the Name col to two cols by " v1" using data.table
list <- data.table(fungi$Name)
list <- list[, c("species", "v1") := tstrsplit(V1, " v1", fixed = TRUE)]

# search by list$Species
for (i in 1:nrow(fungi)){
  # open the browser
  remDr <- remoteDriver(remoteServerAddr = "localhost", port = 444L, browserName = "chrome")
  remDr$open()
  
  # navigate to the website
  remDr$navigate(url)
  
  # find the search box
  webElem <- remDr$findElement(using = 'css selector', value = 'input[name="name"]')
  
  # type the species name
  webElem$sendKeysToElement(list$Species[i])
  
  # find the search button
  webElem <- remDr$findElement(using = 'css selector', value = 'input[type="submit"]')
  
  # click the search button
  webElem$clickElement()
  
  # get the url of the search result
  url <- remDr$getCurrentUrl()
  
  # close the browser
  remDr$close()
  
  # get the text from dd tag
  fungi_details <- read_html(url) %>% 
    html_node("dd") %>% 
    html_text(trim = TRUE) %>% 
    data.frame()
  
  # Display the head of the data frame
  head(fungi_details)
}


# get the text from dd tag
fungi_details <- read_html(url) %>% 
  html_node("dd") %>% 
  html_text(trim = TRUE) %>% 
  data.frame()

# Display the head of the data frame
head(fungi_details)
