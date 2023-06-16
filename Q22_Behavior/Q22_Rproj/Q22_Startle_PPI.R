library(ggplot2)
library(rlang)
library(cowplot)
library(viridis)
library(tidyr)
library(dplyr)

data<-read.csv("../Startle_PPI_Analysis - Analysis.csv", header=TRUE)
data$SLC_Genotype<-data$SLC
data$SLC_Genotype <- factor(data$SLC_Genotype, levels=c("WT", "HET", "MUT"))
data$Q22 <- factor(data$Q22, levels=c("WT","KO"))
generate_boxplots <- function(input_data, X, Y, min,max){
  data<-as.data.frame(input_data)
  
  ggplot(data=data,aes(x={{X}},y={{Y}}, fill={{X}})) + 
    #geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    geom_boxplot(alpha=0.25)+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.5)+
    theme_cowplot(12) +
    #ylim(min,max)+ 
    #facet_grid(~Sex)+    
    theme(legend.position = "none")
  
}

## Startle PPI on full dataset --
summary(data$X70db_Percent_Inhibition)
db70 <-generate_boxplots(data, Q22, X70db_Percent_Inhibition,-30,85) +
  ggtitle("70 db Prepulse Inhibition")+
  theme(plot.title = element_text(hjust = 0.5))
db70

db75 <-generate_boxplots(data, Q22, X75db_Percent_Inhibition,-30,85) +
  ggtitle("75 db Prepulse Inhibition")+
  theme(plot.title = element_text(hjust = 0.5))
db75

db80 <-generate_boxplots(data, Q22, X75db_Percent_Inhibition,-30,85) +
  ggtitle("80 db Prepulse Inhibition")+
  theme(plot.title = element_text(hjust = 0.5))
db80

summary(data$First_average_VMax)
startle <-generate_boxplots(data, Q22, First_average_VMax, 0,1200) +
  ggtitle("First Startle")+
  theme(plot.title = element_text(hjust = 0.5))
startle

## Startle PPI on only SLC WT mice
data_slcwt <- data %>% filter(SLC_Genotype=="WT")
summary(data_slcwt$X70db_Percent_Inhibition)
db70_slcwt <-generate_boxplots(data_slcwt, Q22, X70db_Percent_Inhibition,-30,85) +
  ggtitle("70 db")+
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x="", y="% Prepulse Inhibition")
db70_slcwt

db75_slcwt <-generate_boxplots(data_slcwt, Q22, X75db_Percent_Inhibition,-30,85) +
  ggtitle("75 db")+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(x="", y="% Prepulse Inhibition")
db75_slcwt + facet_wrap(~Sex)

db80_slcwt <-generate_boxplots(data_slcwt, Q22, X75db_Percent_Inhibition,-30,85) +
  ggtitle("80 db")+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(x="", y="% Prepulse Inhibition")
db80_slcwt

summary(data$First_average_VMax)
startle_slcwt <-generate_boxplots(data_slcwt, Q22, First_average_VMax, 0,1200) +
  ggtitle("First Startle")+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(x="", y="Average VMax")
startle_slcwt

summary(data$middle_average_VMax)
middle_startle_slcwt <-generate_boxplots(data_slcwt, Q22, middle_average_VMax, 0,1200) +
  ggtitle("Middle Startle")+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(x="", y="Average VMax")
middle_startle_slcwt

last_startle_slcwt <-generate_boxplots(data_slcwt, Q22, last_average_VMax, 0,1200) +
  ggtitle("Last Startle")+
  theme(plot.title = element_text(hjust = 0.5))+
  labs(x="", y="Average VMax")
last_startle_slcwt


plot_grid(startle_slcwt, middle_startle_slcwt, last_startle_slcwt,
          db70_slcwt, db75_slcwt,db80_slcwt, labels=c("A","B","C","D","E", "F"))

## Stratified by SLC Genotype --
b<-generate_boxplots(data, SLC_Genotype, Total_Time,0,51)+
  facet_wrap(~Q22)
b

# Stratified by SLC Genotype and Sex 
e<-generate_boxplots(data, SLC_Genotype, Total_Time,0,51)+
  facet_wrap(Sex~ASO_Tg)
e

## Parametric Stats for SLC WT only --
lm1 <- lm(First_average_VMax ~ Sex+ Q22, data = data_slcwt)
summary(lm1)

wilcox.test(First_average_VMax~Q22,data_slcwt )

lm2 <- lm(X70db_Percent_Inhibition ~ Litter+ Sex + Q22, data = data_slcwt)
summary(lm2)

wilcox.test(X70db_Percent_Inhibition~Q22,data_slcwt )


lm3 <- lm(X75db_Percent_Inhibition ~ Litter+ Sex + Q22, data = data_slcwt)
summary(lm3)

wilcox.test(X75db_Percent_Inhibition~Q22,data_slcwt )

lm4 <- lm(X80db_Percent_Inhibition ~ Litter+ Sex + Q22, data = data_slcwt)
summary(lm4)

wilcox.test(X80db_Percent_Inhibition~Q22,data_slcwt )

lm5 <- lm(middle_average_VMax ~Sex +Q22, data = data_slcwt)
summary(lm5)
wilcox.test(middle_average_VMax~Q22,data_slcwt )


lm6 <- lm(last_average_VMax ~Sex + Q22, data = data_slcwt)
summary(lm6)
wilcox.test(last_average_VMax~Q22,data_slcwt )



# Save outputs -
sink("Buried_Food_Pellet_Stats.md")
cat("\n\nSummary for all data:\n")
print(summary(lm1))
cat("\n\nSummary for interaction:\n")
print(summary(interact))
cat("\n\nSummary for Tg Neg:\n")
print(summary(lm3))
cat("\n\nSummary for Tg Pos:\n")
print(summary(lm2))
cat("\n\nSummary for Females Tg Neg:\n")
print(summary(lm4))
cat("\n\nSummary for Females Tg Pos:\n")
print(summary(lm5))
cat("\n\nSummary for Males Tg Neg:\n")
print(summary(lm6))
cat("\n\nSummary for Males Tg Pos:\n")
print(summary(lm7))
sink()
