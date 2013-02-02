library(EpiModel)
source('simplot.R')

shinyServer(function(input, output) {

  

  conc <- reactive(function() {
    switch(input$conc,
           "No concurrency" = 1,
           "Female only concurrency" = 2,
           "Male only concurrency" = 3,
           "Both sexes concurrency" = 4
    )
  })

  output$concplot <- reactivePlot(function() {
    sim.plot(md=input$md, dur=input$dur, conc=conc(), pos=1, medians=input$median,
             sims=input$sims, simlines=input$simlines, alpha=input$alpha, leg=input$leg)
  })
  output$dlPlot <- downloadHandler(
    filename = 'ConcSimPlot.pdf',
    content = function(file) {
      pdf(file=file, h=6, w=10)
        par(mar=c(3.5,3.5,2.5,1), mgp=c(2.2,1,0))
        sim.plot(md=input$md, dur=input$dur, conc=conc(), pos=1, medians=input$median,
               sims=input$sims, simlines=input$simlines, alpha=input$alpha, leg=input$leg)
      dev.off()
    }
  )

  
  # Stats tab
  output$statsm <- reactiveTable(function() {
    sim.table(md=input$md, dur=input$dur, conc=conc(), male=1, digits=3)
  })
  output$statsf <- reactiveTable(function() {
    sim.table(md=input$md, dur=input$dur, conc=conc(), male=2, digits=3)
  })
  
})