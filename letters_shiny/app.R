library(tidyverse)
library(shiny)
library(jsonlite)
library(httr)


# Set API base URL
api_url <- "https://colorado.posit.co/rsc/content/ed60e0f0-63d1-4757-b71b-78e67691e6e3/data"


# Define UI ----------------------------
ui <- fluidPage(
  titlePanel("Plot Letter Numbers"),
  
  sidebarLayout(
    sidebarPanel(
      # Select letters
      selectInput(
        inputId = "letters",
        label = "Select Letters",
        choices = LETTERS,
        multiple = TRUE),
      
      # Action button
      actionButton("query_btn", "Query API"),
    ),
    
    mainPanel(plotOutput("lettersplot"))
  )
)

# Define server logic -----------------------------
server <- function(input, output) {
  
  # Ping api with button click
  observeEvent(input$query_btn, {
    
    # Query API
    response <- GET(url = api_url, 
                    query = set_names(as.list(input$letters), "Letters"))
    
    # Get API response
    response_content <- content(response, as = "text")
    
    # Convert response to tibble
    response_data <- as_tibble(fromJSON(response_content, 
                              simplifyDataFrame = TRUE))
    
    # Render ggplot
    output$lettersplot <- renderPlot({
      ggplot(response_data, aes(x = Letters, y = Numbers)) +
        geom_jitter(width = 0.01)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
