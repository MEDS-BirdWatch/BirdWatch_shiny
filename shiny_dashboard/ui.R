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
    
    # Heading ----
    div(
      class = "scrolly-section static-section",
      style = "background-image: url('Laird-Henkel.jpg'); 
           background-size: cover; 
           background-position: center;",
      div(
        class = "text-box",
        tags$h1("Mind the GAP: Avian responses to conservation investment in California"),
        tags$p("Scroll down to explore our interactive story (best experienced in full screen)"),
        tags$i(class = "bi bi-arrow-down", style = "font-size: 2rem;")
      )
    ),
    
    # Background ----
    div(
      class = "scrolly-section background-section align-left",
      style = "background-image: linear-gradient(rgba(0,0,0,0), rgba(0,0,0,0)), url('Slide2.png');
               background-size: 100% auto;",
      div(
        class = "text-box",
        style = "width: 500px;",
        tags$h2("The Issue",
                style = "font-size: 3rem;"),
        tags$p("Across the world biodiversity is declining, this is particularly harmful for birds.",
               style = "font-size: 2rem;")
      )
    ),
    
    # 30x30 -----
    div(
      class = "scrolly-section background-section align-right",
      style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('dusk_stephanie_coates.jpg');",
      div(
        class = "text-box",
        style = "width: 700px;",
        tags$h2("The Solution",
                style = "text-align: center;"),
        tags$img(
          src = "30x30.png",
          style = "width: 80%; height: auto; border-radius: 8px; display: block; margin: 0 auto;"
        )
      )
    ),
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
    
    #why birds/ 30x30 assessment ----
    div(
      class = "scrolly-section background-section align-center",
      style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('dusk_stephanie_coates.jpg');
      display: flex;
      flex-direction: column;
      gap: 20px;",
      div(
        class = "text-box",
        tags$h2(tags$strong("We're halfway to 2030",
                            style = "font-size: 4rem")),
        tags$p("How are we doing?",
               style = "font-size: 2rem;
                        text-align: center;")),
      div(
        class = "text-box",
        tags$h2("Success is measured in acreage:", tags$strong("26.1% of 30%"),
                "of target acreage currently acquired",
                style = "font-size: 3rem;"),
        tags$p("But can we expect to see biodiversity increase in protected areas?",
               style = "font-size: 2rem;
                        text-align: center;")
      )
    ),
    ## Birds as a proxy ----
    div(
      class = "scrolly-section background-section align-center",
      style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('dusk_stephanie_coates.jpg');
           display: flex;
           flex-direction: column;
           gap: 20px;",
      
      div(
        class = "text-box",
        tags$h2(tags$strong("We used birds as a proxy for biodiversity"))
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
    ## Point blue intro ----
    div(
      class = "scrolly-section background-section align-center",
      style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('Yvonne-Wright-SPCA.png');",
      div(
        style = "display: flex; flex-direction: row; gap: 20px; align-items: flex-start;",
        div(
          class = "text-box",
          style = "text-align: center;",
          tags$img(
            src = "pblogo.png",
            style = "width: 80%; height: auto; border-radius: 8px; display: block; margin: 0 auto 40px auto;"
          ),
          tags$p("Non-profit conserving birds and other wildlife", style = "font-size: 2rem;")
        ),
        div(
          class = "text-box",
          style = "text-align: center;",
          tags$img(
            src = "akn.png",
            style = "width: 80%; height: auto; border-radius: 8px; display: block; margin: 0 auto 40px auto;"
          ),
          tags$p("Supporting accessible bird data collected by scientists on AKN", style = "font-size: 2rem;")
        )
      )
    )
  ), 
  # Objectives ----
  div(
    class = "scrolly-section background-section align-center",
    style = "background-image: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('Linda-Mar-beach-jenny-erbes.jpg');",
    div(
      class = "text-box",
      tags$h2(tags$strong("Objectives"),
              style = "font-size: 4rem;"),
      tags$ol(
        style = "font-size: 2rem; line-height: 2;",
        tags$li("Develop evidence for the effects of conservation investment paths on bird biodiversity in California"),
        tags$li("Make our workflows and results reproducible for future use by conservation experts")
      )
    )
  ),
  #Our Approach ----
  div(
    class = "scrolly-section background-section align-center",
    style = "background-image: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), 
           url('Linda-Mar-beach-jenny-erbes.jpg'); 
           display: flex;
           flex-direction: column;
           gap: 10px;",
    div(
      class = "text-box",
      tags$h2(tags$strong("Our Approach"),
              style = "font-size: 4rem;
                       text-align: center"),
      tags$p(style = "font-size: 2rem; color: #555;",
             "Bird observations (location, time, species) + Habitat type (CAL FIRE habitats) + Protection status (land classification)"),
      tags$hr()
    ),
    div(class = "text-box",
        tags$li(tags$strong("Calculated bird biodiversity index"))),
    div(class = "text-box",
        tags$li(tags$strong("Created generalized linear mixed models (GLMMs)"))),
    div(class = "text-box",
        tags$li(tags$strong("Evaluated population trends of select bird species within their associated habitats"))),
    div(class = "text-box",
        tags$li(tags$strong("Assessed patterns in biodiversity within habitat type by protection status")))
  ),
  #Deliverables ----
  div(
    class = "scrolly-section background-section align-center",
    style = "background-image: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('snapwire_santa_barbara.jpg');
    display: flex;
           flex-direction: column;
           gap: 20px;",
  div(
      class = "text-box",
      tags$h2(tags$strong("Deliverables"),
              style = "font-size: 4rem;
                       text-align: center")),
  div(class = "text-box",
      tags$p(tags$i(class = "fa-solid fa-folder-tree") ,
             tags$strong("  Publicly documented analyses that can be reused using AKN data"),
              style = "font-size: 3rem")),
  div(class = "text-box",
      tags$p(tags$i(class = "fa-solid fa-file-lines"), 
             tags$strong("  Technical report summarizing our findings and recommendations"), 
             style = "font-size: 3rem;")),
  div(class = "text-box",
      tags$p(tags$i(class = "fa-solid fa-map-location-dot"),
             tags$strong("  Interactive dashboard to display data and highlight areas of need"),
             style = "font-size: 3rem"))
),
# Quantifying Biodiversity ----
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('oystercatcher_alicia_arcidiacono.jpg');",
  div(
    class = "text-box",
    tags$h2(tags$strong("Quantifying Biodiversity"),
            style = "font-size: 3rem;
            text-align: center;"),
    tags$p(style = "font-size: 2rem;",
           "We calculated a biodiversity index for each survey site, combining species richness and relative abundance across AKN survey data from 1990 to 2025.")
  )
),
# California's Complexity ----
div(
  class = "scrolly-section background-section",
  style = "background-image: url('guide-of-the-world.png');
           display: flex;
           align-items: center;
           justify-content: center;
           position: relative;",
  tags$img(
    src = "habitats_whrall.png",
    style = "width: 100%; height: auto;"
  ),
  div(
    class = "text-box",
    style = "position: absolute; left: 20px; max-width: 25%",
    tags$p(style = "font-size: 5rem; align: center", tags$strong("California's Complexity")),
    tags$p(style = "font-size: 2rem;",
           "California is one of the most ecologically diverse regions in the world. It has a mediterrenean climate and over 60 distinct habitat types, a few of which can be seen here:")
    
  ),
),
div(
  class = "scrolly-section background-section",
  style = "background-image: url('guide-of-the-world.png');
           display: flex;
           align-items: flex-start;
           justify-content: left;
           position: relative;",
  tags$img(
    src = "habitats.png",
    style = "width: 80%; height: auto;"
  ),
  div(
    class = "text-box",
    style = "position: absolute; right: 300px; top: 200px; max-width: 30%;",
    tags$p(style = "font-size: 5rem; text-align: center;", tags$strong("We Aggregated")),
    tags$p(style = "font-size: 2rem;",
           "To make a more generalizable and understandable analysis, we used a simpler view of the habitat types,",
           tags$strong("aggregated"), "into 8 distinct habitat types")
  ),
  div(
    class = "text-box",
    style = "position: absolute; right: 200px; top: 550px; width: 300px;
    height : 700 px",
    tags$img(src = "habitat_types.png",
             style = "width: 100%"))
  ),
  # Survey types ----
div(
  class = "scrolly-section background-section",
  style = "background-image: url('swan_meadow_garret_costello.jpg');
           display: flex;
           align-items: center;
           justify-content: center;",
  div(
    style = "display: flex; flex-direction: column; align-items: center; gap: 20px;",
    div(
      class = "text-box",
      tags$h2(tags$strong("Survey Types"), style = "font-size: 3rem;")
    ),
    div(
      class = "text-box",
      tags$p("Our data consisted of two major survey types", tags$strong("Point Count"),
             "and", tags$strong("Area Search"),
             style = "font-size: 3rem;")
    )
  )
),
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: url('swan_meadow_garret_costello.jpg');",
  div(
    style = "display: flex; flex-direction: row; align-items: center; gap: 10px;",
    div(
      class = "text-box",
      tags$img(
        src = "point_count.png",
        style = "width: 100%; height: auto;"
      )
    ),
    div(
      class = "text-box",
      tags$p(tags$strong("Point Counts"),  "were conducted at fixed transects across multiple study sites between 1993 and 2025. Observers remained stationary for a fixed period (5–10 minutes), recording all birds detected by sight or sound within a predefined radius. They excell for generalized surveys over a large area."),
             style = "font-size: 2rem;")
    )
  ),
div(
  class = "scrolly-section background-section align-right",
  style = "background-image: url('swan_meadow_garret_costello.jpg');",
  div(
    style = "display: flex; flex-direction: row; align-items: center; gap: 10px;",
    div(
      class = "text-box",
      tags$p(tags$strong("Area Searches"),  "were conducted between 1990 and 2025. Observers moved through a defined area for a fixed duration, recording all birds observed. Area searches excell at uncovering specifics over small areas."),
      style = "font-size: 2rem;")
  ),
  div(
    class = "text-box",
    tags$img(
      src = "area_search.png",
      style = "width: 100%; height: auto;"
    )
  )
),

  # What did you find? ----
div(
  class = "scrolly-section background-section",
  style = "background-image: url('who_simon_dunne.jpg');
           display: flex;
           align-items: flex-start;
           justify-content: center;
           padding-top: 60px;",
  div(
    class = "text-box",
    tags$h2(tags$strong("What Did We Find?"), style = "font-size: 4rem;")
  )
),

# Data View ----
div(
  class = "scrolly-section background-section",
  style = "background-image: url('dashboard_screenshot.png'); background-size: contain; background-repeat: no-repeat; background-position: left center; background-color: #111;",
  div(
    class = "text-box",
    style = "position: absolute; right: 40px; max-width: 500px;",
    tags$h2(tags$strong("Where are we sampling?")),
    tags$p("The majority of AKN survey sites are concentrated in Northern California, leaving large gaps in coverage statewide.", style = "font-size: 2rem;")
  )
),
div(
  class = "scrolly-section background-section",
  style = "background-image: url('dashboard_screenshot_gap.png'); background-size: contain; background-repeat: no-repeat; background-position: left center; background-color: #111;",
  div(
    class = "text-box",
    style = "position: absolute; right: 40px; max-width: 500px;",
    tags$h2(tags$strong("GAP Status 1 is undersampled")),
    tags$p("Very few survey sites fall within GAP Status 1 protected lands — the areas most critical to assess for 30x30 success.", style = "font-size: 2rem;")
  )
),
# Biodiversity over time ----
div(
  class = "scrolly-section background-section",
  style = "background-image: url('dusk_stephanie_coates.jpg');
           display: flex; align-items: center; justify-content: center;",
  tags$img(
    src = "avg_biodiv_protection_plot.jpg",
    style = "width: 50%; height: auto; border-radius: 10px;"
  ),
  div(
    class = "text-box",
    style = "max-width: 400px;",
    tags$h2(tags$strong("Protected Areas Support Greater Bird Biodiversity")),
    tags$p("Average biodiversity from 1990–2025 was higher in 30x30 protected lands across most habitats.", 
           style = "font-size: 2rem;"))
),

# Biodiversity means ----
div(
  class = "scrolly-section background-section",
  style = "background-image: url('dusk_stephanie_coates.jpg');
           display: flex; align-items: center; justify-content: center; gap: 30px;",
  tags$img(
    src = "presentation.png",
    style = "width: 50%; height: auto; border-radius: 8px;"
  ),
  div(
    class = "text-box",
    style = "max-width: 300px;",
    tags$h2(tags$strong("Biodiversity in Protected Areas"),
            style = "font-size: 3rem;"),
    tags$p("Protection generally increases biodiversity — but the pattern varies by habitat and survey method.", style = "font-size: 2rem;")
  )
),
  
# Population trends
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('focal_species_weme_sosp_rwbl.png');",
  div(
    class = "text-box",
    style = "text-align: center;",
    tags$p(style = "font-size: 5rem; color: black;", tags$strong("Population Trends"))
  ), 
  div(
    class = "text-box",
    tags$p(style = "font-size: 2rem; color: black;", "Some species tell a bigger story. We selected focal species not at random, but as representatives of their habitats — chosen for their strong habitat associations and conservation relevance based on ",
           tags$a("Partners in Flight", href = "https://partnersinflight.org", target = "_blank"), ".")
  )
), 
# Second section - question 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('focal_species_weme_sosp_rwbl.png');
  display: flex; justify-content: center; align-items: center;",
  div(
    class = "text-box",
    tags$p(style = "font-size: 4rem; color: black;", tags$strong("They allow us to ask the question: Are 30x30 protected lands working to protect species of concern?"))
  )
), 
# Introduce focal species 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('focal_species_weme_sosp_rwbl.png');
  display: flex; justify-content: center; align-items: center;",
  div(
    class = "text-box",
    tags$img(
      src = "focal_species.png",
      style = "width: 100%; height: auto; border-radius: 8px;"
    ),
    tags$p(style = "font-size: 2rem; color: black;", "Taking observations for 7 focal species in only their respective habitats, we modeled their abundance from 1995 to 2024. ",
           tags$strong("What did we find?"))
  )
),
# Results 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('conifer_Bryant_Baker_ForestWatch.png');
  display: flex; justify-content: center; align-items: center;",
  div(
    class = "text-box", 
    tags$p(style = "font-size: 2rem; color: black;", "Across our seven focal species, five maintained stable populations in protected sites— suggesting that protected lands are successfully buffering these species from population declines. Protected sites also supported higher baseline abundance for the majority of species, reflecting the historical carrying capacities of these lands.")
  )
),
# Red-breasted nuthatch
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('conifer_Bryant_Baker_ForestWatch.png');",
  div(
    class = "text-box",
    tags$p(style = "font-size: 2rem; color: black;", "Red-breasted Nuthatch, our conifer species, maintained stable populations in protected sites while unprotected sites showed a promising increase.")
  ),
  div(
    style = "width: 260px; height: 260px; background-image: url('rbnu_cornell_.jpg');
      background-size: cover; background-position: center; border-radius: 4px; flex-shrink: 0;"
  )
), 
# Red-winged blackbird 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('Land_Conservation_Santa_Rita_Ranch_.png');",
  div(
    class = "text-box",
    tags$p(style = "font-size: 2rem; color: black;", "Red-winged Blackbird, our working lands species, maintained stable populations in protected sites while unprotected agricultural lands showed a declining trend — a warning sign for California's farming landscapes.")
  ),
  div(
    style = "width: 260px; height: 260px; background-image: url('rwbl_audubon.png');
      background-size: cover; background-position: center; border-radius: 4px; flex-shrink: 0;"
  )
),
# Western Meadowlark 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('grasslands_@scitechdaily.png');",
  div(
    class = "text-box",
    tags$p(style = "font-size: 2rem; color: black;", "Western Meadowlark, our grassland species, showed a slight declining trend in protected sites and an increase in unprotected sites — particularly those under active stewardship in GAP status 3 — suggesting that managed lands may be supporting grassland recovery.")
  ),
  div(
    style = "width: 260px; height: 260px; background-image: url('weme_adobe.png');
      background-size: cover; background-position: center; border-radius: 4px; flex-shrink: 0;"
  )
),
# Wrentit 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('shrub_nps_@jessica_wienberg_McClosky.jpg');",
  div(
    class = "text-box",
    tags$p(style = "font-size: 2rem; color: black;", "Wrentit, our shrub species, showed stable populations in protected sites and a significant increase in unprotected lands, particularly in the least protected areas, potentially due to expanding shrub habitat in these lands.")
  ),
  div(
    style = "width: 260px; height: 260px; background-image: url('wrentit-manish-sharma.jpg');
      background-size: cover; background-position: center; border-radius: 4px; flex-shrink: 0;"
  )
), 
# Summarize results - part 1 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('sierra_michael_mahoney.jpg');",
  div(
    class = "text-box",
    tags$p(style = "font-size: 5rem; color: black;", tags$strong("Let's summarize")), 
    tags$p(style = "font-size: 2rem; color: black;", "The results of our biodiversity analysis and focal species trends suggest that protection is indeed working to promote biodiversity in 30x30 protected areas, though the effectiveness varies by habitat.")
  )
), # Summarize results - part 2 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('sierra_michael_mahoney.jpg');",
div(
  class = "text-box",
  tags$p(style = "font-size: 2rem; color: black;", "While stable populations were observed for some species within these protected lands, others exhibited diverging trends, indicating that protection alone is not always sufficient. Further analysis revealed that active stewardship practices in unprotected areas also play a significant role in promoting biodiversity, as demonstrated by the positive trends observed in Western Meadowlark populations. This nuanced story highlights the importance of both protected areas and proactive conservation efforts in preserving biodiversity.")
),
),
# Next steps 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('Dick-Evans.jpg');",
  div(
    class = "text-box",
    tags$p(style = "font-size: 5rem; color: black;", tags$strong("Next steps")), 
    tags$p(style = "font-size: 2rem; color: black;", "This analysis was designed to give a high-level view, and broad patterns emerged that now point us toward the next questions. In addition to integrating more data into our models, we recommend a finer-scale analysis that drills deeper into specific habitats to identify the mechanisms driving the patterns we observed.")
  )
),
# Conclusion
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('plover_parent_jenny_erbes.jpg');",
  div(
    class = "text-box",
    tags$p(style = "font-size: 5rem; color: black;", tags$strong("Conclusion")), 
    tags$p(style = "font-size: 2rem; color: black;", "California is nearly four years from its 2030 deadline. Our results suggest that protection policies are working to conserve biodiversity — but targeted acquisition of unprotected lands showing recovery potential, paired with better monitoring to fill the data gaps we identified, will determine whether California can build a truly biodiverse future by 2030 and beyond.")
  )
), 
# BirdWatch Thank you 
div(
  class = "scrolly-section background-section align-left",
  style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('plover_parent_jenny_erbes.jpg');",
  div(
    class = "text-box",
    tags$img(
      src = "Bird_Watch.jpg",
      style = "width: 100%; height: auto; border-radius: 8px;"
    ),
    tags$p(style = "font-size: 3rem; color: black;", tags$strong("Thank you for reading!")), 
    tags$p(style = "font-size: 2rem; color: black;", "This Storymap and Dashboard were created by Peter Vitalie, Nathalie Bonnet, and Isabella Segarra as part of the Masters in Environmental Data Science Capstone Project.")
  )
), 
# Photo credits 
div(
  class = "scrolly-section",
  style = "background: #f5f5f5; padding: 2rem 3rem;",
  tags$p(style = "font-size: 1rem; color: #666; font-weight: 600; margin-bottom: 1rem;", "Image Credits"),
  tags$ul(
    style = "font-size: 0.85rem; color: #888; line-height: 2; list-style: none; padding: 0;",
    tags$li("Red-breasted Nuthatch — © John Doe / Cornell Lab of Ornithology"),
    tags$li("Western Meadowlark — © Jane Smith / Adobe Stock"),
    tags$li("Wrentit — © Manish Sharma"),
    tags$li("Shrub habitat — © Jessica Wienberg-McClosky / National Park Service"),
    tags$li("Conifer forest — © Bryant Baker / ForestWatch"),
    tags$li("Sierra Nevada — © Michael Mahoney / Point Blue Conservation Science"),
    tags$li("Grasslands — © SciTechDaily"),
    tags$li("Working lands — The Conservation Fund")
  )
)
) # END welcome tabItem


#### choices tabItem styles ####
choices_css <- tags$head(
  tags$style(HTML("
    .choices-outer {
      padding: 2.5rem 2rem;
      max-width: 1100px;
      margin: 0 auto;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    }
    .choices-header { margin-bottom: 1.5rem; }
    .choices-header h2 {
      font-size: 1.5rem; font-weight: 500;
      color: #1E3A5F;
      margin-bottom: 0.3rem;
    }
    .choices-header p {
      font-size: 0.85rem;
      color: #6B7F96;
      margin: 0 0 1rem 0;
    }
  "))
) # END choices tab styles

#### choices tabItem ####
choices_tab <- tabItem(
  tabName = "choices",
  div(
    class = "choices-outer",
    div(
      class = "choices-header",
      tags$h2("Analytical Choices",
              style = "font-size: 4"),
      tags$p("Filter by phase or category, then click nodes to expand.",
             style = "font-size: 2rem;"),
      fluidRow(
        column(4, selectInput("choices_phase",    "Filter by Phase",    choices = c("All", unique(choices_data$Phase)))),
        column(4, selectInput("choices_category", "Filter by Category", choices = "All"))
      )
    ),
    collapsibleTreeOutput("choices_tree", height = "650px")
  )
)# end choices tabitem


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
        options  = pickerOptions(liveSearch = TRUE, actionsBox = TRUE)
      ), # End species picker input
      
      pickerInput(
        inputId  = "site_ID",
        label    = "Select Study Site",
        choices  = unique(leaflet_points$study_area),
        multiple = TRUE,
        options  = pickerOptions(liveSearch = TRUE, actionsBox = TRUE)
      ), #end species picker input
      
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