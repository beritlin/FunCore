library(rvest)
library(dplyr)
library(httr)
library(data.table)

# Define the base URL for NCBI search
base_url <- "https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi"

# Read the list of species from the CSV file
list <- read.csv("/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/20240805_merge_list.csv")

# split the Name col to two cols by " v1" using data.table
list <- data.table(list$Name)
list <- list[, c("species", "v1") := tstrsplit(V1, " v1", fixed = TRUE)]

# merge the two cols to one col sep by " "
list$species_short <- paste(list$epithet, list$generic, sep = " ")

# Create an empty data frame to store the results
results <- data.frame()

# Function to scrape data for a single species
scrape_species_data <- function(species_name) {
  # Perform a GET request to the base URL to retrieve any necessary cookies
  session <- GET(base_url)

  # Extract cookies from the session
  session_cookies <- cookies(session)

  # Construct the cookie string
  cookie_string <- paste0(session_cookies$name, "=", session_cookies$value, collapse = "; ")
  
  # Perform a POST request to submit the form
  session <- POST(base_url, 
                  add_headers("Cookie" = cookie_string),
                  body = list(name = species_name, 
                              rank = "all", 
                              search = "Search", 
                              mode = "exact", 
                              display = "tree"), 
                  encode = "form")

  # Extract the HTML content from the session
  html_content <- content(session, as = "text", encoding = "UTF-8")

  # Parse the HTML content
  html <- read_html(html_content)

  # Extract the dd element containing the NCBI Taxon ID
  ncbi_taxon <- html %>% html_nodes("dd") %>% html_text()

  # Extract the first result from the list
  ncbi_taxon <- ncbi_taxon[1]

  # sep the string by ";" and add each element to data frame as column
  ncbi_taxon <- strsplit(ncbi_taxon, ";")[[1]][2:16]
  ncbi_taxon <- data.frame(t(ncbi_taxon))

  # Return the NCBI Taxon ID 
  return(ncbi_taxon)

}

# Loop over each species in the list and scrape the data if ncbi_taxon <0 column then skip
for (species in list$species) {
  ncbi_taxon <- scrape_species_data(species)
  if (ncol(ncbi_taxon) > 0) {
    # rbind ignore column number difference
    results <- rbind(results, ncbi_taxon)
      }
  print(species)
}

# Loop over each species in the list and scrape the data if ncbi_taxon <0 column then skip
for (species in list$species_short) {
  ncbi_taxon <- scrape_species_data(species)
  if (ncol(ncbi_taxon) > 0) {
    # rbind ignore column number difference
    results <- rbind(results, ncbi_taxon)
      }
  print(species)
}




###

# Function to scrape data for a single species
search_species_data <- function(species_name) {
  # Perform a GET request to the base URL to retrieve any necessary cookies
  session <- GET(base_url)

  # Extract cookies from the session
  session_cookies <- cookies(session)

  # Construct the cookie string
  cookie_string <- paste0(session_cookies$name, "=", session_cookies$value, collapse = "; ")
  
  # Perform a POST request to submit the form
  session <- POST(base_url, 
                  add_headers("Cookie" = cookie_string),
                  body = list(name = species_name, 
                              rank = "all", 
                              search = "Search", 
                              mode = "exact", 
                              display = "tree"), 
                  encode = "form")

  # Extract the HTML content from the session
  html_content <- content(session, as = "text", encoding = "UTF-8")

  # Parse the HTML content
  html <- read_html(html_content)

  # Extract the first search result link
  search_result <- html %>% html_node("a[title='species']") %>% html_attr("href")


  # Construct the URL for the search result
  result_url <- paste0("https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/", search_result)
  
  # Follow the link to the search result
  result_page <- GET(result_url, add_headers(Cookie = cookie_string))

  # Extract the HTML content from the result page
  result_html_content <- content(result_page, as = "text", encoding = "UTF-8")
  result_html <- read_html(result_html_content)

  # Extract the dd element containing the NCBI Taxon ID
  ncbi_taxon <- result_html %>% html_nodes("dd") %>% html_text()

  # if ncbi_taxon is not empty Separate the string by ";" and add each element to data frame as column
  if (length(ncbi_taxon) > 0) {
    ncbi_taxon <- strsplit(ncbi_taxon, ";")[[1]][2:16]
    ncbi_taxon <- data.frame(t(ncbi_taxon))
  } else {
    # if ncbi_taxon is empty then return empty data frame with NA
    ncbi_taxon <- data.frame(matrix(NA, nrow = 1, ncol = 15))
      }
  # Return the NCBI Taxon ID 
  return(ncbi_taxon)

}

results <- data.frame()
# Loop over each species in the list and scrape the data if ncbi_taxon <0 column then skip
for (species in list$species_short[750:1228]) {
  ncbi_taxon <- search_species_data(species)
    # rbind ignore column number difference
    results <- rbind(results, ncbi_taxon)
      
  print(species)
}

dim(results)


# Write the results to a CSV file
write.csv(results, "/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/ncbi_taxon_ids1.csv", row.names = FALSE)

## read the csv file 
ncbi_taxon_ids <- read.csv("/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/ncbi_taxon_ids.csv")
ncbi_taxon_ids1 <- read.csv("/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/ncbi_taxon_ids1.csv")

## if ncbi_taxon_ids row have NA then use the row from ncbi_taxon_ids1
for (i in 1:nrow(ncbi_taxon_ids)) {
  if (is.na(ncbi_taxon_ids$X1[i])) {
    ncbi_taxon_ids[i,] <- ncbi_taxon_ids1[i,]
  }
}
ncbi_taxon_ids1 <- results 
results[1:20,1:5]
ncbi_taxon_ids[1:20,1:5]
## write the final result to csv file
write.csv(ncbi_taxon_ids, "/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/ncbi_taxon_ids_final-2.csv", row.names = FALSE)

ncbi_taxon_ids <- read.csv("/Users/peiyu/Dropbox/2019_Fungal_BGC/FunCore/2024/ncbi_taxon_ids_final.csv")
