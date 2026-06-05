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
library(collapsibleTree)

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


# The Decision column is the tooltip shown on hover at the leaf node
choices_data <- data.frame(
  Phase = c(
    # --- Data ---
    rep("Data", 10),
    # --- Geospatial ---
    rep("Geospatial", 4),
    # --- Biodiversity ---
    rep("Biodiversity", 5),
    # --- Focal Species ---
    rep("Focal Species", 7),
    # --- Statistical Models ---
    rep("Statistical Models", 10)
  ),
  Category = c(
    # Data
    "Survey Data", "Survey Data", "Survey Data", "Survey Data", "Survey Data",
    "Habitat Classification", "Habitat Classification",
    "GAP Status", "GAP Status", "GAP Status",
    # Geospatial
    "Spatial Join", "Spatial Join",
    "Raster Resolution", "Raster Resolution",
    # Biodiversity
    "Index Selection", "Index Selection",
    "Aggregation", "Aggregation", "Aggregation",
    # Focal Species
    "Selection Method", "Selection Method",
    "Focal Species", "Focal Species", "Focal Species",
    "Focal Species", "Focal Species",
    # Models
    "Biodiversity Model", "Biodiversity Model", "Biodiversity Model",
    "Population Trend Model", "Population Trend Model",
    "Population Trend Model", "Population Trend Model",
    "Autocorrelation", "Autocorrelation", "Autocorrelation"
  ),
  Choice = c(
    # Survey Data
    "Include Point Count",
    "Include Area Search",
    "Exclude Secretive Marsh Surveys",
    "Do Not Restrict to Breeding Season",
    "Exclude ~2100 Area Search NAs",
    # Habitat
    "Use CAL FIRE Not AKN Habitat Field",
    "Aggregate to 8 Habitat Types",
    # GAP
    "Aggregate GAP 1-2 as Protected",
    "Aggregate GAP 3-5 as Unprotected",
    "Retain Individual GAP Levels in Disaggregated Models",
    # Geospatial
    "Spatially Join Bird Obs to GAP + CAL FIRE",
    "Use Transformed Coordinates",
    "Aggregate Raster by Factor of 20",
    "Use 100m Max Point Count Radius as Spillover Baseline",
    # Biodiversity
    "Use Rich-Gini-Simpson (RGS) Index",
    "Use Richness Only as Diagnostic",
    "Group by GAP x Habitat Type",
    "Calculate Mean Daily Biodiversity Per Cell",
    "Standardize by Sampling Effort",
    # Focal Species
    "Use IndVal Metric via {indicspecies}",
    "Cross-Reference with Partners in Flight ACAD 2024",
    "Wrentit — Shrub",
    "Western Meadowlark — Herbaceous",
    "Song Sparrow — Hardwood",
    "Red-breasted Nuthatch — Conifer",
    "Red-winged Blackbird — Agriculture",
    # Biodiversity Models
    "Gamma GLMM: Aggregated Protection",
    "Gamma GLMM: Disaggregated Individual GAP Levels",
    "Random Effects: Study Area + Year",
    # Population Trends
    "Negative Binomial Type II for Overdispersion",
    "Include Year x Protection Interaction",
    "Log Offset: Cumulative Sampling Effort",
    "Do Not Split by Survey Type",
    # Autocorrelation
    "Durbin-Watson for Temporal Autocorrelation",
    "Moran's I for Spatial Autocorrelation (K=4 KNN)",
    "Address via Random Effects Not Resampling"
  ),
  stringsAsFactors = FALSE
)

