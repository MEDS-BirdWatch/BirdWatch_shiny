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


#### scrollyteller styles ####
scrolly_css <- tags$head(
  tags$style(HTML("

    /* ---- scrolly section layout ---- */
    .scrolly-wrap * { box-sizing: border-box; margin: 0; padding: 0; }

    .s-section {
      min-height: 100vh;
      display: flex;
      align-items: center;
      padding: 5rem 2rem;
      position: relative;
    }
    .s-section:nth-child(even) { background: #F5F5F2; }    /* Sand light — alternating section bg */

    .s-container { max-width: 1060px; margin: 0 auto; width: 100%; }

    /* ---- entrance animations ---- */
    .anim        { opacity: 0; transition: opacity 0.75s ease, transform 0.75s ease; }
    .from-left   { transform: translateX(-80px); }
    .from-right  { transform: translateX(80px); }
    .from-bottom { transform: translateY(60px); }
    .zoom-in     { transform: scale(0.75); }
    .visible     { opacity: 1 !important; transform: none !important; }

    /* ---- grid splits ---- */
    .split   { display: grid; gap: 3rem; align-items: center; }
    .s-50-50 { grid-template-columns: 1fr 1fr; }
    .s-40-60 { grid-template-columns: 40fr 60fr; }
    .s-60-40 { grid-template-columns: 60fr 40fr; }
    .s-30-70 { grid-template-columns: 30fr 70fr; }

    @media (max-width: 768px) {
      .split { grid-template-columns: 1fr !important; }
    }

    /* ---- typography ---- */
    .scrolly-wrap h1 {
      font-size: 2.8rem; font-weight: 500;
      line-height: 1.2; margin-bottom: 1rem;
      color: #1E3A5F;                             /* Navy dark — hero heading */
    }
    .scrolly-wrap h2 {
      font-size: 1.8rem; font-weight: 500;
      margin-bottom: 0.75rem;
      color: #1E3A5F;                             /* Navy dark — section headings */
    }
    .scrolly-wrap p {
      font-size: 1rem; line-height: 1.7;
      color: #4A5568;                             /* Dark slate — body text */
      margin-bottom: 0.75rem;
    }
    .s-label {
      font-size: 0.7rem; font-weight: 600;
      letter-spacing: 0.12em; text-transform: uppercase;
      color: #6B7F96;                             /* Slate — overline labels */
      margin-bottom: 0.5rem;
    }
    .s-divider {
      width: 40px; height: 3px;
      background: #1A8A6A;                        /* Teal mid — hero divider bar */
      border-radius: 2px; margin: 1rem 0;
    }
    .s-badge {
      display: inline-block; font-size: 0.7rem; font-weight: 600;
      padding: 3px 10px; border-radius: 6px; margin-bottom: 0.5rem;
      background: #E6F1FB;                        /* Blue wash — badge background */
      color: #185FA5;                             /* Blue — badge text */
    }

    /* ---- map placeholder ---- */
    .map-ph {
      background: linear-gradient(135deg,
        #1A8A6A 0%,                               /* Teal mid — gradient start */
        #0D6E56 50%,                              /* Teal dark — gradient mid */
        #085041 100%);                            /* Teal darkest — gradient end */
      border-radius: 12px;
      display: flex; align-items: center; justify-content: center;
      color: white; position: relative; overflow: hidden;
    }
    .map-ph::before {
      content: ''; position: absolute; inset: 0;
      background: repeating-linear-gradient(
        45deg, transparent, transparent 20px,
        rgba(255,255,255,0.03) 20px, rgba(255,255,255,0.03) 40px
      );
    }
    .map-dot {
      width: 12px; height: 12px; border-radius: 50%;
      background: #E8C96B;                        /* Warm amber — map pulse dots */
      border: 2px solid white;
      position: absolute; animation: mpulse 2s infinite;
    }
    @keyframes mpulse {
      0%,100% { box-shadow: 0 0 0 0 rgba(232,201,107,0.6); }  /* Amber pulse glow */
      50%      { box-shadow: 0 0 0 8px rgba(232,201,107,0); }
    }

    /* ---- stat cards ---- */
    .stat-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-top: 1.5rem; }
    .stat-card {
      background: #EEF1F5;                        /* Blue-grey wash — stat card background */
      border-radius: 8px; padding: 1rem;
    }
    .stat-num  { font-size: 1.8rem; font-weight: 500; line-height: 1; margin-bottom: 4px; }
    .stat-lbl  { font-size: 0.8rem; color: #6B7F96; }  /* Slate — stat label */

    /* ---- species list ---- */
    .sp-list    { list-style: none; margin-top: 1rem; }
    .sp-list li {
      display: flex; align-items: center; gap: 10px;
      padding: 0.6rem 0;
      border-bottom: 0.5px solid rgba(0,0,0,0.07);  /* Border faint */
      font-size: 0.95rem; color: #2D3748;             /* Dark slate — species name */
    }
    .sp-list li:last-child { border-bottom: none; }
    .s-dot { width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0; }

    /* ---- filter demo card ---- */
    .s-card {
      background: #FFFFFF;                        /* White — filter card background */
      border: 0.5px solid rgba(0,0,0,0.10);       /* Border light */
      border-radius: 12px; padding: 1.5rem;
      display: flex; flex-direction: column; gap: 14px;
    }
    .f-lbl { font-size: 0.75rem; color: #6B7F96; margin-bottom: 4px; }  /* Slate — filter label */
    .f-sel {
      background: #FFFFFF;                        /* White — select mock background */
      border: 0.5px solid rgba(0,0,0,0.18);
      border-radius: 8px; padding: 0.5rem 0.75rem;
      font-size: 0.85rem; color: #1E3A5F;         /* Navy dark — select mock text */
      display: flex; justify-content: space-between; align-items: center;
    }
    .f-slider { height: 4px; background: #D8DFE8; border-radius: 2px; position: relative; margin: 8px 4px 4px; }
    .f-fill   {
      height: 100%;
      background: #2C4A6E;                        /* Navy mid — slider fill track */
      border-radius: 2px; width: 60%;
    }
    .f-thumb  {
      width: 16px; height: 16px; border-radius: 50%;
      background: white;
      border: 2px solid #2C4A6E;                 /* Navy mid — slider thumb border */
      position: absolute; top: -6px; left: 60%; transform: translateX(-50%);
    }

    /* ---- citation cards ---- */
    .cite-card {
      background: #FFFFFF;                        /* White — citation card background */
      border-left: 3px solid #1A8A6A;            /* Teal mid — citation left accent */
      border-top: 0.5px solid rgba(0,0,0,0.08);
      border-right: 0.5px solid rgba(0,0,0,0.08);
      border-bottom: 0.5px solid rgba(0,0,0,0.08);
      border-radius: 0 8px 8px 0;
      padding: 1rem 1.25rem; margin-bottom: 12px;
    }
    .cite-card.warn {
      border-left-color: #C85A2A;                /* Coral — disclaimer left accent */
    }

    /* ---- nav dots ---- */
    #scrolly-nav {
      position: fixed; right: 1.5rem; top: 50%;
      transform: translateY(-50%);
      display: flex; flex-direction: column; gap: 10px;
      z-index: 9999;
    }
    .snav-dot {
      width: 9px; height: 9px; border-radius: 50%;
      background: rgba(0,0,0,0.18);              /* Faint dark — inactive nav dot */
      cursor: pointer;
      transition: background 0.3s, transform 0.3s;
    }
    .snav-dot.active {
      background: #1A8A6A;                        /* Teal mid — active nav dot */
      transform: scale(1.4);
    }

    /* ---- remove default tab padding ---- */
    .tab-content > .tab-pane { padding: 0 !important; }
    .content-wrapper { padding: 0 !important; }

    /* ============================================================
       CHOICES TAB STYLES
       ============================================================ */

    .choices-outer {
      padding: 2.5rem 2rem;
      max-width: 920px;
      margin: 0 auto;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    }
    .choices-header { margin-bottom: 2.5rem; }
    .choices-header h2 {
      font-size: 1.5rem; font-weight: 500;
      color: #1E3A5F;                             /* Navy dark — choices page heading */
      margin-bottom: 0.3rem;
    }
    .choices-header p {
      font-size: 0.85rem;
      color: #6B7F96;                             /* Slate — choices page subtitle */
      margin: 0;
    }

    /* ---- vertical connector line down left side of open branch ---- */
    .vtree { display: flex; flex-direction: column; gap: 0; }
    .vtree-branch { display: flex; flex-direction: column; position: relative; }
    .vtree-branch::before {
      content: ''; position: absolute;
      left: 20px; top: 52px; bottom: 0; width: 1px;
      background: #D0DCE8;                        /* Blue-grey — vertical connector line */
      z-index: 0;
    }
    .vtree-branch:last-child::before { display: none; }

    /* ---- branch root node ---- */
    .vtree-root-node {
      display: flex; align-items: center; gap: 12px;
      padding: 0.75rem 1rem;
      background: #FFFFFF;                        /* White — branch header background */
      border: 1px solid #D0DCE8;                 /* Blue-grey — branch header border */
      border-radius: 10px;
      cursor: pointer; user-select: none;
      transition: border-color 0.2s, background 0.2s;
      position: relative; z-index: 1;
      margin-bottom: 4px;
    }
    .vtree-root-node:hover {
      border-color: #1A8A6A;                      /* Teal mid — branch hover border */
      background: #EBF5F0;                        /* Teal wash — branch hover background */
    }
    .vtree-root-node.open {
      border-color: #0D6E56;                      /* Teal dark — open branch border */
      background: #EBF5F0;                        /* Teal wash — open branch background */
      border-bottom-left-radius: 4px;
      border-bottom-right-radius: 4px;
    }
    .vtree-icon {
      width: 34px; height: 34px; border-radius: 8px;
      background: #DCF0E8;                        /* Teal pale — icon badge background */
      display: flex; align-items: center; justify-content: center;
      font-size: 1rem; flex-shrink: 0;
      color: #0D6E56;                             /* Teal dark — icon colour */
    }
    .vtree-root-label {
      flex: 1; font-size: 0.9rem; font-weight: 500;
      color: #1E3A5F;                             /* Navy dark — branch label text */
    }
    .vtree-root-count {
      font-size: 0.7rem; font-weight: 600;
      color: #0D6E56;                             /* Teal dark — count badge text */
      background: #C6E8DA;                        /* Teal pale — count badge background */
      padding: 2px 7px; border-radius: 10px;
    }
    .vtree-chevron {
      font-size: 0.6rem;
      color: #9AAEC0;                             /* Slate light — chevron icon */
      transition: transform 0.25s;
    }
    .vtree-root-node.open .vtree-chevron { transform: rotate(90deg); }

    /* ---- leaves container ---- */
    .vtree-leaves {
      display: none; flex-direction: column;
      padding-left: 40px; margin-bottom: 12px;
      position: relative;
    }
    .vtree-leaves.open { display: flex; }

    /* ---- individual leaf ---- */
    .vtree-leaf {
      display: flex; flex-direction: column;
      position: relative; margin-bottom: 4px;
    }
    /* horizontal connector tick from vertical line */
    .vtree-leaf::before {
      content: ''; position: absolute;
      left: -20px; top: 22px;
      width: 20px; height: 1px;
      background: #D0DCE8;                        /* Blue-grey — horizontal leaf connector */
    }
    /* junction dot */
    .vtree-leaf::after {
      content: ''; position: absolute;
      left: -23px; top: 19px;
      width: 7px; height: 7px; border-radius: 50%;
      background: #C6E8DA;                        /* Teal pale — inactive junction dot fill */
      border: 1.5px solid #1A8A6A;               /* Teal mid — inactive junction dot border */
    }
    .vtree-leaf.active::after {
      background: #0D6E56;                        /* Teal dark — active junction dot fill */
      border-color: #0D6E56;                      /* Teal dark — active junction dot border */
    }
    .vtree-leaf-header {
      display: flex; align-items: center; gap: 8px;
      padding: 0.55rem 0.85rem;
      background: #FFFFFF;                        /* White — leaf header background */
      border: 0.5px solid #D8E4EE;               /* Blue-grey light — leaf header border */
      border-radius: 8px; cursor: pointer;
      font-size: 0.875rem; font-weight: 500;
      color: #2A3A4A;                             /* Dark navy — leaf header text */
      transition: background 0.15s, border-color 0.15s;
    }
    .vtree-leaf-header:hover {
      background: #EBF5F0;                        /* Teal wash — leaf hover background */
      border-color: #8ABFAE;                      /* Teal light — leaf hover border */
    }
    .vtree-leaf.active .vtree-leaf-header {
      background: #EBF5F0;                        /* Teal wash — active leaf background */
      border-color: #0D6E56;                      /* Teal dark — active leaf border */
      color: #0D3D2A;                             /* Very dark teal — active leaf text */
    }
    .vtree-leaf-chevron {
      font-size: 0.6rem;
      color: #B0C4D8;                             /* Slate light — leaf chevron */
      transition: transform 0.2s; margin-left: auto;
    }
    .vtree-leaf.active .vtree-leaf-chevron {
      transform: rotate(90deg);
      color: #0D6E56;                             /* Teal dark — active leaf chevron */
    }
    .vtree-leaf-body {
      display: none;
      font-size: 0.82rem; line-height: 1.7;
      color: #4A5568;                             /* Dark slate — leaf body text */
      padding: 0.65rem 0.85rem;
      margin-top: 2px;
      background: #F7FBFA;                        /* Teal faintest — leaf body background */
      border: 0.5px solid #C6DDD5;               /* Teal pale — leaf body border */
      border-radius: 0 0 8px 8px;
      border-top: none;
    }
    .vtree-leaf.active .vtree-leaf-body { display: block; }

  "))
) # END scrollyteller styles


#### scrollyteller JS ####
scrolly_js <- tags$script(HTML("
  $(document).ready(function() {

    var sections = document.querySelectorAll('.s-section');
    var navDots  = document.querySelectorAll('.snav-dot');

    // entrance animations on scroll
    var animObs = new IntersectionObserver(function(entries) {
      entries.forEach(function(e) {
        if (e.isIntersecting) {
          e.target.querySelectorAll('.anim').forEach(function(el, i) {
            setTimeout(function() { el.classList.add('visible'); }, i * 150);
          });
        }
      });
    }, { threshold: 0.15 });

    sections.forEach(function(s) { animObs.observe(s); });

    // update active nav dot on scroll
    var dotObs = new IntersectionObserver(function(entries) {
      entries.forEach(function(e) {
        if (e.isIntersecting) {
          var idx = Array.from(sections).indexOf(e.target);
          navDots.forEach(function(d, i) {
            d.classList.toggle('active', i === idx);
          });
        }
      });
    }, { threshold: 0.5 });

    sections.forEach(function(s) { dotObs.observe(s); });

  });

  // scroll to section helper (used by nav dots)
  function scrollToSection(idx) {
    var sections = document.querySelectorAll('.s-section');
    if (sections[idx]) sections[idx].scrollIntoView({ behavior: 'smooth' });
  }
")) # END scrollyteller JS


#### welcome tabItem ####
welcome_tab <- tabItem(
  tabName = "welcome",
  
  # nav dots
  div(id = "scrolly-nav",
      div(class = "snav-dot active", onclick = "scrollToSection(0)"),
      div(class = "snav-dot",        onclick = "scrollToSection(1)"),
      div(class = "snav-dot",        onclick = "scrollToSection(2)"),
      div(class = "snav-dot",        onclick = "scrollToSection(3)"),
      div(class = "snav-dot",        onclick = "scrollToSection(4)")
  ), # END nav dots
  
  div(class = "scrolly-wrap",
      
      #### section 1 — hero ####
      # left: text slides in | right: map placeholder slides in
      div(id = "ss1", class = "s-section",
          div(class = "s-container",
              div(class = "split s-50-50",
                  
                  # left — headline + intro text
                  div(class = "anim from-left",
                      div(class = "s-label", "Fish Creek Watershed"),
                      tags$h1("Monitoring Alaska's Arctic Lakes"),
                      div(class = "s-divider"),
                      tags$p(style = "font-size:1.1rem; max-width:480px;",
                             "A long-term ecological study tracking water quality, species diversity,
               and habitat health across one of the most remote watersheds in the
               National Petroleum Reserve.")
                  ), # END left — headline + intro text
                  
                  # right — map placeholder with animated dots
                  div(class = "anim from-right", style = "height:360px; position:relative;",
                      div(class = "map-ph", style = "height:100%;",
                          tags$span(style = "position:relative; z-index:1; font-size:0.85rem; opacity:0.8;",
                                    "Northern Alaska — NPR-A"),
                          div(class = "map-dot", style = "top:42%; left:38%;"),
                          div(class = "map-dot", style = "top:55%; left:52%; animation-delay:0.5s;"),
                          div(class = "map-dot", style = "top:35%; left:60%; animation-delay:1s;")
                      )
                  ) # END right — map placeholder
                  
              )
          )
      ), # END section 1 — hero
      
      
      #### section 2 — stats ####
      # left: stat block zooms in | right: background text slides from right
      div(id = "ss2", class = "s-section",
          div(class = "s-container",
              div(class = "split s-30-70",
                  
                  # left — stat block (zooms in)
                  div(class = "anim zoom-in",
                      style = "text-align:right; padding-right:2rem; border-right:0.5px solid rgba(0,0,0,0.1);",
                      div(class = "s-label", "By the numbers"),
                      tags$h2(style = "font-size:2.2rem; line-height:1.1;",
                              "3 lakes", tags$br(), "monitored", tags$br(), "year-round"),
                      div(class = "stat-grid", style = "text-align:left;",
                          div(class = "stat-card",
                              # Teal mid — species count accent
                              div(class = "stat-num", style = "color:#1A8A6A;", "12+"),
                              div(class = "stat-lbl", "Species tracked")),
                          div(class = "stat-card",
                              # Coral — GAP count accent
                              div(class = "stat-num", style = "color:#C85A2A;", "5"),
                              div(class = "stat-lbl", "GAP statuses")),
                          div(class = "stat-card",
                              # Purple — habitat count accent
                              div(class = "stat-num", style = "color:#4A3FA0;", "4"),
                              div(class = "stat-lbl", "Habitat types")),
                          div(class = "stat-card",
                              # Navy mid — data start accent
                              div(class = "stat-num", style = "color:#2C4A6E;", "2020"),
                              div(class = "stat-lbl", "Data start"))
                      )
                  ), # END left — stat block
                  
                  # right — background text (slides from right)
                  div(class = "anim from-right", style = "padding-left:1rem;",
                      div(class = "s-badge", "Background"),
                      tags$h2("Why monitor Fish Creek?"),
                      tags$p("Fish Creek Watershed sits within the National Petroleum Reserve in
                    northern Alaska — a region of extraordinary ecological sensitivity
                    and significant resource development pressure."),
                      tags$p("Ongoing monitoring tracks how lake ecosystems respond to climate
                    variability and industrial activity, providing baseline data for
                    conservation decisions."),
                      tags$p("Data collected here feeds directly into federal management plans for
                    one of the largest protected wetland complexes in North America.")
                  ) # END right — background text
                  
              )
          )
      ), # END section 2 — stats
      
      
      #### section 3 — species ####
      # left: species list slides from left | right: feature card slides from right
      div(id = "ss3", class = "s-section",
          div(class = "s-container",
              div(class = "split s-60-40",
                  
                  # left — species list
                  div(class = "anim from-left",
                      div(class = "s-badge", "Species diversity"),
                      tags$h2("What lives in these waters?"),
                      tags$p("From migratory waterfowl to Arctic fish, the watershed supports a
                    remarkable community of species adapted to extreme seasonal change."),
                      tags$ul(class = "sp-list",
                              # species dot colours — each a distinct professional accent
                              tags$li(div(class = "s-dot", style = "background:#1A8A6A;"), "Arctic grayling"),  # Teal mid
                              tags$li(div(class = "s-dot", style = "background:#2C4A6E;"), "Lake trout"),        # Navy mid
                              tags$li(div(class = "s-dot", style = "background:#C85A2A;"), "Broad whitefish"),   # Coral
                              tags$li(div(class = "s-dot", style = "background:#4A3FA0;"), "Least cisco"),       # Purple
                              tags$li(div(class = "s-dot", style = "background:#B87217;"), "Burbot"),            # Amber
                              tags$li(div(class = "s-dot", style = "background:#185FA5;"), "Northern pike")      # Blue
                      )
                  ), # END left — species list
                  
                  # right — feature card
                  div(class = "anim from-right",
                      # Sand light — feature card background
                      div(style = "background:#F5F5F2; border-radius:12px; text-align:center; padding:2.5rem 1.5rem;",
                          div(style = "font-size:4rem; line-height:1; margin-bottom:0.75rem;", "\U0001F41F"),
                          div(style = "font-size:1.1rem; font-weight:500; margin-bottom:0.5rem; color:#1E3A5F;",  # Navy dark
                              "Arctic Grayling"),
                          tags$p(style = "font-size:0.85rem; margin:0;",
                                 "Most commonly observed across all study sites. A sentinel species for
                 water quality change.")
                      )
                  ) # END right — feature card
                  
              )
          )
      ), # END section 3 — species
      
      
      #### section 4 — dashboard preview ####
      # header fades up | left: filter panel from left | right: map placeholder from right
      div(id = "ss4", class = "s-section",
          div(class = "s-container",
              
              # centered header (fades up from bottom)
              div(class = "anim from-bottom", style = "text-align:center; margin-bottom:3rem;",
                  div(class = "s-label", "Interactive dashboard"),
                  tags$h2("Filter by site, species, and habitat"),
                  tags$p(style = "max-width:520px; margin:0 auto;",
                         "Slice the dataset by any combination of parameters — results render
             live on an interactive Leaflet map.")
              ), # END centered header
              
              div(class = "split s-40-60",
                  
                  # left — filter panel demo
                  div(class = "anim from-left",
                      div(class = "s-label", "Controls panel"),
                      div(class = "s-card",
                          div(div(class = "f-lbl", "Select species"),
                              div(class = "f-sel", "Arctic grayling, Lake trout", tags$span("▾"))),
                          div(div(class = "f-lbl", "Select study site"),
                              div(class = "f-sel", "Teshekpuk Lake", tags$span("▾"))),
                          div(div(class = "f-lbl", "Number of observations (per study area)"),
                              div(class = "f-slider", div(class = "f-fill"), div(class = "f-thumb")),
                              div(style = "display:flex; justify-content:space-between; font-size:0.7rem; color:#9AAEC0;",  # Slate light — slider range labels
                                  tags$span("0"), tags$span("250"))),
                          div(div(class = "f-lbl", "Habitat type"),
                              div(class = "f-sel", "Lacustrine, Palustrine", tags$span("▾"))),
                          div(div(class = "f-lbl", "GAP status"),
                              div(class = "f-sel", "1 — 2", tags$span("▾"))),
                          div(style = "display:flex; gap:8px; margin-top:0.5rem;",
                              # Navy mid — primary button background
                              tags$button(
                                style = "flex:1; padding:0.55rem; font-size:0.85rem; border-radius:8px;
                           background:#2C4A6E; color:white; border:none; cursor:pointer; font-weight:500;",
                                "Update map"),
                              tags$button(
                                style = "padding:0.55rem 1rem; font-size:0.85rem; border-radius:8px;
                           background:transparent; border:0.5px solid rgba(0,0,0,0.18);
                           color:#4A5568; cursor:pointer;",  # Dark slate — reset button text
                                "Reset")
                          )
                      )
                  ), # END left — filter panel demo
                  
                  # right — map placeholder
                  div(class = "anim from-right", style = "height:400px; position:relative;",
                      div(class = "map-ph", style = "height:100%;",
                          div(style = "position:relative; z-index:1; text-align:center;",
                              div(style = "font-size:0.9rem; opacity:0.85; margin-bottom:4px;", "Leaflet map renders here"),
                              div(style = "font-size:0.75rem; opacity:0.5;", "Sites filtered by your selections")),
                          div(class = "map-dot", style = "top:30%; left:45%;"),
                          div(class = "map-dot", style = "top:60%; left:35%; animation-delay:0.7s;"),
                          div(class = "map-dot", style = "top:50%; left:65%; animation-delay:1.3s;"),
                          div(class = "map-dot", style = "top:25%; left:70%; animation-delay:0.3s;")
                      )
                  ) # END right — map placeholder
                  
              )
          )
      ), # END section 4 — dashboard preview
      
      
      #### section 5 — citation ####
      # left: citation cards zoom in | right: CTA slides from right
      div(id = "ss5", class = "s-section",
          div(class = "s-container",
              div(class = "split s-50-50",
                  
                  # left — citation + disclaimer (zoom in)
                  div(class = "anim zoom-in", style = "display:flex; flex-direction:column; gap:14px;",
                      div(class = "cite-card",                       # Teal mid left border
                          div(class = "s-label", "Data citation"),
                          includeMarkdown("text/citation.md")
                      ), # END citation card
                      div(class = "cite-card warn",                  # Coral left border
                          div(class = "s-label", "Disclaimer"),
                          includeMarkdown("text/disclaimer.md")
                      ) # END disclaimer card
                  ), # END left — citation + disclaimer
                  
                  # right — CTA (slides from right)
                  div(class = "anim from-right",
                      div(class = "s-label", "Get started"),
                      tags$h2("Explore the dashboard"),
                      tags$p("Use the filter controls to narrow results by species, study site,
                    observation count, habitat type, or GAP status — then see matching
                    sites rendered live on the map."),
                      tags$p("All data sourced from field sampling conducted by the
                    Fish Creek Watershed Observatory (FCWO)."),
                      # Blue — CTA link colour
                      tags$a(href = "http://www.fishcreekwatershed.org/", target = "_blank",
                             style = "display:inline-block; margin-top:0.5rem; font-size:0.9rem; color:#185FA5;",
                             "Visit FCWO \u2197")
                  ) # END right — CTA
                  
              )
          )
      ) # END section 5 — citation
      
  ) # END scrolly-wrap
  
) # END welcome tabItem


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
                  
                  # leaf 1a — Teshekpuk Lake
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
                  
                  # leaf 1b — Judy Lake
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
                  
                  # leaf 1c — Smith Lake
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
  
  # tree interaction JS
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
  
  # input box
  box(width = 4,
      title = tags$strong("Adjust Avian View:"),
      
      # species pickerInput
      pickerInput(
        inputId  = "species_ID",
        label    = "Select Species",
        choices  = unique(species_list$common_name),
        multiple = TRUE,
        options  = pickerOptions(liveSearch = TRUE)
      ), # END species pickerInput
      
      # study area pickerInput
      pickerInput(
        inputId  = "site_ID",
        label    = "Select Study Site",
        choices  = unique(leaflet_points$study_area),
        multiple = TRUE,
        options  = pickerOptions(liveSearch = TRUE)
      ), # END study area pickerInput
      
      # observation sliderInput
      sliderInput(
        inputId = "observation_ID",
        label   = "Number of Observations (per Study area)",
        min     = min(leaflet_points$area_observations, na.rm = TRUE),
        max     = max(leaflet_points$area_observations, na.rm = TRUE),
        value   = c(min(leaflet_points$area_observations, na.rm = TRUE),
                    max(leaflet_points$area_observations, na.rm = TRUE))
      ), # END observation sliderInput
      
      # Study type check box input
      checkboxGroupInput(
        inputId = "survey_ID",
        label = 'Survey Method',
        choices = unique(leaflet_points$survey_type)
      ), # END Survey type check box input
      
      # habitat type pickerInput
      pickerInput(
        inputId  = "habitat_ID",
        label    = "Habitat Types",
        choices  = habitat_choices,
        multiple = TRUE
      ), # END habitat type pickerInput
      
      # gap status pickerInput
      pickerInput(
        inputId  = "gap_ID",
        label    = "GAP Status",
        multiple = TRUE,
        choices  = sort(unique(leaflet_points$gap_sts))
      ), # END gap status pickerInput
      
      # Navy mid (#2C4A6E) — slider skin accent colour
      shinyWidgets::chooseSliderSkin(skin = "Flat", color = "#2C4A6E"), # END slider skin
      
      actionButton("submit", "Update Plot"),
      actionButton("reset",  "Reset Map")
      
  ), # END input box
  
  # leaflet box
  box(
    width = 8,
    height = 700,
    leafletOutput(outputId = "leaflet_output", height = "663px") %>%
      withSpinner(type = 8, color = "#1A8A6A")
  ) # END leaflet box
  
) # END dashboard tabItem


#### dashboardBody ####
body <- dashboardBody(
  scrolly_css,
  tabItems(
    welcome_tab,
    dashboard_tab,
    choices_tab
  ),
  scrolly_js
) # END dashboardBody


#### dashboardPage ####
dashboardPage(header, sidebar, body)