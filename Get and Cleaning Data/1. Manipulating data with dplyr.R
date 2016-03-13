## Manipulating Data with dplyr

mydf <- read.csv(path2csv, stringsAsFactors = FALSE)

## Use dim() to look at the dimensions of mydf.
dim(mydf)

library(dplyr)
packageVersion("dplyr")

## The first step of working with data in dplyr is to load the data into what the package authors call a
## 'data frame tbl' or 'tbl_df'.
cran <- tbl_df(mydf)

## remove the original data frame from your workspace with rm("mydf")
rm("mydf")

## Specifically, dplyr supplies five 'verbs' that cover most fundamental data manipulation tasks: 
## select(), filter(), arrange(), mutate(), and summarize().
select(cran, ip_id, package, country)
select(cran, r_arch:country)  ## Use select(cran, r_arch:country) to select all columns starting from r_arch and ending with country.
select(cran, country:r_arch) ## Select in a reverse order
select(cran, -time) ## Select the columns we want to throw away
select(cran, -(X:size)) ## Omit several columns

## Use filter(cran, package == "swirl") to select all rows for which the package variable is equal to
## "swirl". Be sure to use two equals signs side-by-side!
filter(cran, package == "swirl")
filter(cran, r_version == "3.1.1", country == "US")  ## You can specify as many conditions as you want
filter(cran, r_version <= "3.0.2", country == "IN")  ## Use of comparison
filter(cran, country == "US" | country == "IN")  ## OR condition
filter(cran, size > 100500, r_os == "linux-gnu")  ## AND condition
filter(cran, !is.na(r_version))  ## Find r_version that is not NA

## Sometimes we want to order the rows of a dataset according to the values of a particular variable. This
## is the job of arrange().
cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)  ## ip_id ascending
arrange(cran2, desc(ip_id))  ## ip_id descending
arrange(cran2, package, ip_id)  ## Firstly arrange package asc, and then arrange ip_id asc
arrange(cran2, country, desc(r_version), ip_id)

## It's common to create a new variable based on the value of one or more variables already in a dataset.
## The mutate() function does exactly this.
cran3 <- select(cran, ip_id, package, size)
mutate(cran3, size_mb = size / 2^20)  ## We want to add a column called size_mb that contains the download size in megabytes
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)  ## Adding 3rd column based on 2nd column
mutate(cran3, correct_size = size + 1000)

## The last of the five core dplyr verbs, summarize(), collapses the dataset to a single row.
## Let's say we're interested in knowing the average download size.
## Summarize() can give you the requested value FOR EACH group in your dataset.
summarize(cran, avg_bytes = mean(size))

