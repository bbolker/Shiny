shinyUI(pageWithSidebar(
  
  # Header
  headerPanel('Agent-based Stochastic Model of Concurrency on HIV'),  
  
  # Sidebar
  sidebarPanel(
  
    h4('Epidemic Parameters'),
    
    sliderInput(inputId='md', label='Momentary mean degree',
                min=0.5, max=1, value=0.8, step=0.05),
    br(),
    sliderInput(inputId='dur', label='Mean partnership duration',
                min=10, max=20, value=10, step=5),
    br(),
    selectInput(inputId='conc', label='Concurrency rules', 
                choices=c('No concurrency', 'Female only concurrency',
                          'Male only concurrency', 'Both sexes concurrency')),
    
    br(), br(),
    
    h4('Graphical Parameters'),
    sliderInput(inputId='sims', label='Number of simulations', 
                 value=25, min=1, max=50, step=1),
    br(),
    checkboxInput(inputId='simlines', label='Show individual simulations',
                  value=TRUE),
    sliderInput(inputId='alpha', label='Simulation line transparency',
               value=0.5, min=0.1, max=1, step=0.05),
    br(),
    checkboxInput(inputId='median', label='Show median of simulations',
                  value=TRUE),
    checkboxInput(inputId='leg', label='Show plot legend',
                  value=TRUE)
  ),
  
  # Main panel
  mainPanel(
    tabsetPanel(
      tabPanel('Plot', h4('Plot of Simulation Results'),
        plotOutput(outputId='concplot', height='500px'),
        br(), br(),
        downloadButton('dlPlot', 'Download Plot')
      ),
      tabPanel('Tables', h4('Model Statistics'),
               br(),
               h5('Male Prevalence by Month'),
               tableOutput('statsm'),
               br(),br(),
               h5('Female Prevalence by Month'),
               tableOutput('statsf')
      ),
      tabPanel('About', 
               p('This application solves and plots a stochastic epidemic model of HIV infection to
                  illustrate the impact of sexual partnership concurrency. The underlying
                  modeling framework was constructed by ', 
                 a('Steven Goodreau.', href='http://faculty.washington.edu/goodreau/'), 
                 ' This web application is built by ', 
                 a('Samuel Jenness', href='http://students.washington.edu/sjenness'),
                 'with the amazing ', a("Shiny.", href="http://www.rstudio.com/shiny/")),
               br(),
               strong('Code'), p('Original source code for this application at', 
                                 a('GitHub', href='https://github.com/smjenness/Shiny/tree/master/conc'))
      )
      
    )
  )
))