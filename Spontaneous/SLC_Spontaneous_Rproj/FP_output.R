library(ggplot2)
library(dplyr)
library(cowplot)
library(nlme)

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



#output=lme(fixed= Average_FP ~ Sex + Genotype, random = ~1|MouseID, data=data)
#summary(output)
#output=lme(fixed= Average_FP ~ Sex + Genotype, random = ~1|MouseID, data=females)
#summary(output)
#output=lme(fixed= Average_FP ~ Sex + Genotype, random = ~1|MouseID, data=males)
#summary(output)

#For cross-sectional analysis stats 
data <- read.csv("SLC Spontaneous Gastrointestinal Motility - Analysis_Wide.csv", header=TRUE)


## 5 minutes 
# WT vs MUT
data_wm <- data %>% filter(Genotype!="HET")
t.test(X5_min~Genotype,data_wm)
wilcox.test(X5_min~Genotype,data_wm)

# WT vs HET
data_wh <- data %>% filter(Genotype!="MUT")
t.test(X5_min~Genotype,data_wh)
wilcox.test(X5_min~Genotype,data_wh)

## 10 minutes 

# WT vs MUT
data_wm <- data %>% filter(Genotype!="HET")
t.test(X10_min~Genotype,data_wm)
wilcox.test(X10_min~Genotype,data_wm)

# WT vs HET
data_wh <- data %>% filter(Genotype!="MUT")
t.test(X10_min~Genotype,data_wh)
wilcox.test(X10_min~Genotype,data_wh)

##15 minutes

# WT vs MUT
data_wm <- data %>% filter(Genotype!="HET")
t.test(X15_min~Genotype,data_wm)
wilcox.test(X15_min~Genotype,data_wm)

# WT vs HET
data_wh <- data %>% filter(Genotype!="MUT")
t.test(X15_min~Genotype,data_wh)
wilcox.test(X15_min~Genotype,data_wh)


##30 minutes

# WT vs MUT
data_wm <- data %>% filter(Genotype!="HET")
t.test(X30_min~Genotype,data_wm)
wilcox.test(X30_min~Genotype,data_wm)

# WT vs HET
data_wh <- data %>% filter(Genotype!="MUT")
t.test(X30_min~Genotype,data_wh)
wilcox.test(X30_min~Genotype,data_wh)


##45 minutes

# WT vs MUT
data_wm <- data %>% filter(Genotype!="HET")
t.test(X45_min~Genotype,data_wm)
wilcox.test(X45_min~Genotype,data_wm)

# WT vs HET
data_wh <- data %>% filter(Genotype!="MUT")
t.test(X45_min~Genotype,data_wh)
wilcox.test(X45_min~Genotype,data_wh)

##60 minutes

# WT vs MUT
data_wm <- data %>% filter(Genotype!="HET")
t.test(X60_min~Genotype,data_wm)
wilcox.test(X60_min~Genotype,data_wm)

# WT vs HET
data_wh <- data %>% filter(Genotype!="MUT")
t.test(X60_min~Genotype,data_wh)
wilcox.test(X60_min~Genotype,data_wh)






# Filter by Sex 
females <- data %>% filter(Sex=="Female")
males <- data %>% filter(Sex=="Male")

#5 minutes Females

# WT vs MUT
data_wm <-females %>% filter(Genotype!="HET")
t.test(X5_min~Genotype,data_wm)
wilcox.test(X5_min~Genotype,data_wm)

# WT vs HET
data_wh <- females %>% filter(Genotype!="MUT")
t.test(X5_min~Genotype,data_wh)
wilcox.test(X5_min~Genotype,data_wh)

#5 minutes males

# WT vs MUT
data_wm <-males %>% filter(Genotype!="HET")
t.test(X5_min~Genotype,data_wm)
wilcox.test(X5_min~Genotype,data_wm)

# WT vs HET
data_wh <- males %>% filter(Genotype!="MUT")
t.test(X5_min~Genotype,data_wh)
wilcox.test(X5_min~Genotype,data_wh)

#10 minutes females



#10 minutes males



#15 minutes females



#15 minutes males



#30 minutes females



#30 minutes males



#45 minutes females



#45 minutes males



#60 minutes females



#60 minutes males

