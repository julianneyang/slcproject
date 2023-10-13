
library(ggplot2)
library(rlang)
library(cowplot)
library(ggpubr)
library(viridis)
library(tidyr)
library(dplyr)

setwd("~/Documents/slcproject/slcproject/Spontaneous/Analysis_Files/")
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/slcproject/")

data<-read.csv("Open Field Groom_Rear Scoring - Analysis.csv", header=TRUE)
data<-read.csv("Spontaneous/Analysis_Files/Groom_Rear Analysis - Jacob_Only.csv", header=TRUE)


generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT", "HET", "MUT"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.8)+
    theme_cowplot(16) +
    #ylim(min,max)+
    #facet_grid(~Sex)+    
    theme(legend.position = "none")
  
}

#Groom and Rear
a<-generate_boxplots(data, Genotype, Groom.instances,0,550) +
  ggtitle("Grooms") + 
  labs(x="", y="# Grooms") + 
  theme(plot.title = element_text(hjust = 0.5))

a 

b<-generate_boxplots(data, Genotype, Rear.instances,0,550) +
  ggtitle("Rears") + 
  labs(x="", y="# Rears") + 
  theme(plot.title = element_text(hjust = 0.5))
b

plot_grid(a, b)

#Groom and Rear - stratify by Sex 

c<-generate_boxplots(data, Genotype, Groom.instances,0,550) +
  ggtitle("Grooms") + 
  labs(x="", y="# Grooms") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  facet_wrap(~Sex)

c 

d<-generate_boxplots(data, Genotype, Rear.instances,0,550) +
  ggtitle("Rears") + 
  labs(x="", y="# Rears") + 
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Sex)
d

plot_grid(c, d)

# Jacob vs Allyson - stratify by Sex 

e<-generate_boxplots(data, Genotype, Groom.instances,0,550) +
  ggtitle("Grooms") + 
  labs(x="", y="# Grooms") + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  facet_wrap(~Scorer)

e

d<-generate_boxplots(data, Genotype, Rear.instances,0,550) +
  ggtitle("Rears") + 
  labs(x="", y="# Rears") + 
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~Sex)
d

plot_grid(c, d)

## Groom --
# Add parametric and non-parametric stats to README.md
# WT vs MUT
data<-read.csv("Spontaneous/Analysis_Files/Groom_Rear Analysis - Jacob_Only.csv", header=TRUE)
data <- data %>% filter(Genotype!="HET")
t.test(Groom.instances~Genotype,data)
wilcox.test(Groom.instances~Genotype,data)

data<-read.csv("Open Field Groom_Rear Scoring - Analysis.csv", header=TRUE)

# WT vs HET
data <- data %>% filter(Genotype!="MUT")
t.test(Groom.instances~Genotype,data)
wilcox.test(Groom.instances~Genotype,data)

# WT vs MUT
data<-read.csv("Spontaneous/Analysis_Files/Groom_Rear Analysis - Jacob_Only.csv", header=TRUE)
data <- data %>% filter(Genotype!="HET")
t.test(Groom.instances~Genotype,data=subset(data, Sex=="Female"))
wilcox.test(Groom.instances~Genotype,subset(data, Sex=="Female"))
t.test(Groom.instances~Genotype,data=subset(data, Sex=="Male"))
wilcox.test(Groom.instances~Genotype,subset(data, Sex=="Male"))

# WT vs HET
data<-read.csv("Open Field Groom_Rear Scoring - Analysis.csv", header=TRUE)
data <- data %>% filter(Genotype!="MUT")
t.test(Groom.instances~Genotype,data=subset(data, Sex=="Female"))
wilcox.test(Groom.instances~Genotype,subset(data, Sex=="Female"))
t.test(Groom.instances~Genotype,data=subset(data, Sex=="Male"))
wilcox.test(Groom.instances~Genotype,subset(data, Sex=="Male"))

## Rear stats --
# Add parametric and non-parametric stats to README.md
# WT vs MUT
data<-read.csv("Open Field Groom_Rear Scoring - Analysis.csv", header=TRUE)
data <- data %>% filter(Genotype!="HET")
t.test(Rear.instances~Genotype,data)
wilcox.test(Rear.instances~Genotype,data)

data<-read.csv("Open Field Groom_Rear Scoring - Analysis.csv", header=TRUE)

# WT vs HET
data <- data %>% filter(Genotype!="MUT")
t.test(Rear.instances~Genotype,data)
wilcox.test(Rear.instances~Genotype,data)

# WT vs MUT
data<-read.csv("Open Field Groom_Rear Scoring - Analysis.csv", header=TRUE)
data <- data %>% filter(Genotype!="HET")
t.test(Rear.instances~Genotype,data=subset(data, Sex=="Female"))
wilcox.test(Rear.instances~Genotype,subset(data, Sex=="Female"))
t.test(Rear.instances~Genotype,data=subset(data, Sex=="Male"))
wilcox.test(Rear.instances~Genotype,subset(data, Sex=="Male"))

# WT vs HET
data<-read.csv("Open Field Groom_Rear Scoring - Analysis.csv", header=TRUE)
data <- data %>% filter(Genotype!="MUT")
t.test(Rear.instances~Genotype,data=subset(data, Sex=="Female"))
wilcox.test(Rear.instances~Genotype,subset(data, Sex=="Female"))
t.test(Rear.instances~Genotype,data=subset(data, Sex=="Male"))
wilcox.test(Rear.instances~Genotype,subset(data, Sex=="Male"))


