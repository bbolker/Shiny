library(EpiModel)

shinyServer(function(input, output) {
  
  out <- reactive(function() {
    mod.SIR(s.num = input$snum, 
            i.num = input$inum, 
            r.num = input$rnum,
            beta = input$beta, 
            cont = input$cont, 
            nu = 1/input$d,
            b = input$birth,
            ms = input$ms,
            mi = input$mi,
            mr = input$mr,
            dt = seq(0, input$ts, input$dt))
  })
  
  # Plot tab
  comp <- reactive(function() {
    switch(input$compsel,
           "SIR size" = c('s.num', 'i.num', 'r.num'),
           "SIR prev" = c('s.prev', 'i.prev', 'r.prev'),
           "Incidence" = 'incid',
           "Rn / S prev" = c('Rn', 's.prev')
           )
  })
  leg <- reactive(function() {
    if (input$legend == TRUE) return('full')
    if (input$legend == FALSE) return('n')
  })
  output$compplot <- reactivePlot(function() {
    par(mar=c(3.5,3.5,1.2,1), mgp=c(2.2,1,0))
    comp.plot.mult(out(), compart=comp(), leg=leg(), lwd=3, axs='r', leg.cex=1, alpha=input$alpha)
  })
  output$dlPlot <- downloadHandler(
    filename = 'SIRplot.pdf',
    content = function(file) {
      pdf(file=file, h=6, w=10)
        par(mar=c(3.5,3.5,1.2,1), mgp=c(2.2,1,0))
      comp.plot.mult(out(), compart=comp(), leg=leg(), lwd=3, axs='r', leg.cex=1, alpha=input$alpha)
      dev.off()
    }
  )

  # Data tab
  output$outhead <- reactivePrint(function() {
    outrun <- round(get.run(out()), input$datadigits)
    rownames(outrun) <- rep('', nrow(outrun))
    outrun[which(outrun[,'time']==input$start):which(outrun[,'time']==input$end),]
  })
  output$dlData <- downloadHandler(
    filename = 'SIRdata.csv',
    content = function(file) {
      write.csv(get.run(out()), file)
    }
  )
  
  # Stats tab
  output$stats <- reactiveTable(function() {
    mod.stats(out(), time=input$time, console=FALSE)
  })
  
})