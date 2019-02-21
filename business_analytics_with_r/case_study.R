votes <- readRDS("votes.rds")

# Load dplyr package

# Print the head of dataset

# Filter the vote column where vote <= 3

# Add another column 'year' by adding 1945 to the session column on top of 
# previous data

# Add a country column
library(countrycode)
countrycode(100, "cown", "country.name")

# Add a country column within the mutate: votes_processed

# Find total and fraction of 'yes' votes (i.e. vote == 1)

# Change this code to summarize by year

# Summarize the dataset by country and save it to the variable by_country

# Sort in ascending order of percent_yes

# Now sort in descending order

# Filter out countries with fewer than 100 votes

# Plotting a line over time 

# Create a dataset grouped by year and save it to by_year

# Load the ggplot2 package
library(ggplot2)

# Create a line plot percent_yes over the years

# Change to scatter plot and add smoothing curve

# Group the dataset by year and country and save it to by_year_country

# Plott just UK over time
# Create a filtered version: UK_by_year

# Line plot of percent_yes over time for UK only


# Now plot multiple countries
# Vector of four countries to examine
countries <- c("United States", "United Kingdom",
               "France", "India")

# Filter by_year_country: filtered_4_countries
filtered_4_countries <- filter(by_year_country, country %in% countries)

# Line plot of % yes in four countries, show the countries in different colors

# Linear Regression on the United States
# Percentage of yes votes from the US by year save it to US_by_year

# Perform a linear regression of percent_yes by year: US_fit

# Perform summary() on the US_fit object

# Tidying linear regression model
# Load the broom package
library(broom)

# Call the tidy() function on the US_fit object
tidy(US_fit)

# Combining models for multiple countries
# Create Linear Regression model for UK as you did for US
# Fit model for the United Kingdom

# Create US_tidied and UK_tidied

# Combine the two tidied models