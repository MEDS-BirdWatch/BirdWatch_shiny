# load pkgs
library(shiny)
library(shinydashboard)
library(tidyverse)
library(arrow)
library(leaflet)
library(leaflet.extras)
library(leafem)
library(here)
library(sf)
library(shinycssloaders)
library(markdown)
library(fresh)
library(sfarrow)
library(shinyWidgets)

# read in data 
species_list <- read_parquet('data/species.parquet')

leaflet_points <- read_parquet('data/leaflet_bird_points.parquet') %>%  # no here in shiny
  filter(!is.na(gap_sts)) 

habitat_poly <- st_read_parquet('data/habitat_clean.parquet')

gap_clean <- st_read_parquet('data/gap_clean.parquet') 


# colors
lifeform_colors <- c(
  CONIFER = "#74B162",
  HARDWOOD = "#A98858",
  HERBACEOUS = "#FEDD63",
  SHRUB = "#F7A54B",
  URBAN = "#595959",
  WATER = "#8EBEE2",
  AGRICULTURE = "#B5727A",
  "BARREN/OTHER" = "#FF72DE"  
)

gap_colors <- c(
  '1' = '#244233',
  '2' = '#42765C',
  '3' = '#6FAE8F',
  '4' = '#CBE2D6',
  '5' = '#EFEFE7'
)

habitat_choices <- leaflet_points$habitat_type %>%
  str_split(", ") %>%
  unlist() %>%
  unique() %>%
  sort()

gap_pal <- colorFactor(
  palette = unname(gap_colors),  
  levels  = names(gap_colors)
)

habitat_pal <- colorFactor(
  palette = unname(lifeform_colors),
  levels  = names(lifeform_colors),
  na.color = "transparent"
)


