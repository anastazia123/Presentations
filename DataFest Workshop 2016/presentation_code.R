# Code script to follow when creating the presentation.

# My setup
# R 3.2.3
# Rstudio (Preview) 0.99.869

# Package versions
# readr (0.2.2)
# tidyr (0.4.0)
# dplyr (0.4.3)

# install/load packages
install.packages(c("readr", "tidyr", "dplyr"))
library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)

# Reading in data
visitor_file <- "DataFest Workshop 2016/Data/visitor.csv"

# base::read.csv takes MUCH longer
system.time(read.csv(visitor_file))
system.time(read_csv(visitor_file))

# Compare structures of data files
visitor <- read_csv(visitor_file)
visitor_base <- read.csv(visitor_file)

# Datetimes are datetimes (not factors) using readr::read_csv
str(visitor[, 1:5])
str(visitor_base[, 1:5])

# Which column types are different?
different_columns <- which(sapply(visitor, class) != sapply(visitor_base, class))
str(visitor[, different_columns])
View(visitor[, different_columns]) 
# Notice that Zip is malformatted. If we end up wanting to use zip, we'll need to clean it.

str(visitor_base[, different_columns])
View(visitor_base[, different_columns])
# Major differences are Characters vs. Factors.

# What's a good way to find numerical variables that are misclassified as characters?
non_numbers <- which(!sapply(visitor, class) %in% c("numeric", "integer"))
str(visitor[, non_numbers])
View(visitor[, non_numbers])

# Read in remaining data files
shopping <- read_csv("DataFest Workshop 2016/Data/shopping.csv")
configuration <- read_csv("DataFest Workshop 2016/Data/configuration.csv")
leads <- read_csv("DataFest Workshop 2016/Data/leads.csv") # uh-oh!
transactions <- read_csv("DataFest Workshop 2016/Data/transactions.csv")

# Problems reading in leads data
problems(leads)
# Suspect the character is being read in as an integer but should be a double.
class(leads$msrp)
class(leads$list_price)
# Suspicion seems reasonable

# Reload leads but set problem variables to be doubles
leads <- read_csv("DataFest Workshop 2016/Data/leads.csv", col_types = cols(
  msrp = col_double(), 
  list_price = col_double()
))
# More problems, this time not obvious

problems(leads)
problem_rows <- problems(leads)$row
leads$dealer_location_id[problem_rows]
# Not immediately obvious this is desireable.

# Best method(?): Import as character, fix issues, then type_convert
leads <- read_csv("DataFest Workshop 2016/Data/leads.csv", col_types = cols(
  msrp = col_double(), 
  list_price = col_double(),
  dealer_location_id = col_character()
))
leads$dealer_location_id[problem_rows] 
# Weird.

# Change the INA to just NA
leads$dealer_location_id <- gsub("INA", NA, leads$dealer_location_id)

# Type convert:
leads <- type_convert(leads)
str(leads)

########################################################################
# Do people who view more cars save more money?
shopping %>% group_by(visitor_key) %>% 
  summarize(vehicles_viewed = n()) %>% 
  full_join(transactions) %>%
  mutate(price_diff = price_bought - msrp_bought) %>% 
  View()
# tmp1 %>% filter(vehicles_viewed < 50, price_diff > -2e+05) %>% ggplot(aes(x = vehicles_viewed, y = price_diff)) + geom_point() + geom_smooth()


########################################################################
l_join <- left_join(visitor, shopping)
r_join <- right_join(visitor, shopping)
i_join <- inner_join(visitor, shopping)

