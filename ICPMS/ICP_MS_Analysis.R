###### SLC ICP-MS Data Aggregated ---
### Date: 10.26.2022
### Contents: Includes data from 10/5/21 and 10/25/22 Core submissions
###### End ---

library(here)
library(ggplot2)
library(rlang)
library(cowplot)
library(ggpubr)
library(dplyr)

setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/ICPMS/")
here::i_am("ICP_MS_Analysis.R")

### Data Preprocessing ---
df<- read.csv("Analysis_ICP_MS.csv", header=TRUE, row.names=1)

# replace all n/a and declare all element columns as numerical
df[df=="n/a"]<-0
vector <- names(df)
elements <- vector[1:7]
df <- df %>% mutate_at(c(elements), as.numeric)
str(df)

# Generate a version of a df without outlier samples 
# create detect outlier function

detect_outlier <- function(x) {
  
  # calculate first quantile
  Quantile1 <- quantile(x, probs=.25,na.rm = TRUE)
  # calculate third quantile
  Quantile3 <- quantile(x, probs=.75,na.rm=TRUE)
  # calculate inter quartile range
  IQR = Quantile3-Quantile1
  # return true or false
  x > Quantile3 + (IQR*1.5) | x < Quantile1 - (IQR*1.5)
}

# create remove outlier function
remove_outlier <- function(dataframe,
                            columns=names(dataframe)) {
  
  # for loop to traverse in columns vector
  for (col in columns) {
    
    # remove observation if it satisfies outlier function
    dataframe <- dataframe[!detect_outlier(dataframe[[col]]), ]
  }
  
  # return dataframe
  print("Remove outliers")
  print(dataframe)
  
}

df_nooutliers_iron <- remove_outlier(df, c('Iron'))
  df_nooutliers_iron <- df_nooutliers_iron %>% select(c("Iron","Batch", "MouseID","SampleType","Genotype", "Sex"))
  df_nooutliers_iron$Element <- "Iron"
  colnames(df_nooutliers_iron)[1] <- "Concentration"
df_nooutliers_cobalt <- remove_outlier(df, c('Cobalt'))
  df_nooutliers_cobalt <- df_nooutliers_cobalt %>% select(c("Cobalt","Batch", "MouseID","SampleType","Genotype", "Sex"))
  df_nooutliers_cobalt$Element <- "Cobalt"
  colnames(df_nooutliers_cobalt)[1] <- "Concentration"
df_nooutliers_copper <- remove_outlier(df, c('Copper'))
  df_nooutliers_copper <- df_nooutliers_copper %>% select(c("Copper","Batch", "MouseID","SampleType","Genotype", "Sex"))
  df_nooutliers_copper$Element <- "Copper"
  colnames(df_nooutliers_copper)[1] <- "Concentration"
df_nooutliers_zinc <- remove_outlier(df, c('Zinc'))
  df_nooutliers_zinc <- df_nooutliers_zinc %>% select(c("Copper","Batch", "MouseID","SampleType","Genotype", "Sex"))
  df_nooutliers_zinc$Element <- "Zinc"
  colnames(df_nooutliers_zinc)[1] <- "Concentration"
df_nooutliers_cadmium <- remove_outlier(df, c('Cadmium'))
  df_nooutliers_cadmium <- df_nooutliers_cadmium %>% select(c("Copper","Batch", "MouseID","SampleType","Genotype", "Sex"))
  df_nooutliers_cadmium$Element <- "Cadmium"
  colnames(df_nooutliers_cadmium)[1] <- "Concentration"
df_nooutliers_mn <- remove_outlier(df, c('Manganese'))
  df_nooutliers_mn <- df_nooutliers_mn %>% select(c("Copper","Batch", "MouseID","SampleType","Genotype", "Sex"))
  df_nooutliers_mn$Element <- "Manganese"
  colnames(df_nooutliers_mn)[1] <- "Concentration"
df_nooutliers_se <- remove_outlier(df, c('Selenium'))
  df_nooutliers_se <- df_nooutliers_se %>% select(c("Copper","Batch", "MouseID","SampleType","Genotype", "Sex"))
  df_nooutliers_se$Element <- "Selenium"
  colnames(df_nooutliers_se)[1] <- "Concentration"
  
aggregated_df_nooutliers <- rbind(df_nooutliers_iron, df_nooutliers_cobalt,
                                  df_nooutliers_copper, df_nooutliers_zinc,
                                  df_nooutliers_cadmium, df_nooutliers_mn, df_nooutliers_se)

# Subset by SampleType - with outliers
df_fp_col <- df %>% filter(SampleType=="FP-COL")
df_fp_si <- df %>% filter(SampleType=="FP-SI")
df_muc_col <- df %>% filter(SampleType=="MUC-COL")
df_muc_si <- df %>% filter(SampleType=="MUC-SI")
df_ts_col <- df %>% filter(SampleType=="TS-COL")
df_ts_si <- df %>% filter(SampleType=="TS-SI")

# Subset by SampleType - without outliers
df_fp_col <- aggregated_df_nooutliers %>% filter(SampleType=="FP-COL")
df_fp_si <- aggregated_df_nooutliers %>% filter(SampleType=="FP-SI")
df_muc_col <- aggregated_df_nooutliers %>% filter(SampleType=="MUC-COL")
df_muc_si <- aggregated_df_nooutliers %>% filter(SampleType=="MUC-SI")
df_ts_col <- aggregated_df_nooutliers %>% filter(SampleType=="TS-COL")
df_ts_si <- aggregated_df_nooutliers %>% filter(SampleType=="TS-SI")

### Figures ---
generate_violin_plots <- function (input_data, column_index) {
  # read in file
  data<-as.data.frame(input_data)
  
  #Ensure correct ordering of levels 
  data$Genotype <- factor(data$Genotype, levels = c("WT","MUT"))
  
  #Get correct y-axis label
  ylabel <- c(elements[column_index])
  
  ggplot(data=data,aes(x=Genotype,y=data[, column_index], fill=Genotype)) + 
    geom_violin(alpha=0.25,position=position_dodge(width=.75),size=1,color="black",draw_quantiles=c(0.5))+
    scale_fill_viridis_d()+
    geom_point(size=1,position=position_jitter(width=0.25),alpha=0.8)+
    theme_cowplot(16) +
    theme(legend.position = "none") +
    labs(x="",y=ylabel)
    #ylim(min,max) +
    
}


element_plots <- list()
fp_col_plots <- list()
fp_si_plots <- list()
muc_col_plots <- list()
muc_si_plots <- list()
ts_col_plots <- list()
ts_si_plots <- list()
compare_vector<- c("WT","MUT")
# Loop through all elements

for (int in 1:7){
    print(int)

    fp_col <- generate_violin_plots(df_fp_col, int) +
      theme(plot.title = element_text(hjust = 0.5)) +
      ggtitle("FP Col")+
      stat_compare_means(comparisons = compare_vector,
                         method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)
    fp_si <- generate_violin_plots(df_fp_si, int)+
      theme(plot.title = element_text(hjust = 0.5)) +
      ggtitle("FP SI")+
      stat_compare_means(comparisons = compare_vector,
                         method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)
    muc_si <- generate_violin_plots(df_muc_si, int) +
      theme(plot.title = element_text(hjust = 0.5)) +
      ggtitle("MUC SI")+
      stat_compare_means(comparisons = compare_vector,
                         method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)
    muc_col <- generate_violin_plots(df_muc_col, int)+
      theme(plot.title = element_text(hjust = 0.5)) +
      ggtitle("MUC Col")+
      stat_compare_means(comparisons = compare_vector,
                         method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)
    ts_si <- generate_violin_plots(df_ts_si, int)+
      theme(plot.title = element_text(hjust = 0.5)) +
      ggtitle("TS SI")+
      stat_compare_means(comparisons = compare_vector,
                         method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)
    ts_col <- generate_violin_plots(df_ts_col, int)+
      theme(plot.title = element_text(hjust = 0.5)) +
      ggtitle("TS Col")+
      stat_compare_means(comparisons = compare_vector,
                         method="wilcox", vjust=0.5,label="p.signif",step.increase=0.08, hide.ns = TRUE)

    element_plots[[int]] <- cowplot::plot_grid(fp_col, fp_si,muc_col,muc_si, ts_col,ts_si, 
                                         rows = 3,cols=2)
    fp_col_plots[[int]] <- fp_col
    fp_si_plots[[int]] <- fp_si
    muc_col_plots[[int]] <- muc_col
    muc_si_plots[[int]] <- muc_si
    ts_col_plots[[int]] <- ts_col
    ts_si_plots[[int]] <- ts_si
}

#Iron 
dev.new(width=15, height=10)
element_plots[[1]]

#Cobalt
dev.new(width=15, height=10)
element_plots[[2]]

#Copper
dev.new(width=15, height=10)
element_plots[[3]]

#Zinc
dev.new(width=15, height=10)
element_plots[[4]]

#Cadmium
dev.new(width=15, height=10)
element_plots[[5]]

#Manganese
dev.new(width=15, height=10)
myplots[[6]]

#Selenium
dev.new(width=15, height=10)
myplots[[7]]

#FP COL
dev.new(width=15, height=10)
plot_grid(fp_col_plots[[1]],fp_col_plots[[2]],
          fp_col_plots[[3]],fp_col_plots[[4]],
          fp_col_plots[[5]],fp_col_plots[[6]],
          fp_col_plots[[7]],nrow = 2, ncol=4)

#FP SI
dev.new(width=15, height=10)
plot_grid(fp_si_plots[[1]],fp_si_plots[[2]],
          fp_si_plots[[3]],fp_si_plots[[4]],
          fp_si_plots[[5]],fp_si_plots[[6]],
          fp_si_plots[[7]],nrow = 2, ncol=4)

#MUC COL
dev.new(width=15, height=10)
plot_grid(muc_col_plots[[1]],muc_col_plots[[2]],
          muc_col_plots[[3]],muc_col_plots[[4]],
          muc_col_plots[[5]],muc_col_plots[[6]],
          muc_col_plots[[7]],nrow = 2, ncol=4)

#MUC SI
dev.new(width=15, height=10)
plot_grid(muc_si_plots[[1]],muc_si_plots[[2]],
          muc_si_plots[[3]],muc_si_plots[[4]],
          muc_si_plots[[5]],muc_si_plots[[6]],
          muc_si_plots[[7]],nrow = 2, ncol=4)

#TS COL
dev.new(width=15, height=10)
plot_grid(ts_col_plots[[1]],ts_col_plots[[2]],
          ts_col_plots[[3]],ts_col_plots[[4]],
          ts_col_plots[[5]],ts_col_plots[[6]],
          ts_col_plots[[7]],nrow = 2, ncol=4)

#TS SI
dev.new(width=15, height=10)
plot_grid(ts_si_plots[[1]],ts_si_plots[[2]],
          ts_si_plots[[3]],ts_si_plots[[4]],
          ts_si_plots[[5]],ts_si_plots[[6]],
          ts_si_plots[[7]],nrow = 2, ncol=4)

### Statistics --- 
element_stats_para <- list()
element_stats_nonpara <-list()


for (int in 1:7){
  print(int)
ts_si_para <- t.test(df_ts_si[,int]~Genotype,df_ts_si)
ts_si_nonpara <- wilcox.test(df_ts_si[,int]~Genotype,df_ts_si)
ts_col_para <- t.test(df_ts_col[,int]~Genotype,df_ts_col)
muc_si_para <- t.test(df_muc_si[,int]~Genotype,df_muc_si)
muc_si_nonpara <- wilcox.test(df_muc_si[,int]~Genotype,df_muc_si)
ts_col_nonpara <- wilcox.test(df_ts_col[,int]~Genotype,df_ts_col)
muc_col_para <- t.test(df_muc_col[,int]~Genotype,df_muc_col)
muc_col_nonpara <- wilcox.test(df_muc_col[,int]~Genotype,df_muc_col)
fp_si_para <- t.test(df_fp_si[,int]~Genotype,df_fp_si)
fp_si_nonpara <- wilcox.test(df_fp_si[,int]~Genotype,df_fp_si)
fp_col_para <- t.test(df_fp_col[,int]~Genotype,df_fp_col)
fp_col_nonpara <- wilcox.test(df_fp_col[,int]~Genotype,df_fp_col)

element_stats_para[[int]] <-list(print(fp_col_para), print(fp_si_para),print(muc_col_para),print(muc_si_para), print(ts_col_para),print(ts_si_para))
element_stats_nonpara[[int]] <-list(print(fp_col_nonpara), print(fp_si_nonpara),print(muc_col_nonpara),print(muc_si_nonpara), print(ts_col_nonpara),print(ts_si_nonpara))

}

names(df_ts_col)
# Iron 
element_stats_para[[1]]
element_stats_nonpara[[1]]

# Cobalt 
element_stats_para[[2]]
element_stats_nonpara[[2]]

# Copper
element_stats_para[[3]]
element_stats_nonpara[[3]]

# Zinc
element_stats_para[[4]]
element_stats_nonpara[[4]]

# Cadmium
element_stats_para[[5]]
element_stats_nonpara[[5]]

# Manganese
element_stats_para[[6]]
element_stats_nonpara[[6]]

# Selenium
element_stats_para[[7]]
element_stats_nonpara[[7]]