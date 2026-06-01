#### ui.R ####

# ---- COLOUR PALETTE (all custom colours defined here for easy swapping) ----
#
#   Navy dark    #1E3A5F   — primary headings, root node background
#   Navy mid     #2C4A6E   — category node background, detail panel border
#   Navy light   #3D5A80   — branch node background
#   Slate        #6B7F96   — secondary text, leaf subtext
#   Teal dark    #0D6E56   — active/hover accents, divider, dot colour
#   Teal mid     #1A8A6A   — hover borders, active leaf border
#   Teal light   #D0EDE3   — leaf junction dot fill (inactive)
#   Teal wash    #EBF5F0   — hover background, active background
#   Sand light   #F5F5F2   — alternating section background
#   Warm white   #FFFFFF   — card/leaf backgrounds
#   Coral        #C85A2A   — warn/disclaimer accent, slider fill
#   Amber        #B87217   — stat accent (species)
#   Purple       #4A3FA0   — stat accent (habitat)
#   Blue         #185FA5   — badge text, CTA link colour
#   Blue wash    #E6F1FB   — badge background
#   Border light rgba(0,0,0,0.10)  — card borders
#   Border faint rgba(0,0,0,0.06)  — leaf dividers


#### dashboardHeader ####
header <- dashboardHeader(
  title = tagList(
    img(src = "BirdWatch_logo.png", height = "40px"),
    strong("BirdWatch")
  ),
  titleWidth = 230
) # END dashboardHeader


#### dashboardSidebar ####
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Story",   tabName = "welcome",   icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("feather")),
    menuItem(text = "Choices",   tabName = "choices",   icon = icon("question"))
  ) # END sidebarMenu
) # END dashboardSidebar


#### welcome tab styles ####
welcome_css <- tags$head(
  tags$style(HTML("
    .scrolly-container {
      position: relative;
      width: 100%;
    }
    .scrolly-section {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
    }
    .static-section {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: grey;
    }
    .background-section {
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
    }
    .text-box {
      background: rgba(255, 255, 255, 0.95);
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      max-width: 700px;
      margin: 20px;
    }
    .text-box h2 {
      color: #333;
      margin-bottom: 15px;
    }
    .text-box p {
      color: #666;
      line-height: 1.6;
    }
    .align-left  { justify-content: flex-start;  padding-left: 50px; }
    .align-right { justify-content: flex-end;    padding-right: 50px; }
    .align-center { justify-content: center; }

    /* remove default tab padding */
    .tab-content > .tab-pane { padding: 0 !important; }
    .content-wrapper { padding: 0 !important; }
  "))
) # END welcome tab styles


#### welcome tabItem ####
welcome_tab <- tabItem(
  tabName = "welcome",
  
  div(
    class = "scrolly-container",
    
    # Section 1: Heading
    div(
      class = "scrolly-section static-section",
      style = "background-image: url('Laird-Henkel.jpg'); 
           background-size: cover; 
           background-position: center;",
      div(
        class = "text-box",
        tags$h1("Mind the GAP: Avian responses to conservation investment in California"),
        tags$p("Scroll down to explore our interactive story"),
        tags$i(class = "bi bi-arrow-down", style = "font-size: 2rem;")
      )
    ),
    
    # Section 2: Background
    div(
      class = "scrolly-section background-section align-left",
      style = "background-image: linear-gradient(rgba(0,0,0,0), rgba(0,0,0,0)), url('Slide2.png');
               background-size: 100% auto;",
      div(
        class = "text-box",
        tags$h2("The Issue"),
        tags$p("Across the world biodiversity is declining, this is particularly harmful for birds.")
      )
    ),
    
    # Section 3: 30x30
    div(
      class = "scrolly-section background-section align-right",
      style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('dusk_stephanie_coates.jpg');",
      div(
        class = "text-box",
        tags$h2("The Solution"),
        tags$img(
          src = "30x30.png",       # must be in www/ folder
          style = "width: 100%;
             height: auto;
             border-radius: 8px;" # optional styling
        )
      )
    ),
    # Section 3.2: 30x30
    div(
      class = "scrolly-section background-section align-left",
      style = "background-image: linear-gradient(rgba(0,0,0,0.3), 
              rgba(0,0,0,0.3)), 
              url('dusk_stephanie_coates.jpg');
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      gap: 20px;",
      
      div(
        class = "text-box",
        tags$h2("Conserve", tags$strong("30%"),
                "of California’s land and coastal water by", 
                tags$strong("2030"))),
      div(
        class = "text-box",
        tags$h2(tags$strong("Promote biodiversity"), ", enhance land access and climate resilience")
      )
    ),
    
    # Section 4: why birds/ 30x30 assessment
    div(
      class = "scrolly-section background-section align-center",
      style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('dusk_stephanie_coates.jpg');
      display: flex;
      flex-direction: column;
      gap: 20px;",
      div(
        class = "text-box",
        tags$h2(tags$strong("We're halfway to 2030")),
        tags$p("How are we doing?")),
      div(
        class = "text-box",
        tags$h2("Success is measured in acreage:", tags$strong("26.1% of 30%"),
                "of target acreage currently acquired"),
        tags$p("But can we expect to see biodiversity increase in protected areas?")
      )
    ),
    ## Birds as a proxy
    div(
      class = "scrolly-section background-section align-center",
      style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('dusk_stephanie_coates.jpg');
           display: flex;
           flex-direction: column;
           gap: 20px;",
      
      div(
        class = "text-box",
        tags$h2(tags$strong("We used birds as a proxy"))
      ),
      
      div(
        class = "text-box",
        style = "display: flex;
             flex-direction: row;
             align-items: center;
             gap: 20px;",
        tags$img(
          src = "owls.png",
          style = "width: 50%;
               height: auto;
               border-radius: 0px;"
        ),
        tags$ul(
          style = "list-style-type: disc;
           font-size: 3rem;",
          tags$li("Highly observed"),
          tags$li("Sensitive to Habitat Change"),
          tags$li("Charismatic")
        )
      )
    ),
    ## Point blue intro 
    div(
      class = "scrolly-section background-section align-left",
      style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('Yvonne-Wright-SPCA.png');",
      div(
        class = "text-box",
        tags$img(
          src = "pblogo.png",       
          style = "width: 50%;
             height: auto;
             border-radius: 8px;"
        ),
        tags$p(style = "font-size: 2rem;",
               "Non-profit conserving birds and other wildlife"),
        tags$img(
          src = "akn.png",       
          style = "width: 55%;
             height: auto;
             border-radius: 8px;" 
        ),
        tags$p(style = "font-size: 2rem;",
               "Supporting accessible bird data collected by scientists on AKN")
      )
    )
  ) 
)# END welcome tabItem


#### choices tabItem styles ####
choices_css <- tags$head(
  tags$style(HTML("
    .choices-outer {
      padding: 2.5rem 2rem;
      max-width: 920px;
      margin: 0 auto;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    }
    .choices-header { margin-bottom: 2.5rem; }
    .choices-header h2 {
      font-size: 1.5rem; font-weight: 500;
      color: #1E3A5F;
      margin-bottom: 0.3rem;
    }
    .choices-header p {
      font-size: 0.85rem;
      color: #6B7F96;
      margin: 0;
    }

    .vtree { display: flex; flex-direction: column; gap: 0; }
    .vtree-branch { display: flex; flex-direction: column; position: relative; }
    .vtree-branch::before {
      content: ''; position: absolute;
      left: 20px; top: 52px; bottom: 0; width: 1px;
      background: #D0DCE8;
      z-index: 0;
    }
    .vtree-branch:last-child::before { display: none; }

    .vtree-root-node {
      display: flex; align-items: center; gap: 12px;
      padding: 0.75rem 1rem;
      background: #FFFFFF;
      border: 1px solid #D0DCE8;
      border-radius: 10px;
      cursor: pointer; user-select: none;
      transition: border-color 0.2s, background 0.2s;
      position: relative; z-index: 1;
      margin-bottom: 4px;
    }
    .vtree-root-node:hover {
      border-color: #1A8A6A;
      background: #EBF5F0;
    }
    .vtree-root-node.open {
      border-color: #0D6E56;
      background: #EBF5F0;
      border-bottom-left-radius: 4px;
      border-bottom-right-radius: 4px;
    }
    .vtree-icon {
      width: 34px; height: 34px; border-radius: 8px;
      background: #DCF0E8;
      display: flex; align-items: center; justify-content: center;
      font-size: 1rem; flex-shrink: 0;
      color: #0D6E56;
    }
    .vtree-root-label {
      flex: 1; font-size: 0.9rem; font-weight: 500;
      color: #1E3A5F;
    }
    .vtree-root-count {
      font-size: 0.7rem; font-weight: 600;
      color: #0D6E56;
      background: #C6E8DA;
      padding: 2px 7px; border-radius: 10px;
    }
    .vtree-chevron {
      font-size: 0.6rem;
      color: #9AAEC0;
      transition: transform 0.25s;
    }
    .vtree-root-node.open .vtree-chevron { transform: rotate(90deg); }

    .vtree-leaves {
      display: none; flex-direction: column;
      padding-left: 40px; margin-bottom: 12px;
      position: relative;
    }
    .vtree-leaves.open { display: flex; }

    .vtree-leaf {
      display: flex; flex-direction: column;
      position: relative; margin-bottom: 4px;
    }
    .vtree-leaf::before {
      content: ''; position: absolute;
      left: -20px; top: 22px;
      width: 20px; height: 1px;
      background: #D0DCE8;
    }
    .vtree-leaf::after {
      content: ''; position: absolute;
      left: -23px; top: 19px;
      width: 7px; height: 7px; border-radius: 50%;
      background: #C6E8DA;
      border: 1.5px solid #1A8A6A;
    }
    .vtree-leaf.active::after {
      background: #0D6E56;
      border-color: #0D6E56;
    }
    .vtree-leaf-header {
      display: flex; align-items: center; gap: 8px;
      padding: 0.55rem 0.85rem;
      background: #FFFFFF;
      border: 0.5px solid #D8E4EE;
      border-radius: 8px; cursor: pointer;
      font-size: 0.875rem; font-weight: 500;
      color: #2A3A4A;
      transition: background 0.15s, border-color 0.15s;
    }
    .vtree-leaf-header:hover {
      background: #EBF5F0;
      border-color: #8ABFAE;
    }
    .vtree-leaf.active .vtree-leaf-header {
      background: #EBF5F0;
      border-color: #0D6E56;
      color: #0D3D2A;
    }
    .vtree-leaf-chevron {
      font-size: 0.6rem;
      color: #B0C4D8;
      transition: transform 0.2s; margin-left: auto;
    }
    .vtree-leaf.active .vtree-leaf-chevron {
      transform: rotate(90deg);
      color: #0D6E56;
    }
    .vtree-leaf-body {
      display: none;
      font-size: 0.82rem; line-height: 1.7;
      color: #4A5568;
      padding: 0.65rem 0.85rem;
      margin-top: 2px;
      background: #F7FBFA;
      border: 0.5px solid #C6DDD5;
      border-radius: 0 0 8px 8px;
      border-top: none;
    }
    .vtree-leaf.active .vtree-leaf-body { display: block; }
  "))
) # END choices tab styles


#### choices tabItem ####
choices_tab <- tabItem(
  tabName = "choices",
  
  div(class = "choices-outer",
      
      div(class = "choices-header",
          tags$h2("Watershed Monitoring — Key Concepts"),
          tags$p("Select a category, then click any item to expand its description.")
      ), # END choices header
      
      div(class = "vtree",
          
          #### branch 1 — study sites ####
          div(class = "vtree-branch",
              
              div(class = "vtree-root-node",
                  onclick = "vtreeBranch(this, 'sites-leaves')",
                  div(class = "vtree-icon", "\U0001F4CD"),
                  div(class = "vtree-root-label", "Study Sites"),
                  div(class = "vtree-root-count", "3 sites"),
                  tags$span(class = "vtree-chevron", "\u25B6")
              ), # END branch 1 header
              
              div(id = "sites-leaves", class = "vtree-leaves",
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header",
                          onclick = "vtreeLeaf(this.parentNode)",
                          "Teshekpuk Lake",
                          tags$span(class = "vtree-leaf-chevron", "\u25B6")
                      ),
                      div(class = "vtree-leaf-body",
                          "Teshekpuk Lake is one of the largest lakes on the Arctic Coastal Plain.
               It serves as a critical staging ground for molting geese and supports
               exceptionally high densities of breeding waterbirds. Monitoring here
               focuses on water clarity, dissolved oxygen, and fish assemblage shifts
               driven by permafrost thaw drainage."
                      )
                  ), # END leaf 1a
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header",
                          onclick = "vtreeLeaf(this.parentNode)",
                          "Judy Lake",
                          tags$span(class = "vtree-leaf-chevron", "\u25B6")
                      ),
                      div(class = "vtree-leaf-body",
                          "Judy Lake is a smaller thermokarst lake formed by permafrost collapse.
               It is monitored for methane flux, nutrient loading, and the presence
               of invasive aquatic vegetation. Its shallow depth makes it highly
               sensitive to air temperature anomalies."
                      )
                  ), # END leaf 1b
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header",
                          onclick = "vtreeLeaf(this.parentNode)",
                          "Smith Lake",
                          tags$span(class = "vtree-leaf-chevron", "\u25B6")
                      ),
                      div(class = "vtree-leaf-body",
                          "Smith Lake sits at the confluence of two braided stream channels and
               experiences periodic flooding that resets benthic communities. It is
               a reference site for baseline macroinvertebrate diversity across the
               broader watershed."
                      )
                  ) # END leaf 1c
                  
              ) # END sites leaves
              
          ), # END branch 1 — study sites
          
          
          #### branch 2 — habitat types ####
          div(class = "vtree-branch",
              
              div(class = "vtree-root-node",
                  onclick = "vtreeBranch(this, 'habitat-leaves')",
                  div(class = "vtree-icon", "\U0001F33F"),
                  div(class = "vtree-root-label", "Habitat Types"),
                  div(class = "vtree-root-count", "4 types"),
                  tags$span(class = "vtree-chevron", "\u25B6")
              ), # END branch 2 header
              
              div(id = "habitat-leaves", class = "vtree-leaves",
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Lacustrine", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "Lacustrine habitats encompass open water lake systems deeper than 2 m.
               They support pelagic fish species, zooplankton communities, and diving
               waterfowl. These habitats are the primary focus of water quality sampling
               and acoustic fish surveys.")
                  ), # END leaf 2a
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Palustrine", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "Palustrine habitats include shallow marshes, wet meadows, and bogs
               fringing the lake margins. They provide breeding habitat for shorebirds
               and amphibians and act as nutrient filters before runoff reaches open water.")
                  ), # END leaf 2b
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Riverine", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "Riverine habitats are the flowing water corridors that connect lakes
               within the watershed. They support spawning runs of broad whitefish and
               Arctic grayling and are monitored for flow regime, turbidity, and
               temperature during snowmelt.")
                  ), # END leaf 2c
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Estuarine", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "Estuarine habitats occur where Fish Creek meets coastal influence near
               the Beaufort Sea. Salinity gradients here create transition zones that
               support unique invertebrate assemblages and are sensitive to sea-level
               and storm surge variability.")
                  ) # END leaf 2d
                  
              ) # END habitat leaves
              
          ), # END branch 2 — habitat types
          
          
          #### branch 3 — monitoring parameters ####
          div(class = "vtree-branch",
              
              div(class = "vtree-root-node",
                  onclick = "vtreeBranch(this, 'params-leaves')",
                  div(class = "vtree-icon", "\U0001F9EA"),
                  div(class = "vtree-root-label", "Monitoring Parameters"),
                  div(class = "vtree-root-count", "3 types"),
                  tags$span(class = "vtree-chevron", "\u25B6")
              ), # END branch 3 header
              
              div(id = "params-leaves", class = "vtree-leaves",
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Water Quality", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "Water quality sampling includes measurements of pH, conductivity,
               turbidity, dissolved oxygen, total nitrogen, and total phosphorus.
               Samples are collected monthly at fixed stations from ice-out through
               freeze-up and bi-monthly under ice.")
                  ), # END leaf 3a
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Fish Assemblage", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "Fish assemblage surveys use fyke nets, gill nets, and hydroacoustic
               transects to estimate species composition, relative abundance, and
               size structure. Results are used to track community shifts in response
               to warming water temperatures.")
                  ), # END leaf 3b
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Benthic Invertebrates", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "Benthic invertebrate samples are collected via Ekman grab at three
               depth strata per lake. Taxonomic richness and functional feeding group
               composition serve as biological indicators of ecosystem condition.")
                  ) # END leaf 3c
                  
              ) # END params leaves
              
          ), # END branch 3 — monitoring parameters
          
          
          #### branch 4 — GAP status ####
          div(class = "vtree-branch",
              
              div(class = "vtree-root-node",
                  onclick = "vtreeBranch(this, 'gap-leaves')",
                  div(class = "vtree-icon", "\U0001F6E1"),
                  div(class = "vtree-root-label", "GAP Protection Status"),
                  div(class = "vtree-root-count", "3 levels"),
                  tags$span(class = "vtree-chevron", "\u25B6")
              ), # END branch 4 header
              
              div(id = "gap-leaves", class = "vtree-leaves",
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Status 1 — Permanently Protected", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "GAP Status 1 areas are managed for biodiversity and prohibit most
               extractive uses. Within Fish Creek Watershed, Status 1 areas include
               designated wilderness and wildlife refuge core zones.")
                  ), # END leaf 4a
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Status 2 — Protected, Some Use Allowed", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "GAP Status 2 areas are managed to maintain natural communities but
               may allow limited sustainable harvest or recreation. Most of the
               National Petroleum Reserve buffer zones fall here.")
                  ), # END leaf 4b
                  
                  div(class = "vtree-leaf",
                      div(class = "vtree-leaf-header", onclick = "vtreeLeaf(this.parentNode)",
                          "Status 3 — Multiple Use", tags$span(class = "vtree-leaf-chevron", "\u25B6")),
                      div(class = "vtree-leaf-body",
                          "Status 3 lands are subject to extraction and development with varying
               levels of environmental review. Monitoring data from these areas helps
               assess cumulative impacts relative to protected benchmarks.")
                  ) # END leaf 4c
                  
              ) # END gap leaves
              
          ) # END branch 4 — GAP status
          
      ) # END vtree
      
  ), # END choices-outer
  
  tags$script(HTML("
    function vtreeBranch(headerEl, leavesId) {
      var isOpen = headerEl.classList.contains('open');
      document.querySelectorAll('.vtree-root-node').forEach(function(n) { n.classList.remove('open'); });
      document.querySelectorAll('.vtree-leaves').forEach(function(l) { l.classList.remove('open'); });
      if (!isOpen) {
        headerEl.classList.add('open');
        document.getElementById(leavesId).classList.add('open');
      }
    }
    function vtreeLeaf(leafEl) {
      var isActive = leafEl.classList.contains('active');
      leafEl.closest('.vtree-leaves').querySelectorAll('.vtree-leaf').forEach(function(l) {
        l.classList.remove('active');
      });
      if (!isActive) leafEl.classList.add('active');
    }
  "))
  
) # END choices tabItem


#### dashboard tabItem ####
dashboard_tab <- tabItem(
  tabName = "dashboard",
  
  box(width = 4,
      title = tags$strong("Adjust Avian View:"),
      
      pickerInput(
        inputId  = "species_ID",
        label    = "Select Species",
        choices  = unique(species_list$common_name),
        multiple = TRUE,
        options  = pickerOptions(liveSearch = TRUE)
      ), # END species pickerInput
      
      pickerInput(
        inputId  = "site_ID",
        label    = "Select Study Site",
        choices  = unique(leaflet_points$study_area),
        multiple = TRUE,
        options  = pickerOptions(liveSearch = TRUE)
      ), # END study area pickerInput
      
      sliderInput(
        inputId = "observation_ID",
        label   = "Number of Observations (per Study area)",
        min     = min(leaflet_points$area_observations, na.rm = TRUE),
        max     = max(leaflet_points$area_observations, na.rm = TRUE),
        value   = c(min(leaflet_points$area_observations, na.rm = TRUE),
                    max(leaflet_points$area_observations, na.rm = TRUE))
      ), # END observation sliderInput
      
      checkboxGroupInput(
        inputId = "survey_ID",
        label = 'Survey Method',
        choices = unique(leaflet_points$survey_type)
      ), # END survey type checkboxGroupInput
      
      pickerInput(
        inputId  = "habitat_ID",
        label    = "Habitat Types",
        choices  = habitat_choices,
        multiple = TRUE
      ), # END habitat type pickerInput
      
      pickerInput(
        inputId  = "gap_ID",
        label    = "GAP Status",
        multiple = TRUE,
        choices  = sort(unique(leaflet_points$gap_sts))
      ), # END gap status pickerInput
      
      shinyWidgets::chooseSliderSkin(skin = "Flat", color = "#2C4A6E"),
      
      actionButton("submit", "Update Plot"),
      actionButton("reset",  "Reset Map")
      
  ), # END input box
  
  box(
    width = 8,
    height = 700,
    leafletOutput(outputId = "leaflet_output", height = "663px") %>%
      withSpinner(type = 8, color = "#1A8A6A")
  ) # END leaflet box
  
) # END dashboard tabItem


#### dashboardBody ####
body <- dashboardBody(
  welcome_css,
  choices_css,
  tabItems(
    welcome_tab,
    dashboard_tab,
    choices_tab
  )
) # END dashboardBody


#### dashboardPage ####
dashboardPage(header, sidebar, body)