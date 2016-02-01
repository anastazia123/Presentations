# Load packages
library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)

# read_csv() vs. read.csv()
visitor <- read_csv("DataFest Workshop 2016/Data/visitor.csv")
visitor_base <- read.csv("DataFest Workshop 2016/Data/visitor.csv")

# Look at variable 1:4 and then 189:190
visitor %>% select(c(1:4, 189:190)) %>% str()
visitor_base %>% select(c(1:4, 189:190)) %>% str()
rm(visitor_base) # Remove to keep

# Load the leads data and solve the problems
# Convert msrp and list_price to col_double()
# Convert dealer_location_id to character and then resolve NA values. type_conver() at the end.
leads <- read_csv("DataFest Workshop 2016/Data/leads.csv")
problems(leads) %>% group_by(col, expected) %>% summarise(count = n())
leads <- read_csv("DataFest Workshop 2016/Data/leads.csv",
                  col_types = cols(
                    msrp = col_double(),
                    list_price = col_double(),
                    dealer_location_id = col_character()
                  )) %>%
  mutate(dealer_location_id = gsub("INA", NA, dealer_location_id)) %>% 
  type_convert()


# Munge the shopping data by changing values tolower(). Create a new variable to denote the visitor viewed the model. spread() the long data into a wide data.
shopping <- read_csv("DataFest Workshop 2016/Data/shopping.csv")
shopping <- shopping %>% mutate(make_name = tolower(make_name), 
                    model_name = tolower(model_name),
                    viewed = "Yes")
shopping_wide <- shopping %>% spread(make_name, value = viewed, fill = "No")
# Note: spread() doesn't eliminate duplicated ids.

# Convert first 10 entries of the visitor data to a long format. Select the variables visitor_key, new_page_views and used_page_views. Then gather them together.


# Show gather's more robust cousin, melt().
library(reshape2)


# Create a faceted histogram of page views based on car type.


# For the shopping data, use group_by on make_name and then count the number of each make of car via summarise.


# For the shopping data, use group_by on visitor_key and make_name and then count the number of each make of car via summarise.


# Use `select` to create data frames called `v_tmp` and `s_tmp`. Include `visitor_key` and `page_views` in `v_tmp`. Include only `visitor_key` and `make_name` for `s_tmp`. Combine each data frame using each join.

v_tmp <-visitor %>% select(visitor_key, page_views)
s_tmp <- shopping %>% select(visitor_key, make_name)

vs_left <- left_join(v_tmp, s_tmp)
vs_right <- right_join(v_tmp, s_tmp)
vs_inner <- inner_join(v_tmp, s_tmp)
vs_full <- full_join(v_tmp, s_tmp)


# Do people who view more cars save more money?
transactions <- read_csv("DataFest Workshop 2016/Data/transactions.csv")

shopping %>% group_by(visitor_key) %>% 
  summarize(vehicles_viewed = n()) %>% 
  inner_join(transactions, .) %>%
  mutate(price_diff = price_bought - msrp_bought) %>% 
  filter(vehicles_viewed < 50, price_diff > -2e+05) %>% ggplot(aes(x = vehicles_viewed, y = price_diff)) + geom_point() + geom_smooth()

