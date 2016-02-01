# Load packages
library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)

# read_csv() vs. read.csv()
visitor <- read_csv("DataFest Workshop 2016/Data/visitor.csv")
visitor_base <- read.csv("DataFest Workshop 2016/Data/visitor.csv")

# Look at variable 1:4 and then 189:190

# Load the leads data and solve the problems
leads <- read_csv("DataFest Workshop 2016/Data/leads.csv") # uh-oh!

# Convert msrp and list_price to col_double()


# Convert dealer_location_id to character and then resolve NA values. type_conver() at the end.


# Munge the shopping data by changing values tolower(). Create a new variable to denote the visitor viewed the model. spread() the long data into a wide data.
shopping <- read_csv("DataFest Workshop 2016/Data/shopping.csv")


# Convert first 10 entries of the visitor data to a long format. Select the variables visitor_key, new_page_views and used_page_views. Then gather them together.
visitor_tmp <- visitor %>% slice(1:10) %>% select(visitor_key, new_page_views, used_page_views)
visitor_tmp 
visitor_long <- gather(visitor_tmp, visitor_key, views)
visitor_long
names(visitor_long)[2] <- "car_type"
visitor_long
mutate(visitor_long, car_type = gsub("_page_views", "", car_type))


# Show gather's more robust cousin, melt().
library(reshape2)


# Create a faceted histogram of page views based on car type.







# From the slides:
shopping <- read_csv("DataFest Workshop 2016/Data/shopping.csv")
transactions <- read_csv("DataFest Workshop 2016/Data/transactions.csv")
configuration <- read_csv("DataFest Workshop 2016/Data/configuration.csv")
leads <- read_csv("DataFest Workshop 2016/Data/leads.csv") # uh-oh!


# To see the problems we had from trying to read-in the leads data.
problems(leads)
class(leads$msrp)
class(leads$list_price)
?read_csv

leads <- read_csv("DataFest Workshop 2016/Data/leads.csv", 
                  col_types = cols(
                    msrp = col_double(),
                    list_price = col_double()
                  ))

# Ugh .. more problems
problems(leads)

# See what's the problem
problem_rows <- problems(leads)$row
leads %>% select(dealer_location_id) %>% slice(problem_rows)

# Best method: Import as character, fix issues, then type_convert()
leads <- read_csv("DataFest Workshop 2016/Data/leads.csv", col_types = cols(
  msrp = col_double(), 
  list_price = col_double(),
  dealer_location_id = col_character()
))

leads %>% select(dealer_location_id) %>% slice(problem_rows)


# Change the INA to just NA
leads$dealer_location_id <- gsub("INA", NA, leads$dealer_location_id)

# Type convert:
leads <- type_convert(leads)
leads %>% select(dealer_location_id) %>% str

# Recall what this data is abouts