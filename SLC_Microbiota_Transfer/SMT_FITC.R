library(here)
library(ggplot2)
library(rlang)
library(rstatix)  
library(nlme)
library(cowplot)
library(ggbeeswarm)
library(ggpubr)
library(ggsignif)

setwd("/Users/margaretblack/Desktop/JacobsLab/slcproject")
data<-read.csv("SLC_Microbiota_Transfer/SMT Open Field Groom_Rear Scoring - Analysis.csv", header=TRUE)
names(data)
generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT", "MUT"))
  data$Sex <- factor(data$Sex, levels = c("F","M"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+ 
    geom_quasirandom(alpha=0.1)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    #ylim(min,max)+
    theme(legend.position = "none")
  
  
}

## lines that you need to modify ---
grooms <- data %>% filter(Behavior=="groom")
grooms_plot <- generate_boxplots(grooms, Genotype, Instances, 0,90 ) + 
  facet_grid(~Scorer) +
  ggtitle("Grooms") +
  theme(plot.title = element_text(hjust = 0.5)) 
  stat_compare_means(comparisons = list(c("WT", "MUT")),method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)

rears <- data%>% filter (Behavior=="rear")  
rears_plot <- generate_boxplots(rears, Genotype, Instances, 0,90 ) + 
  facet_grid(~Scorer) +
  ggtitle("Rears") +
  theme(plot.title = element_text(hjust = 0.5))
  stat_compare_means(comparisons = list(c("WT", "MUT")),method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)

plot_grid(rears_plot, grooms_plot)
  
  
# Add parametric and non-parametric stats to README.md
# WT vs MUT
data <- data %>% filter(Genotype!="HET")
t.test(Weight..g.~Genotype,data)
wilcox.test(Weight..g.~Genotype,data)

data<-read.csv("SLC Spontaneous Weights - Sheet1.csv", header=TRUE)

# WT vs HET
data <- data %>% filter(Genotype!="MUT")
t.test(Weight..g.~Genotype,data)
wilcox.test(Weight..g.~Genotype,data)


