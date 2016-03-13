library(dplyr)
cran <- tbl_df(mydf)
rm("mydf")

## The main idea behind grouping data is that you want to break up your dataset into groups of rows based
## on the values of one or more variables. The group_by() function is reponsible for doing this.
by_package <- group_by(cran, package)  ## Group cran by the package variable and store the result in a new variable called by_package.

## At the top of the output above, you'll see 'Groups: package', which tells us that this tbl has been
## grouped by the package variable. Everything else looks the same, but now any operation we apply to the
## grouped data will take place on a per package basis.
summarize(by_package, mean(size))

pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

## We need to know the value of 'count' that splits the data into the top 1% and bottom 99% of packages
## based on total downloads. In statistics, this is called the 0.99, or 99%, sample quantile.
quantile(pack_sum$count, probs = 0.99)

## Isolate only those packages which had more than 679 total downloads.
top_counts <- filter(pack_sum, count > 679)

## View() to see all data (since dplyr only shows top 10)
View(top_counts)

top_counts_sorted <- arrange(top_counts, desc(count))

## Top 1% of unique downloads
quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
View(top_unique)
top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted)

## Find number of distinct countries from which each package was downloaded.
## We'll approach this one a little differently to introduce you to a method called 'chaining' (or 'piping').
## The code to the right of %>% operates on the result from the code to the left of %>%. Help ?chain.
result3 <-
        cran %>%
        group_by(package) %>%
        summarize(count = n(),
                  unique = n_distinct(ip_id),
                  countries = n_distinct(country),
                  avg_bytes = mean(size)
        ) %>%
        filter(countries > 60) %>%
        arrange(desc(countries), avg_bytes)


