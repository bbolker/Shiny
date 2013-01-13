shinyUI(pageWithSidebar(
  
  # Header
  headerPanel('SIR Model with Vital Dynamics'),  
  
  # Sidebar
  sidebarPanel(
  
    h4('Initial Conditions'),
    
    numericInput("snum", "Number susceptible:", value=1000, min=0),
    numericInput("inum", "Number infected:", value=1, min=0),
    numericInput("rnum", "Number recovered:", value=0, min=0),
    
    br(), br(),
    
    h4('Time'),
    numericInput("ts", "Timesteps", value=500, min=0),
    numericInput("dt", "DT (ODE interval)", value=0.5, min=0.1, step=0.1),
    
    br(), br(),
    
    h4('Parameters'),
    sliderInput(inputId = "beta",
                label = "beta: transmission per contact",
                min = 0, max = 1, value = 0.2, step = 0.05),
    sliderInput(inputId = "cont",
                label = "c: number of contacts per timestep",
                min = 1, max = 10, value = 3, step = 1),
    sliderInput(inputId = "d",
                label = "d: disease duration",
                min = 1, max = 20, value = 3, step = 1),
   
    br(),
    
    checkboxInput(inputId = "vital",
                  label = strong("Include vital dynamics"),
                  value = FALSE),
    conditionalPanel(condition = "input.vital == true",
                     sliderInput(inputId = "birth",
                                 label = "Birth rate:",
                                 min=0, max=0.1, value=0.0, step=0.01),
                     sliderInput(inputId = "ms",
                                 label = "Mortality rate (susceptibles):",
                                 min=0, max=0.1, value=0.0, step=0.01),
                     sliderInput(inputId = "mi",
                                 label = "Mortality rate (infected):",
                                 min=0, max=0.1, value=0.0, step=0.01),
                     sliderInput(inputId = "mr",
                                 label = "Mortality rate (recovered):",
                                 min=0, max=0.1, value=0.0, step=0.01)
    )
  ),
  
  # Main panel
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", h4('Plot of SIR model results'),
               plotOutput(outputId = "compplot"),
               selectInput("compsel", "Plot selection:", 
                           choices = c("SIR size", "SIR prev",
                                       "Incidence", "Rn / S prev")),
               br(), br(),
               checkboxInput(inputId = "legend",
                             label = strong("Include plot legend"),
                             value = TRUE),
               br(),
               downloadButton('dlPlot', 'Download Plot')
      ), 
      tabPanel("Data", h4('Raw data from model'),
               numericInput("start", "Start time", value=0, min=0),
               numericInput("end", "End time", value=10, min=0),
               verbatimTextOutput("outhead"),
               numericInput("datadigits", 
                            label="Significant digits", value=3, min=0, max=8),
               br(), br(),
               downloadButton('dlData', 'Download Data')
      ),
      tabPanel('Statistics', h4('Model statistics on specified timestep'),
               numericInput("time", label="Timestep", value=0, min=0),
               tableOutput("stats")
      )
    )
  )
))

