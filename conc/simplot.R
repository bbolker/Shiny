

sim.plot <- function(md, dur, conc, pos=1, medians=FALSE,
                     sims=NULL, simlines=TRUE, alpha=NULL,
                     leg=TRUE
                     ) {
  
  data <- paste('Data/sim.d', dur, '.md', gsub('\\.','',md), '.Rdata', sep='')
  load(data)
  
  par(mar=c(3.5,3.5,2.5,1), mgp=c(2.2,1,0))
  if (length(conc) == 1) par(mfrow=c(1,1))
  if (length(conc) == 2 & pos == 1) par(mfrow=c(2,1))
  if (length(conc) == 2 & pos == 2) par(mfrow=c(1,2))
  if (length(conc) > 2) par(mfrow=c(2,2))
  
  mains <- c('No Concurrency', 'Female Concurrency', 
             'Male Concurrency', 'Both Concurrency')
  
  for (combin in conc) {
    
    allc <- do.call(cbind, all[[combin]])
    ymax <- max(allc) + max(allc)*0.10
    
    if (is.null(sims)) sims <- length(all[[combin]])
    
    data.m <- allc[,names(allc)=='male.prev']
    if (sims < 50) data.m <- data.m[,sample(1:50, sims)]
    data.f <- allc[,names(allc)=='feml.prev']
    if (sims < 50) data.f <- data.f[,sample(1:50, sims)]
    
    if (sims > 1) {
      med.m <- apply(data.m, 1, median)
      med.f <- apply(data.f, 1, median)
    } else {
      med.m <- data.m
      med.f <- data.f
    }
    
    pal <- c(brewer.pal(3, 'Set1'), 'black')
    if (is.null(alpha)) alpha <- min(5/sims, 1)
    tpal <- transco(pal, alpha)
    
    plot(1:numtimesteps, type='n', ylim=c(0,ymax), 
         xlab='Months', ylab='Prevalence', main=mains[combin])
    if (simlines) {
      if (sims == 1) {
        lines(data.m, col=tpal[1], lwd=0.5)
        lines(data.f, col=tpal[2], lwd=0.5)
      } else {
        for (sim in 1:sims){
          lines(data.m[,sim], col=tpal[1], lwd=0.5)
          lines(data.f[,sim], col=tpal[2], lwd=0.5)
        }
      }
    }
    if (medians) {
      lines(med.m, col='black', lwd=2.3)
      lines(med.m, col=pal[1], lwd=2)
      
      lines(med.f, col='black', lwd=2.3)
      lines(med.f, col=pal[2], lwd=2)
    }
    if (leg) {
      legend('topleft', c('Male','Female'), lwd=3, col=pal[1:2], bty='n')
    }
    
  }
}


sim.table <- function(md, dur, conc, male=1, digits=4
                      ) {
  
  data <- paste('Data/sim.d', dur, '.md', gsub('\\.','',md), '.Rdata', sep='')
  load(data)
      
  mains <- c('No Conc.', 'Female Conc.', 
             'Male Conc.', 'Both Conc.')
  
  c1 <- do.call(cbind, all[[1]])
    c1m <- c1[,names(c1)=='male.prev']
      c1m.med <- apply(c1m, 1, median)
    c1f <- c1[,names(c1)=='feml.prev']
      c1f.med <- apply(c1f, 1, median)
  c2 <- do.call(cbind, all[[2]])
    c2m <- c2[,names(c2)=='male.prev']
      c2m.med <- apply(c2m, 1, median)
    c2f <- c2[,names(c2)=='feml.prev']
      c2f.med <- apply(c2f, 1, median)
  c3 <- do.call(cbind, all[[3]])
    c3m <- c3[,names(c3)=='male.prev']
      c3m.med <- apply(c3m, 1, median)
    c3f <- c3[,names(c3)=='feml.prev']
      c3f.med <- apply(c3f, 1, median)
  c4 <- do.call(cbind, all[[4]])
    c4m <- c4[,names(c4)=='male.prev']
      c4m.med <- apply(c4m, 1, median)
    c4f <- c4[,names(c4)=='feml.prev']
      c4f.med <- apply(c4f, 1, median)

  times <- seq(1, 2400, 200)
  
  if (male==1) {
    c1m.out <- c1m.med[times]
    c2m.out <- c2m.med[times]
    c3m.out <- c3m.med[times]
    c4m.out <- c4m.med[times]
    resmat <- rbind(c1m.out, c2m.out, c3m.out, c4m.out)
  } else {
    c1f.out <- c1f.med[times]
    c2f.out <- c2f.med[times]
    c3f.out <- c3f.med[times]
    c4f.out <- c4f.med[times]
    resmat <- rbind(c1f.out, c2f.out, c3f.out, c4f.out)
  }
  
  rownames(resmat) <- mains
  colnames(resmat) <- times

  resmat <- round(resmat, digits)  
  
  return(resmat)
  
}