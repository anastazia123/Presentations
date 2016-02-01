# From the slide read_csv() vs. read.csv()
visitor <- read_csv("DataFest Workshop 2016/Data/visitor.csv")
visitor_base <- read.csv("DataFest Workshop 2016/Data/visitor.csv")

visitor %>% select(1:4) %>% str()
visitor_base %>% select(1:4) %>% str()

visitor %>% select(189:190) %>% str()
visitor_base %>% select(189:190) %>% str()


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