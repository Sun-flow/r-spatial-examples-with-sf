# just a really basic workflow to take a table of Lat-Long coordinates, reproject them, and extract those coordinates

library(tidyverse)
library(sf)

# first, just a bunch of point locations roughly in california
n_points <- 100L
points_LL <- tibble(point_id  = paste0('p', str_pad(1:n_points, width = 3, pad = "0")),
                    longitude = runif(n_points, -124.4, -114.1),
                    latitude  = runif(n_points,   32.5,   42.0))

# what's the starting coordinate system?
# if you have lat-lon data from an unknown source, you probably want to use WGS84
crs_start <- 4326 # (WGS84) is a good bet for lat long data if you don't know any better
# crs_start <- 4269 # (NAD83) is used by US Census / TIGER datasets
# the difference between these data sources in the US is typically a meter or less

# the workflow here is to first extract an sf points column from your latitude and longitude values
points_LL_sf <- points_LL %>% 
  # first, create an sf points column from the lat/lon values and identify coordinate reference system
  st_as_sf(coords = c('longitude', 'latitude'), crs = crs_start) %>% 
  # next, reproject the data into whatever projection you use for the rest of your project
  # here, 3310 is California Albers (meters), a good choice for statewide mapping of California
  st_transform(3310)

# finally, attach the projected coordinates to the original data as columns
points_LL_XY <- points_LL %>% 
  bind_cols(as_tibble(st_coordinates(points_LL_sf)))

# here's the whole process in a single function:
# data    ... a data frame / tibble containing *at least* two columns of LL/XY data
# coords  ... a character vector of length 2 with names of columns in data containing starting coordinates
# crs_end ... probably a number, could be a well-known-text projection definition
# remove  ... logical ~> do you want to remove the original coordinate columns specified by coords
attach_projected_coords <- function(data, coords, crs_end, crs_start = 4326, remove = FALSE) {
  data %>% 
    st_as_sf(coords = coords, crs = crs_start, remove = remove) %>% 
    st_transform(crs_end) %>% 
    bind_cols(as_tibble(st_coordinates(.))) %>% 
    st_drop_geometry()
}

# example of how the function works
points_LL_XY2 <- points_LL %>% attach_projected_coords(c('longitude', 'latitude'), 3310)

# make sure the results are the same:
identical(points_LL_XY, points_LL_XY2)

