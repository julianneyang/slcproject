library(ggplot2)
library(rlang)
library(cowplot)
library(ggpubr)
library(viridis)
library(tidyr)
library(dplyr)
library(tidyverse)

setwd("~/Documents/slcspontaneous/ASO/Analysis_Files/")
data<-read.csv("ASO_MouseWeight.csv", header=TRUE)

generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$ASO_Tg, levels = c("Negative", "Positive"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    #ylim(min,max)+ 
    #facet_grid(~Sex)+    
    theme(legend.position = "none")
  
}

# Weight vs ASO_Tg

a<-generate_boxplots(data, ASO_Tg, Weight_1.g.,0,51)+
  stat_compare_means(comparisons = list(c("Negative", "Positive") 
  ),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)
a

#Stratify by Sex

b<-generate_boxplots(data, ASO_Tg, Weight_1.g.,0,51)+
  stat_compare_means(comparisons = list(c("Negative", "Positive") 
                                        ),method="wilcox", vjust=0.3,label="p.signif",step.increase=0.05)+
  facet_grid(~Sex)
b
