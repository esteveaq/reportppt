## Create objects--------------------------------------------------------------

# Create dates
datesx <- seq.Date(from = as.Date("2014-01-01"), to = Sys.Date(), by = 1)
# Sample random dates and sort in chronologically
set.seed(123)
dates <- sample(datesx, size = 400, replace = TRUE)
dates <- sort(dates, decreasing = FALSE)

# Create sectors and regions (categorical)
sectors <- sample(x = c("air", "space", "land", "sea", "ground", "radio"), 
                  size = 400, replace = TRUE, prob=c(0.1, 0.2, 0.30, 0.2, 0.1, 0.2))
regions <- sample(x = c("NAM", "LATAM", "EMEA", "APAC", "AUS"), 
                  size = 400, replace = TRUE, prob=c(0.1, 0.2, 0.40, 0.2, 0.1))

# Create deal sizes and revenues (numeric)
dealsize <- sample(1:1000, size = 400, replace = TRUE)
revenues <- round(rnorm(400, 20, 5)^2, 0)

## Create data frame-----------------------------------------------------------

# create tibbles by combining vectors
evolution <-
  tibble(dates, sectors, regions, dealsize, revenues)

#convert as character variables to factors
evolution <-
  evolution %>%
  mutate_if(sapply(evolution, is.character), as.factor) %>% 
  print()

# data required for plot a
data.plot.a <-  
  evolution %>%
  count(sectors) %>%
  mutate(prop = (n/sum(n)))

# data required for plot b
data.plot.b <- 
  evolution %>%
  group_by(year = year(dates)) %>%
  count(sectors) 

# ordering sectors in function of frequency using data.plot.a 
ordered_levels <- data.plot.a %>%
  arrange(desc(prop)) %>%
  select(sectors) %>% 
  pull(sectors) %>% # extract the sectors column from the tibble as a vector
  factor(levels = unique(.)) # ensure factor levels follow the order of appearance

# define custom order (optional)
custom_levels <- c("land", "space", "sea", "radio", "ground", "air")




