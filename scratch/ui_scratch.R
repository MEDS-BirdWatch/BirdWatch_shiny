library(shiny)
library(bslib)
library(bsicons)

ui <- page_navbar(
  title = "Interactive Dashboard",
  theme = bs_theme(version = 5, bootswatch = "flatly"),
  
  # Welcome Tab with Scrollyteller
  nav_panel(
    "Welcome",
    tags$head(
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
          color: white;
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
          max-width: 500px;
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
        .nav-buttons {
          margin-top: 20px;
          display: flex;
          gap: 10px;
        }
        .align-left {
          justify-content: flex-start;
          padding-left: 50px;
        }
        .align-right {
          justify-content: flex-end;
          padding-right: 50px;
        }
        .align-center {
          justify-content: center;
        }
      "))
    ),
    
    div(
      class = "scrolly-container",
      
      # Section 1: Static Image
      div(
        class = "scrolly-section static-section",
        div(
          class = "text-box",
          h1("Welcome to Our Dashboard"),
          p("Scroll down to explore our interactive story"),
          tags$i(class = "bi bi-arrow-down", style = "font-size: 2rem;")
        )
      ),
      
      # Section 2: Background with Left-aligned text
      div(
        class = "scrolly-section background-section align-left",
        style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1200');",
        div(
          class = "text-box",
          h2("Discover Insights"),
          p("Our platform provides powerful analytics and visualizations to help you understand your data better."),
          div(
            class = "nav-buttons",
            actionButton("nav_to_tab2_left", "Go to Analytics", class = "btn-primary")
          )
        )
      ),
      
      # Section 3: Background with Right-aligned text
      div(
        class = "scrolly-section background-section align-right",
        style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=1200');",
        div(
          class = "text-box",
          h2("Analyze Trends"),
          p("Track key metrics and identify patterns that drive your business forward with our intuitive tools."),
          div(
            class = "nav-buttons",
            actionButton("nav_to_tab3_right", "View Reports", class = "btn-success")
          )
        )
      ),
      
      # Section 4: Background with Center-aligned text
      div(
        class = "scrolly-section background-section align-center",
        style = "background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=1200');",
        div(
          class = "text-box",
          h2("Take Action"),
          p("Ready to get started? Explore our full dashboard and unlock the potential of your data."),
          div(
            class = "nav-buttons",
            actionButton("nav_to_tab2_center", "Analytics Dashboard", class = "btn-primary"),
            actionButton("nav_to_tab3_center", "Reports Dashboard", class = "btn-success")
          )
        )
      )
    )
  ),
  
  # Analytics Tab
  nav_panel(
    "Analytics",
    id = "analytics_tab",
    layout_columns(
      card(
        card_header("Analytics Overview"),
        card_body(
          p("This is the Analytics tab. Add your analytics content here."),
          plotOutput("analytics_plot")
        )
      ),
      card(
        card_header("Key Metrics"),
        card_body(
          layout_columns(
            value_box(
              title = "Total Users",
              value = textOutput("metric1_value"),
              showcase = bsicons::bs_icon("people"),
              theme = "primary"
            ),
            value_box(
              title = "Revenue",
              value = textOutput("metric2_value"),
              showcase = bsicons::bs_icon("currency-dollar"),
              theme = "success"
            )
          )
        )
      )
    )
  ),
  
  # Reports Tab
  nav_panel(
    "Reports",
    id = "reports_tab",
    card(
      card_header("Reports Dashboard"),
      card_body(
        p("This is the Reports tab. Add your reports content here."),
        tableOutput("reports_table")
      )
    )
  ),
  
  id = "main_navbar"
)

server <- function(input, output, session) {
  
  # Navigation observers for buttons in scrollyteller
  observeEvent(input$nav_to_tab2_left, {
    updateNavbarPage(session, "main_navbar", selected = "Analytics")
  })
  
  observeEvent(input$nav_to_tab2_center, {
    updateNavbarPage(session, "main_navbar", selected = "Analytics")
  })
  
  observeEvent(input$nav_to_tab3_right, {
    updateNavbarPage(session, "main_navbar", selected = "Reports")
  })
  
  observeEvent(input$nav_to_tab3_center, {
    updateNavbarPage(session, "main_navbar", selected = "Reports")
  })
  
  # Sample analytics plot
  output$analytics_plot <- renderPlot({
    plot(1:10, rnorm(10), type = "b", col = "steelblue", 
         main = "Sample Analytics", xlab = "Time", ylab = "Value")
  })
  
  # Sample metrics values
  output$metric1_value <- renderText({
    "1,234"
  })
  
  output$metric2_value <- renderText({
    "$56,789"
  })
  
  # Sample reports table
  output$reports_table <- renderTable({
    data.frame(
      Metric = c("Sales", "Customers", "Orders"),
      Q1 = c(1200, 450, 890),
      Q2 = c(1450, 520, 1020),
      Q3 = c(1680, 580, 1150)
    )
  })
}

shinyApp(ui, server)