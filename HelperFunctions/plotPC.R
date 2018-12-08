plotPC <- function(data, index, toll, namesVar){
  #data: dataset
  #index: number of PC
  #toll: tollerance for selecting the component to visualize
  #nameVar: name of vars in the legend...in easy way set nameVar=names(data)
  pc.data <- princomp(data, scores=T)
  loading = pc.data$loadings[,index]
  dataframe <- as.data.frame(loading[which(loading^2 > toll)])
  names(dataframe) <-  "loads"
  Colored_by <- names(data[which(loading^2 > toll)])
  plot.load <- ggplot(data= dataframe , aes(x = names(data[which(loading^2 > toll)]), y=dataframe$loads^2, fill =Colored_by)) + geom_bar(stat = "identity", colour = "black")
  plot.load <- plot.load + ylab("Loadings (L2 norm)") + xlab("Original variables")
  plot.load <- (  plot.load + ggtitle(paste("PCA",as.character(index),sep = " ")) 
                  + theme(plot.title = element_text(lineheight=.8, face="bold", hjust = 0.5)) 
                  + scale_fill_discrete(name="LEGEND", breaks=names(data),labels=namesVar) 
                ) 
  
  return(plot.load)
}
