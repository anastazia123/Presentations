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


# Show gather's more robust cousin, melt().
library(reshape2)


# Create a faceted histogram of page views based on car type.


# For the shopping data, use group_by on make_name and then count the number of each make of car via summarise.


# For the shopping data, use group_by on visitor_key and make_name and then count the number of each make of car via summarise.


# Use `select` to create data frames called `v_tmp` and `s_tmp`. Include `visitor_key` and `page_views` in `v_tmp`. Include only `visitor_key` and `make_name` for `s_tmp`. Combine each data frame using each join.


# Do people who view more cars save more money?
transactions <- read_csv("DataFest Workshop 2016/Data/transactions.csv")

