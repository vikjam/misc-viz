library(stringr)
library(ggmap)

# URL to Census Population Data by City
CENSUS_URL = 'https://www2.census.gov/programs-surveys/popest/datasets/2010-2015/cities/totals/sub-est2015_all.csv'

# Load CSV
msa_pop <- read.csv(CENSUS_URL, stringsAsFactors = FALSE)

# Restrict to places (the original file contains state statistics as well)
msa_pop <- subset(msa_pop, SUMLEV == 162)

# Keep only the name of the city
msa_pop$NAME <- str_subset(string  = msa_pop$NAME,
	                       pattern = "([A-Z][^\s]*)")

# Percentage change in population
msa_pop$GROWTH <- (msa_pop$POPESTIMATE2015 - msa_pop$POPESTIMATE2010) / msa_pop$POPESTIMATE2014

# Subset by relevant variables
relevant_vars <- c('SUMLEV', 'STATE', 'PLACE', 'NAME', 'STNAME',
	               'POPESTIMATE2015', 'GROWTH')
msa_pop       <- msa_pop[ , relevant_vars]

# Keep only top 1,000 cities (by population)
msa_pop <- head(msa_pop[order(msa_pop$POPESTIMATE2015, decreasing = TRUE), ], 1000)

# Geocode the cities
geo <- geocode(location = paste(msa_pop$NAME, msa_pop$STNAME),
               output   = 'latlon' ,
	           source   = 'google')

# Lower case all the variables
names(msa_pop) <- tolower(names(msa_pop))

# Export data
write.csv(x         = msa_pop,
	      file      = 'data/processed/msa_pop_grow.csv',
	      row.names = FALSE)
