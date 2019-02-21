flights <- readRDS("flights.RData")

#View the structure of the flights data
str(flights)

#Examine the first five rows of the flights data
head(flights, n = 5)

#Identify class of the column containing date information
class(flights$date)

# Load the xts package
library(xts)

# Convert date column to a time-based class
flights$date <- as.Date(flights$date)

# Convert flights to an xts object using as.xts
flights_xts <- as.xts(flights [ , -5], order.by = flights$date)

# Check the class of flights_xts
class(flights_xts)

# Examine the first five lines of flights_xts
head(flights_xts, n=5)

# Identify the periodicity of flights_xts
periodicity(flights_xts)

# Identify the number of periods in flights_xts
nmonths(flights_xts)

# Find data on flights arriving in BOS in June 2014
flights_xts["2014-06"]

# Use plot.xts() to view total monthly flights into BOS over time
plot.xts(flights_xts$total_flights)

# Use plot.xts() to view monthly delayed flights into BOS over time
plot.xts(flights_xts$delay_flights)

# Use plot.zoo() to view all four columns of data in their own panels
labels = c("Total", "Delay", "Cancel", "Divert")
plot.zoo(flights_xts, plot.type = "multiple", ylab = labels)

# Use plot.zoo() to view all four columns of data in one panel
lty = c(1, 2, 3, 4)
plot.zoo(flights_xts, plot.type = "single", lty = lty)
legend("right", lty = lty, legend = labels)

# Calculate percentage of flights delayed each month: pct_delay
flights_xts$pct_delay <- (flights_xts$delay_flights / flights_xts$total_flights) * 100

# Use plot.xts() to view pct_delay over time
plot.xts(flights_xts$pct_delay)

# Calculate percentage of flights cancelled each month: pct_cancel
flights_xts$pct_cancel <- (flights_xts$cancel_flights / flights_xts$total_flights) * 100

# Calculate percentage of flights diverted each month: pct_divert
flights_xts$pct_divert <- (flights_xts$divert_flights / flights_xts$total_flights) * 100

# Use plot.zoo() to view all three trends over time
plot.zoo(flights_xts[, c("pct_delay", "pct_cancel", "pct_divert")])