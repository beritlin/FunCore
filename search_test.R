# Loading packages
foo <- function(x){
  for( i in x ){
    #  require returns TRUE invisibly if it was able to load package
    if( ! require( i , character.only = TRUE ) ){
      #  If package was not able to be loaded then re-install
      install.packages( i , dependencies = TRUE )
      #  Load package after installing
      require( i , character.only = TRUE )
    }
  }
}
foo( c("argparser" ) )


# Create a parser
p <- arg_parser("Search")

# Add command line arguments
p <- add_argument(p, "query_db", help="input  FASTA/FASTQ file", type="character")
p <- add_argument(p, "input_db", help="input  FASTA/FASTQ DB", type="character")
p <- add_argument(p, "output_db", help="output file", type="character")
p <- add_argument(p, "-p", help="path to mmseqs2", type="character")


# Parse the command line arguments
argv <- parse_args(p)

mmseqs2 <- gsub(" ", "", paste(argv$p,"/MMseqs2/build/bin/mmseqs"))

#
q <- paste(mmseqs2,"easy-search",argv$query_db,argv$input_db,argv$output_db,"tmp")
#cat(q)
system(q)


#Rscript search_test.R examples/test.fasta examples/test.fasta examples/output.m8 -p /work1/home/peiyu/tools