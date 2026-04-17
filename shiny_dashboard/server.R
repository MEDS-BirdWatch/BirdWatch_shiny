# server function 
server <- function(input, output) {
  
  # filter lake data ----
  filtered_leaflet_df <- reactive({
      
      df <- leaflet_points
      
      if (length(input$species_ID) > 0)
        df <- df %>% filter(str_detect(species, paste(input$species_ID, collapse = "|")))
      
      if (length(input$site_ID) > 0)
        df <- df %>% filter(study_area %in% input$site_ID)
      
      if (length(input$habitat_ID) > 0)
        df <- df %>% filter(str_detect(habitat_type, paste(input$habitat_ID, collapse = "|")))
      
      if (length(input$gap_ID) > 0)
        df <- df %>% filter(gap_sts %in% input$gap_ID)
      
      df %>% filter(area_observations >= input$observation_ID[1] &
                      area_observations <= input$observation_ID[2])
      
    }) %>% bindEvent(input$submit)

  
  # build leaflet map ----
  output$leaflet_output <- renderLeaflet({
    
    leaflet() %>% 
      addProviderTiles(providers$Esri.WorldTerrain, group = "ESRI Terrain") %>% 
      addMiniMap(toggleDisplay = TRUE) %>% 
      
      # GAP Status with colors
      addPolygons(data = gap_clean, 
                  group = 'GAP Status',
                  fillColor = ~gap_pal(gap_sts),  # Replace gap_sts with your column
                  color = "black", 
                  weight = 1,
                  fillOpacity = 1) %>% 
      
      # Vegetation Type with colors
      addPolygons(
        data = habitat_poly,           # need data = 
        group = 'Habitat Type',
        fillColor = ~habitat_pal(LIFEFORM),  # replace 'lifeform' with your actual column name
        color = "black",
        weight = 0.5,
        fillOpacity = 1
      ) %>%
      addAwesomeMarkers(
        data = filtered_leaflet_df(),
        lng  = ~longitude,
        lat  = ~latitude,
        icon = awesomeIcons(
          icon        = "feather",
          library     = "fa",
          markerColor = "blue",
          iconColor   = "white"
        ),,
        popup = ~paste0(
          "<div style='max-height:200px; overflow-y:auto;'>",
          "<b>", study_area, "</b><br>",
          "<b> Survey Type: </b>", survey_type, "<br>",
          "<b> Habitat Type: </b>", habitat_type, "<br>",
          "<b> GAP Status: </b>", gap_sts, '<br>',
          "<b> Observations: </b>", area_observations, "<br>",
          "<b>Species:</b><br>", 
          gsub(", ", "<br>", species),  # Put each species on new line
          "</div>"
        ),
        popupOptions = popupOptions(maxWidth = 300),
        group = 'Observations'
      ) %>% 
      # Add legends
      addLegend(
        colors = lifeform_colors,
        labels = names(lifeform_colors),
        group = "Habitat Type",
        title = 'Habitat Type',
        position = 'bottomleft'
      ) %>% 
      addLegend(pal = gap_pal, 
                values = gap_clean$gap_sts,  # Replace with your column
                title = "GAP Status",
                position = "bottomleft",
                group = 'GAP Status') %>%
      
      addLayersControl(
        overlayGroups = c('GAP Status', 'Habitat Type', 'Observations'),
        options = layersControlOptions(collapsed = TRUE)
      ) %>% 
      
      leaflet.extras::addResetMapButton()
  }) #END Leaflet map
  
}