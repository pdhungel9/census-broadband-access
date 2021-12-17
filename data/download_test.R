# For downloading an intial set of data

# Instructions for tidycensus:
# https://walker-data.com/tidycensus/articles/basic-usage.html
# Census code lists, definitions, accuracy:
# https://www.census.gov/programs-surveys/acs/technical-documentation/code-lists.html
# Census API variables:
# https://api.census.gov/data/2019/acs/acs1/variables.html
# https://api.census.gov/data/2010/dec/sf1/variables.html


# Load libraries
library(tidyverse)
library(tidycensus)

# API Key:
api_key <- "" # TODO
census_api_key(api_key)


# Variables of interest:
total_population <- c("B01003_001E")
# Vacancy status variables:
vacancy_vars <- c("B25004_001E", "B25004_002E", "B25004_003E", "B25004_004E", 
                  "B25004_005E", "B25004_006E", "B25004_007E", "B25004_008E",
                  "B25005_001E", "B25005_002E", "B25005_003E")
# Internet/Broadband variable:
# (there are more variables, check out the 2019 acs variables list)
internet_variables <- c("B28002_001E", "B28002_002E", "B28002_003E",
                        "B28002_004E", "B28002_005E", "B28002_006E", 
                        "B28002_007E", "B28002_008E", "B28002_009E", 
                        "B28002_010E", "B28002_011E", "B28002_012E", 
                        "B28002_013E")
# Variables:
all_vars <- c(total_population, vacancy_vars, internet_variables)

# Get a dataset:
the_data <- get_acs(geography="block group", year=2019, state="MA",
                    variables=all_vars, geometry=TRUE)
data_against_summary <- get_acs(geography="block group", year=2019, state="MA",
                                variables=all_vars, geometry=TRUE, summary_var="B01003_001")
# Only for Suffolk county:
data_against_summary_county <- get_acs(geography="block group", year=2019, state="MA", county="Suffolk",
                                       variables=all_vars, geometry=TRUE, summary_var="B01003_001")

# Divide estimates by summary:
data_against_summary$percent <- (data_against_summary$estimate / data_against_summary$summary_est) * 100
data_against_summary_county$percent <- (data_against_summary_county$estimate / data_against_summary_county$summary_est) * 100

# Save to csv:
write.csv(the_data, "2019acs_internet_vacancy.csv")
write.csv(data_against_summary, "2019acs_internet_vacancy_against_summary.csv")

# ##############################################################################
# Figure of total population:
the_data %>% 
  filter(variable=="B01003_001") %>% 
  ggplot(aes(fill=estimate)) +
  geom_sf(color=NA) +
  coord_sf(crs=26911) +
  scale_fill_viridis_c(option = "magma", na.value="white") +
  ggtitle("Total Population")


# ##############################################################################
# For cable: B28002_007E
data_against_summary %>% 
  filter(variable=="B28002_007") %>% 
  ggplot(aes(fill=percent)) +
  geom_sf(color=NA) +
  coord_sf(crs=26911) +
  scale_fill_viridis_c(option = "magma", na.value="white") +
  ggtitle("With Cable/Fiber optic/DSL Broadband subscription")

# To just see data:
data_cable <- data_against_summary %>% 
  filter(variable=="B28002_007")

# For only the county:
data_against_summary_county %>% 
  filter(variable=="B28002_007") %>% 
  ggplot(aes(fill=percent)) +
  geom_sf(color=NA) +
  coord_sf(crs=26911) +
  scale_fill_viridis_c(option = "magma", na.value="white") +
  ggtitle("With Cable/Fiber optic/DSL Broadband subscription, Suffolk County")


# ###############################################################################
# No access to internet: B28002_013
data_against_summary_county %>% 
  filter(variable=="B28002_013") %>% 
  ggplot(aes(fill=percent)) +
  geom_sf(color=NA) +
  coord_sf(crs=26911) +
  scale_fill_viridis_c(option = "magma", na.value="white") +
  ggtitle("Without Access to Internet, Suffolk County")


# No access to internet: B28002_013
data_against_summary %>% 
  filter(variable=="B28002_013") %>% 
  ggplot(aes(fill=percent)) +
  geom_sf(color=NA) +
  coord_sf(crs=26911) +
  scale_fill_viridis_c(option = "magma", na.value="white") +
  ggtitle("Without Access to Internet")