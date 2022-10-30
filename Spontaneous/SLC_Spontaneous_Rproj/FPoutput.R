library(ggplot2)
library(dplyr)
library(cowplot)

setwd("C:/Users/Josephine Borsetto/OneDrive/Documents/slcspontaneous/Analysis_Files/")

### Figures ---
# Read in the data as a long format 
data<- read.csv("SLC Spontaneous Gastrointestinal Motility - Sample Analysis Sheet.csv",header=T)

# Declare order of variables 
data$Genotype <- factor(data$Genotype, levels=c("WT", "HET", "MUT"))
data$Sex_Genotype <- paste0(data$Sex, "_",data$Genotype)

# Custom Function for making a line graph ---

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


# Make line graphs for each sex 

generate_line_graph(males, Time, Average_FP, Genotype, Genotype)+
  ggtitle("Fecal Pellets Over Time, males")+
  theme(plot.title = element_text(hjust = 0.5)) 
generate_line_graph(females, Time, Average_FP, Genotype, Genotype)+
  ggtitle("Fecal Pellets Over Time, females")+
  theme(plot.title = element_text(hjust = 0.5)) 






