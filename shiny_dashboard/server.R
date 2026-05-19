# server function 
  server <- function(input, output, session) {
    
    # filter data ----
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
    
    # render base map 
    output$leaflet_output <- renderLeaflet({
      
      leaflet() %>% 
        addProviderTiles(providers$Esri.WorldTerrain, group = "ESRI Terrain") %>% 
        addMiniMap(toggleDisplay = TRUE) %>% 
        
        addPolygons(data = gap_clean, 
                    group = 'GAP Status',
                    smoothFactor = 2,
                    fillColor = ~gap_pal(gap_sts),
                    color = "black", 
                    weight = 1,
                    fillOpacity = 1) %>% 
        
        addPolygons(data = habitat_poly,
                    group = 'Habitat Type',
                    smoothFactor = 2,
                    fillColor = ~habitat_pal(LIFEFORM),
                    color = "black",
                    weight = 0.5,
                    fillOpacity = 1) %>%
        
        # all points on first load
        addAwesomeMarkers(
          data = leaflet_points,
          lng  = ~longitude,
          lat  = ~latitude,
          icon = awesomeIcons(
            icon        = "feather",
            library     = "fa",
            markerColor = "blue",
            iconColor   = "white"
          ),
          popup = ~paste0(
            "<div style='max-height:200px; overflow-y:auto;'>",
            "<b>", study_area, "</b><br>",
            "<b> Survey Type: </b>", survey_type, "<br>",
            "<b> Habitat Type: </b>", habitat_type, "<br>",
            "<b> GAP Status: </b>", gap_sts, "<br>",
            "<b> Observations: </b>", area_observations, "<br>",
            "<b>Species:</b><br>", 
            gsub(", ", "<br>", species),
            "</div>"
          ),
          popupOptions = popupOptions(maxWidth = 300),
          group = "Observations"
        ) %>%
        
        addLegend(colors   = lifeform_colors,
                  labels   = names(lifeform_colors),
                  group    = "Habitat Type",
                  title    = "Habitat Type",
                  position = "bottomleft") %>% 
        
        addLegend(pal      = gap_pal, 
                  values   = gap_clean$gap_sts,
                  title    = "GAP Status",
                  position = "bottomleft",
                  group    = "GAP Status") %>%
        
        addLayersControl(
          overlayGroups = c("GAP Status", "Habitat Type", "Observations"),
          options = layersControlOptions(collapsed = TRUE)
        ) %>% 
        
        leaflet.extras::addResetMapButton()
      
    }) # end basemap
    
    # update markers when filter changes ----
    observe({
      
      df <- filtered_leaflet_df()
      
      leafletProxy("leaflet_output", data = df) %>%
        clearGroup("Observations") %>%    # remove old markers
        addAwesomeMarkers(
          lng  = ~longitude,
          lat  = ~latitude,
          icon = awesomeIcons(
            icon        = "feather",
            library     = "fa",
            markerColor = "blue",
            iconColor   = "white"
          ),
          popup = ~paste0(
            "<div style='max-height:200px; overflow-y:auto;'>",
            "<b>", study_area, "</b><br>",
            "<b> Survey Type: </b>", survey_type, "<br>",
            "<b> Habitat Type: </b>", habitat_type, "<br>",
            "<b> GAP Status: </b>", gap_sts, "<br>",
            "<b> Observations: </b>", area_observations, "<br>",
            "<b>Species:</b><br>", 
            gsub(", ", "<br>", species),
            "</div>"
          ),
          popupOptions = popupOptions(maxWidth = 300),
          group = "Observations"
        )
      
    }) %>% bindEvent(input$submit) # END marker observer
    
    # Reset map------
    observe({
      # reset pickers
      updatePickerInput(session, "species_ID", selected = character(0))
      updatePickerInput(session, "site_ID",    selected = character(0))
      updatePickerInput(session, "habitat_ID", selected = character(0))
      updatePickerInput(session, "gap_ID",     selected = character(0))
      
      # reset slider
      updateSliderInput(session, "observation_ID",
                        value = c(min(leaflet_points$area_observations, na.rm = TRUE),
                                  max(leaflet_points$area_observations, na.rm = TRUE)))
      
      leafletProxy("leaflet_output", data = leaflet_points) %>%
        clearGroup("Observations") %>%
        addAwesomeMarkers(
          lng  = ~longitude,
          lat  = ~latitude,
          icon = awesomeIcons(
            icon        = "feather",
            library     = "fa",
            markerColor = "blue",
            iconColor   = "white"
          ),
          popup = ~paste0(
            "<div style='max-height:200px; overflow-y:auto;'>",
            "<b>", study_area, "</b><br>",
            "<b> Survey Type: </b>", survey_type, "<br>",
            "<b> Habitat Type: </b>", habitat_type, "<br>",
            "<b> GAP Status: </b>", gap_sts, "<br>",
            "<b> Observations: </b>", area_observations, "<br>",
            "<b>Species:</b><br>", 
            gsub(", ", "<br>", species),
            "</div>"
          ),
          popupOptions = popupOptions(maxWidth = 300),
          group = "Observations"
        )
    }) %>% bindEvent(input$reset) # End reset map 
  }
