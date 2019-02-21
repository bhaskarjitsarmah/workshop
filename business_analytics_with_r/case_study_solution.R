votes <- readRDS("votes.rds")

# Load dplyr package
library(dplyr)

# Print the head of dataset
head(votes)

# Filter the vote column where vote <= 3
filter(votes, vote <= 3)

# Add another column 'year' by adding 1945 to the session column on top of 
# previour data
votes %>% 
  filter(vote <= 3) %>%
  mutate(year = 1945 + session)

# Add a country column
library(countrycode)
countrycode(100, "cown", "country.name")

# Add a country column within the mutate: votes_processed
votes_processed <- votes %>%
  filter(vote <= 3) %>%
  mutate(year = 1945 + session, 
         country = countrycode(ccode, "cown", "country.name"))

# Find total and fraction of 'yes' votes (i.e. vote == 1)
votes_processed %>% summarize(total = n(),
                              percent_yes = mean(vote == 1))

# Change this code to summarize by year
votes_processed %>%
  group_by(year) %>% 
  summarize(total = n(),
            percent_yes = mean(vote == 1))

# Summarize by country: by_country
by_country <- votes_processed %>%
  group_by(country) %>%
  summarize(total = n(),
            percent_yes = mean(vote == 1))

# Sort in ascending order of percent_yes
by_country %>% arrange(percent_yes)

# Now sort in descending order
by_country %>% arrange(desc(percent_yes))

# Filter out countries with fewer than 100 votes
by_country %>%
  filter(total > 100) %>%
  arrange(percent_yes) 

# Plotting a line over time. Create a dataset by_year
by_year <- votes_processed %>%
  group_by(year) %>% 
  summarize(total = n(),
            percent_yes = mean(vote == 1))

# Load the ggplot2 package
library(ggplot2)

# Create a line plot
ggplot(by_year, aes(x = year, y = percent_yes)) +
  geom_line()

# Change to scatter plot and add smoothing curve
ggplot(by_year, aes(year, percent_yes)) +
  geom_point() + geom_smooth()

# Group by year and country: by_year_country
by_year_country <- votes_processed %>%
  group_by(year, country) %>%
  summarize(total = n(),
            percent_yes = mean(vote == 1))

# Plott just UK over time
# Create a filtered version: UK_by_year
UK_by_year <- filter(by_year_country, country == "United Kingdom")

# Line plot of percent_yes over time for UK only
ggplot(UK_by_year, aes(year, percent_yes)) +
  geom_line()


# Now plot multiple countries
# Vector of four countries to examine
countries <- c("United States", "United Kingdom",
               "France", "India")

# Filter by_year_country: filtered_4_countries
filtered_4_countries <- filter(by_year_country, country %in% countries)

# Line plot of % yes in four countries
ggplot(filtered_4_countries, aes(year, percent_yes, color=country)) +
  geom_line()

ggplot(filtered_4_countries, aes(year, percent_yes, color=country)) +
  geom_line() +
  facet_wrap(~ country, scales = "free_y")

# Linear Regression on the United States
# Percentage of yes votes from the US by year: US_by_year
US_by_year <- by_year_country %>%
  filter(country == "United States")

# Perform a linear regression of percent_yes by year: US_fit
US_fit <- lm(percent_yes ~ year, data=US_by_year)

# Perform summary() on the US_fit object
summary(US_fit)

# Tidying linear regression model
# Load the broom package
library(broom)

# Call the tidy() function on the US_fit object
tidy(US_fit)

# Combining models for multiple countries
# Create Linear Regression model for UK as you did for US
# Fit model for the United Kingdom
UK_by_year <- by_year_country %>%
  filter(country == "United Kingdom")
UK_fit <- lm(percent_yes ~ year, UK_by_year)

# Create US_tidied and UK_tidied
US_tidied <- tidy(US_fit)
UK_tidied <- tidy(UK_fit)

# Combine the two tidied models
bind_rows(US_tidied, UK_tidied)


# Load the tidyr package
library(tidyr)

# Nest all columns besides country
by_year_country %>% nest(-country)

# All countries are nested besides country
nested <- by_year_country %>%
  nest(-country)

# Print the nested data for Brazil
nested$data[[7]]
