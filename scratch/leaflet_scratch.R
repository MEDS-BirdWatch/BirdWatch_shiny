birds_joined <- st_read_parquet('data_raw/birds_joined.parquet')

coords <- birds_joined %>% 
  st_transform(crs = 4326) %>% 
  st_coordinates()

leaflet_bird_points <- birds_joined %>% 
  st_drop_geometry() %>% 
  cbind(coords) %>% 
  group_by(study_area, survey_type) %>% 
  summarize(area_observations = sum(observation_count),
            species = paste(unique(common_name), collapse = ", "),
            longitude = min(X),
            latitude = min(Y),
            gap_sts = min(gap_sts),
            habitat_type = paste(unique(habitat_type), collapse = ", ")) %>% 
  mutate(habitat_type = str_to_title(habitat_type))

species_list <- as.data.frame(unique(birds_joined$common_name)) %>% 
  rename('common_name' = 'unique(birds_joined$common_name)' )

write_parquet(species_list,'shiny_dashboard/data/species.parquet')

write_parquet(leaflet_bird_points,'shiny_dashboard/data/leaflet_bird_points.parquet')

habitat_poly <- st_read_parquet('data_raw/habitat_polygon.parquet')

habitat_clean <- habitat_poly %>%
  st_transform(crs = 4326)

st_write_parquet(habitat_clean,'shiny_dashboard/data/habitat_clean.parquet')

gap_poly <- st_read_parquet('data_raw/gap_polygon.parquet')

gap_clean <- gap_poly%>%
  st_transform(crs = 4326)

st_write_parquet(gap_clean,'shiny_dashboard/data/gap_clean.parquet')

gdf_wgs84 <- st_transform(gdf, crs = 4326)

# Plot
leaflet(gdf_wgs84) |>
  addProviderTiles(providers$Esri.WorldImagery) |>
  addCircleMarkers(
    radius = 6,
    color = "red",
    fillOpacity = 0.8
  )
