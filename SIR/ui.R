shinyUI(pageWithSidebar(
  
  # Header
  headerPanel('SIR Model with Vital Dynamics'),  
  
  # Sidebar
  sidebarPanel(
  
    h4('Initial Conditions'),
    
    numericInput(inputId='snum', label='Number Susceptible', 
                 value=1000, min=0),
    numericInput(inputId='inum', label='Number Infected', 
                 value=1, min=0),
    numericInput(inputId='rnum', label='Number Recovered', 
                 value=0, min=0),
    
    br(), br(),
    
    h4('Time'),
    numericInput(inputId='ts', label='Timesteps', 
                 value=500, min=0),
    numericInput(inputId='dt', label='DT (ODE Interval)', 
                 value=0.5, min=0.1, step=0.1),
    
    br(), br(),
    
    h4('Parameters'),
    sliderInput(inputId='beta', label='beta: Transmission per Contact',
                min=0, max=1, value=0.2, step=0.05),
    br(),
    sliderInput(inputId='cont', label='c: Contacts per Timestep',
                min=1, max=10, value=3, step=1),
    br(),
    sliderInput(inputId='d', label='D: Disease Duration',
                min=1, max=20, value=3, step=1),
   
    br(),
    
    checkboxInput(inputId='vital', label=strong('Include vital dynamics'),
                  value=FALSE),
    conditionalPanel(condition='input.vital == true',
                     sliderInput(inputId='birth', label='Birth Rate',
                                 min=0, max=0.1, value=0.0, step=0.01),
                     br(),
                     sliderInput(inputId='ms', label='Mortality Rate (Susceptibles)',
                                 min=0, max=0.1, value=0.0, step=0.01),
                     br(),
                     sliderInput(inputId='mi', label='Mortality Rate (Infected)',
                                 min=0, max=0.1, value=0.0, step=0.01),
                     br(),
                     sliderInput(inputId='mr', label='Mortality Rate (Recovered)',
                                 min=0, max=0.1, value=0.0, step=0.01)
    )
  ),
  
  # Main panel
  mainPanel(
    tabsetPanel(
      tabPanel('Plot', h4('Plot of SIR Model Results'),
               plotOutput(outputId='compplot'),
               selectInput(inputId='compsel', label='Plot Selection', 
                           choices=c('SIR size', 'SIR prev',
                                     'Incidence', 'Rn / S prev')),
               br(), br(),
               checkboxInput(inputId='legend', label='Plot Legend',
                             value=TRUE),
               br(),
               sliderInput(inputId='alpha', label='Line Transparency',
                           min=0.1, max=1, value=0.6, step=0.1),
               br(), br(),
               downloadButton('dlPlot', 'Download Plot')
      ), 
      tabPanel('Data', h4('Raw data from model'),
               numericInput(inputId='start', label='Start Timestep', value=0, min=0),
               numericInput(inputId='end', label='End Timestep', value=10, min=0),
               verbatimTextOutput('outhead'),
               numericInput('datadigits', label='Significant Digits', value=3, min=0, max=8),
               br(), br(),
               downloadButton('dlData', 'Download Data')
      ),
      tabPanel('Statistics', h4('Model Statistics'),
               numericInput(inputId='time', label='Timestep', value=0, min=0),
               tableOutput('stats')
      ),
      tabPanel('About', 
               p('This application solves and plots a deterministic, compartmental 
                  SIR (susceptible, infected, recovered) epidemic model. The underlying
                  modeling framework is the', 
                 a('EpiModel', href='http://students.washington.edu/sjenness/Software.html'), 
                  'package in R. The web application is built with the amazing', 
                 a("Shiny.", href="http://www.rstudio.com/shiny/")),
               br(),
               strong('Author'), p('Samuel M. Jenness, Department of Epidemiology, 
                                    University of Washington')
      )
    )
  )
))

