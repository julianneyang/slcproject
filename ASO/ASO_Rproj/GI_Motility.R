library(ggplot2)
library(dplyr)
library(cowplot)
library(nlme)
library(tidyr)

setwd("/Users/rochellelai/Box Sync/Jacobs/slcspontaneous")

### Sex_Genotype Figures ###
# Read data
data<- read.csv("SLC_Sex_Genotype_Analysis.csv",header=T)

# Declare order of variables 
data$Genotype <- factor(data$Genotype, levels=c("WT", "HET", "MUT"))
data$Sex_Genotype <- paste0(data$Sex, "_",data$Genotype)

# Custom Function for making a line graph
generate_line_graph <- function (input_data, X, Y, groupby, linecolor) {
  
  data<- as.data.frame(input_data)
  
  ggplot(data, aes(x={{X}}, y={{Y}}, color={{linecolor}})) + 
    geom_line(aes(group={{groupby}}),lwd=1) +
    geom_point(aes(group={{groupby}}))+
    geom_errorbar(aes(ymin={{Y}}-Std_Error, 
                      ymax={{Y}}+Std_Error), width=0.2,position=position_dodge(0.05)) +
    theme_cowplot(16)
}

# Call line graph function 
generate_line_graph(data, Time, Average_FP, Sex_Genotype, Sex_Genotype)

# Filter by Sex 
females <- data %>% filter(Sex=="F")
males <- data %>% filter(Sex=="M")

# Make line graphs for each sex and all data
plt1 <- generate_line_graph(males, Time, Average_FP, Genotype, Genotype)+
  ggtitle("Fecal Pellets Over Time, males")+
  theme(plot.title = element_text(hjust = 0.5)) 

plt2 <- generate_line_graph(females, Time, Average_FP, Genotype, Genotype)+
  ggtitle("Fecal Pellets Over Time, females")+
  theme(plot.title = element_text(hjust = 0.5)) 

plt3 <- generate_line_graph(data, Time, Average_FP, Sex_Genotype, Sex_Genotype)+
  ggtitle("Fecal Pellets Over Time")+
  theme(plot.title = element_text(hjust = 0.5)) 

# Save plot
ggsave("SLC_sex_genotype_plot_males.png", plt1, width = 12, height = 9)
ggsave("SLC_sex_genotype_plot_females.png", plt2, width = 12, height = 9)
ggsave("SLC_sex_genotype_plot_all.png", plt3, width = 12, height = 9)

### Tg_Sex Figures ###
# Read data 
data <- read.csv("SLC_Sex_Tg_Analysis.csv",header=T)

# Declare order of variables 
data$Tg <- factor(data$Tg, levels=c("POS", "NEG"))
data$Sex_Tg <- paste0(data$Sex, "_",data$Tg)

# Custom Function for making a line graph
generate_line_graph <- function (input_data, X, Y, groupby, linecolor) {
  
  data<- as.data.frame(input_data)
  
  ggplot(data, aes(x={{X}}, y={{Y}}, color={{linecolor}})) + 
    geom_line(aes(group={{groupby}}),lwd=1) +
    geom_point(aes(group={{groupby}}))+
    geom_errorbar(aes(ymin={{Y}}-Std_Error, 
                      ymax={{Y}}+Std_Error), width=0.2,position=position_dodge(0.05)) +
    theme_cowplot(16)
}

# Call line graph function 
generate_line_graph(data, Time, Average_FP, Sex_Tg, Sex_Tg)

# Filter by Sex 
females <- data %>% filter(Sex=="F")
males <- data %>% filter(Sex=="M")

# Make line graphs for each sex and all data
plt1 <- generate_line_graph(males, Time, Average_FP, Tg, Tg)+
  ggtitle("Fecal Pellets Over Time, males")+
  theme(plot.title = element_text(hjust = 0.5)) 

plt2 <- generate_line_graph(females, Time, Average_FP, Tg, Tg)+
  ggtitle("Fecal Pellets Over Time, females")+
  theme(plot.title = element_text(hjust = 0.5)) 

plt3 <- generate_line_graph(data, Time, Average_FP, Sex_Tg, Sex_Tg)+
  ggtitle("Fecal Pellets Over Time")+
  theme(plot.title = element_text(hjust = 0.5)) 

# Save plot
ggsave("SLC_sex_tg_plot_males.png", plt1, width = 12, height = 9)
ggsave("SLC_sex_tg_plot_females.png", plt2, width = 12, height = 9)
ggsave("SLC_sex_tg_plot_all.png", plt3, width = 12, height = 9)

### Linear Regression ###
# Read data in long format
data <- read.csv("SLC_Analysis_Wide.csv",header=T)

# Summarize data
longdata <- data %>%
  pivot_longer(!c(MouseID, Sex, Genotype, ASO_Tg), names_to = "Time", values_to = "FP_output")

longdata$Genotype <- factor(longdata$Genotype, levels = c("WT", "HET", "MUT"))

# Statistics
output=lme(fixed= FP_output ~ ASO_Tg, random = ~1|MouseID, data=longdata)
summary(output)

output=lme(fixed= FP_output ~ ASO_Tg + Sex, random = ~1|MouseID, data=longdata)
summary(output)

output=lme(fixed= FP_output ~ ASO_Tg + Genotype, random = ~1|MouseID, data=longdata)
summary(output)

output=lme(fixed= FP_output ~ ASO_Tg + Sex + Genotype, random = ~1|MouseID, data=longdata)
summary(output)
