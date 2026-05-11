# ---- dashboardHeader ----
header <- dashboardHeader(
  
  # title ----
  title = tagList(icon = icon('fish'), strong("Fish Creek Watershed Lake Monitoring")),
  titleWidth = 400
  
)


# ---- dashboardSidebar ----
sidebar <- dashboardSidebar(
  
  # sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", 
             tabName = "welcome", 
             icon = icon("star")),
    
    menuItem(text = "Dashboard", 
             tabName = "dashboard", 
             icon = icon('feather'))
    
  ) # END sidebarMenu
) #END dashboardSidebar


# ---- dashboardBody ----
body <- dashboardBody(
  use_theme('fresh_dashboard.css'),
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(
      tabName = "welcome",
      
      # left hand column ----
      column(width =6,
             
             # background box,
             box(width = NULL,
                 
                 title = tagList(icon("water"), strong("Monitoring Fish Creek Watershed")),
                 includeMarkdown("text/intro.md"),
                 tags$img(src = "FishCreekWatershedSiteMap_2020.jpg",
                          alt = "A map of northern Alaska, showing Fish Creek Watershed located within the National Petroleum Reserve.",
                          style = "max-width: 100%"),
                 tags$p(tags$em("Map Source:", 
                                tags$a(href = 'http://www.fishcreekwatershed.org/',
                                       "FCWO")),
                        style = "text-align: center;")
                 
                 
             ) # END background box
      ), #END left hand column
      
      # right hand column ----
      column(width = 6,
             
             # data source box
             box(width = NULL,
                 
                 title = tagList(icon("hashtag"), strong("Data Citation")),
                 includeMarkdown("text/citation.md")
                 
                 
             ), #data source box
             
             # disclaimer box
             box(width = NULL,
                 
                 title = tagList(icon("exclamation"), strong("Disclaimer")),
                 includeMarkdown("text/disclaimer.md")
                 
             )#END disclaimer box
      ) #END right hand column
    ), # END welcome tabItem
    
    # dashboard tabItem ----
    tabItem(
      
      tabName = "dashboard",
      
      # input box ----
      box(width = 4,
          
          title = tags$strong("Adjust Lake Parameter Ranges:"),
          
          # Species pickerInput -------
          pickerInput(
            inputId  = "species_ID",
            label    = "Select Species",
            choices  = unique(species_list$common_name),
            multiple = TRUE,
            options  = pickerOptions(liveSearch = TRUE)
          ), # End species pickerInput
          
          # Study_area pickerInput -----
          pickerInput(inputId = 'site_ID',
                      label = 'Select Study Site',
                      choices = unique(leaflet_points$study_area),
                      multiple = TRUE,
                      options  = pickerOptions(liveSearch = TRUE)),
          
          # observation sliderInput ----
          sliderInput(inputId = "observation_ID",
                      label = "Number of Observations (per Study area)",
                      min   = min(leaflet_points$area_observations, na.rm = TRUE),
                      max   = max(leaflet_points$area_observations, na.rm = TRUE),
                      value = c(min(leaflet_points$area_observations, na.rm = TRUE),
                                max(leaflet_points$area_observations, na.rm = TRUE))), #END elevation sliderInput
          
          # habitat type pickerInput ----
          pickerInput(inputId = "habitat_ID",
                      label = 'Habitat Types',
                      choices = habitat_choices,
                      multiple = TRUE), # End habitat pickerInput
          
          # gap_sts pickerInput ----
          pickerInput(inputId = 'gap_ID',
                      label = 'GAP Status',
                      multiple = TRUE, 
                      choices = unique(leaflet_points$gap_sts)), # End gap_sts pickerInput
          
          # Change slider color and style ----
          shinyWidgets::chooseSliderSkin(skin = 'Flat',color = '#A0185A'), #END slider color,
          
          actionButton("submit", "Update Plot"),
          
          actionButton("reset", "Reset Map")
          
      ), # END input box
      
      # leaflet box ----
      box(width = 8,
          
          leafletOutput(outputId = "leaflet_output") %>% 
            withSpinner(type = 8,
                        color = 'pink')
          
      ) # END leaflet box
      
    ) # END dashboard tabItem
    
  ) # END tabItems
  
) # END dashboardBody

# ---- combine all into dashboardPage ----
dashboardPage(header, sidebar, body)
  