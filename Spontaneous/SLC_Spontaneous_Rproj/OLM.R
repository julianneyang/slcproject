library(ggplot2)
library(here)
library(ggplot2)
library(rlang)
library(rstatix)  
library(nlme)
library(cowplot)
library(ggbeeswarm)
library(ggpubr)
library(ggsignif)

data_box_plot<- read.csv("Data_OLM_Analysis.csv", header=TRUE)

mytheme <- theme(panel.grid.minor=element_blank(), #gets rid of grey and lines in the middle
                 panel.grid.major=element_blank(), #gets rid of grey and lines in the middle
                 panel.background=element_rect(fill="white"),#gets rid of grey and lines in the middle
                 panel.border=element_blank(), #gets rid of square going around the entire graph
                 axis.line.x = element_line(colour = 'black', size = 1),#sets the axis line size
                 axis.line.y = element_line(colour = 'black', size = 1),#sets the axis line size
                 axis.ticks=element_line(colour = 'black', size = 0.5), #sets the tick lines
                 axis.title.x = element_text(size=10, color="black"), #size of x-axis title
                 axis.title.y = element_text(size=10, color="black"), #size of y-axis title
                 axis.text.x = element_text(size=12, color="black"), #size of x-axis text
                 axis.text.y = element_text(size=12, color="black"))#size of y-axis text

data_box_plot$Day <- factor(data_box_plot$Day)
data_box_plot$Day <- plyr::revalue(data_box_plot$Day, c('1' = "Training", '2' = "Testing"))

#Stratify by Day
generate_longitudinal_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT","HET","MUT"))
  data$Day <- factor(data$Day, levels = c("Training", "Testing"))
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    geom_boxplot(alpha=0.25)+ 
    geom_line(aes(group = MouseID,color=Genotype),size=0.65)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    ggtitle("OLM Analysis - Training v Testing") +
    scale_color_manual(values = c(WT = "#2b8cbe", HET = "#7BCB5B", MUT = "#FB4A4A")) +
    theme(legend.position = "top") 
}

fullplot<-generate_longitudinal_boxplots(data_box_plot, Day, Percent_Time_Investigated,0,100)
plot(fullplot)

#Stratify by Sex & Day
data_box_plot$Genotype <- factor(data_box_plot$Genotype,levels=c("WT", "HET", "MUT"))
females <- subset(data_box_plot, Sex =="Female")
generate_longitudinal_boxplots_female <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT","HET","MUT"))
  data$Day <- factor(data$Day, levels = c("Training", "Testing"))
  
  ggplot(data=females,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    geom_boxplot(alpha=0.25)+ 
    geom_line(aes(group = MouseID,color=Genotype),size=0.65)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    ggtitle("OLM Analysis - Females") +
    ylim(10,80) +
    scale_color_manual(values = c(WT = "#2b8cbe", HET = "#7BCB5B", MUT = "#FB4A4A")) +
    theme(legend.position = "right") 
}

males <- subset(data_box_plot, Sex=="Male")
generate_longitudinal_boxplots_male <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT","HET","MUT"))
  data$Day <- factor(data$Day, levels = c("Training", "Testing"))
  
  ggplot(data=males,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    geom_boxplot(alpha=0.25)+ 
    geom_line(aes(group = MouseID,color=Genotype),size=0.65)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.1)+
    theme_cowplot(16) +
    ylim(10,80) +
    ggtitle("OLM Analysis - Males") +
    scale_color_manual(values = c(WT = "#2b8cbe", HET = "#7BCB5B", MUT = "#FB4A4A")) +
    theme(legend.position = "right") 
}

females_only<-generate_longitudinal_boxplots_female(females, Day, Percent_Time_Investigated,0,100)
males_only<-generate_longitudinal_boxplots_male(males, Day, Percent_Time_Investigated,0,100)
plot_grid(females_only, males_only)

#Stratify by Sex, Testing Only
data_box_plot$Genotype <- factor(data_box_plot$Genotype,levels=c("WT", "HET", "MUT"))
fulltesting <- subset(data_box_plot, Day=="Testing")
violin<-ggplot(data=fulltesting,aes(x=Genotype,y=Percent_Time_Investigated, fill=Genotype))+
  geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
  geom_point(aes(color=Genotype),size=2,position=position_jitter(width=0.25),alpha=1)+
  mytheme + theme_cowplot(16) + ggtitle("OLM Testing Day - Genotypes")  + ylim(10,80)
plot(violin)

ftesting <- subset(females, Day=="Testing")
violin2<-ggplot(data=ftesting,aes(x=Genotype,y=Percent_Time_Investigated, fill=Genotype))+
  geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
  geom_point(aes(color=Genotype),size=2,position=position_jitter(width=0.25),alpha=1)+
  mytheme + theme_cowplot(16) + ggtitle("OLM Testing Day - Females by Genotype")  + ylim(10,80)

mtesting <- subset(males, Day=="Testing")
violin3<-ggplot(data=mtesting,aes(x=Genotype,y=Percent_Time_Investigated, fill=Genotype))+
  geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
  geom_point(aes(color=Genotype),size=2,position=position_jitter(width=0.25),alpha=1)+
  mytheme + theme_cowplot(16) + ggtitle("OLM Testing Day - Males by Genotype")  + ylim(10,80)

plot_grid(violin2, violin3)

#Stat Tests
# WT vs MUT Training
data_wm <- data_box_plot %>% filter(Genotype!="HET", Day != "Testing")
t.test(Percent_Time_Investigated~Genotype,data_wm)
wilcox.test(Percent_Time_Investigated~Genotype,data_wm)

# WT vs MUT Testing
data_wm <- data_box_plot %>% filter(Genotype!="HET", Day != "Training")
t.test(Percent_Time_Investigated~Genotype,data_wm)
wilcox.test(Percent_Time_Investigated~Genotype,data_wm)

# WT vs HET: Training
data_wh <- data_box_plot %>% filter(Genotype!="MUT", Day != "Testing")
t.test(Percent_Time_Investigated~Genotype,data_wh, exact = FALSE)
wilcox.test(Percent_Time_Investigated~Genotype,data_wh, exact = FALSE)


# WT vs HET: Testing
data_wh <- data_box_plot %>% filter(Genotype!="MUT", Day != "Training")
t.test(Percent_Time_Investigated~Genotype,data_wh, exact = FALSE)
wilcox.test(Percent_Time_Investigated~Genotype,data_wh, exact = FALSE)

#Longitudinal Slope Test
Percent_Investigation_Time = data_box_plot$Percent_Time_Investigated
output=lme(fixed= Percent_Investigation_Time~ Sex + Genotype, random = ~1|MouseID, data=data_box_plot)
summary(output)



