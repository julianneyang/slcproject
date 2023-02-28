library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)

setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/SLC_GitHub/slcproject/PFF_Microbiome/")

## PFF Jejunum ---

input_data <- read.delim("starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Study =="PFF_Jejunum", SampleID %in% names(df_input_data)) %>% pull(SampleID)

df_input_data <- df_input_data[, samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)


df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("PICRUST2_PWY_Jejunum_Maaslin2__Sex_Genotype"), 
                    fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

## PFF Cecum ---

input_data <- read.delim("starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Study =="PFF_Cecum", SampleID %in% names(df_input_data)) %>% pull(SampleID)

df_input_data <- df_input_data[, samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)


df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("PICRUST2_PWY_Cecum_Maaslin2_Sex_Genotype"), 
                    fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

## PFF Colon---

input_data <- read.delim("starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Study =="PFF_Colon", SampleID %in% names(df_input_data)) %>% pull(SampleID)

df_input_data <- df_input_data[, samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)


df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("PICRUST2_Pathway_Colon_Maaslin2_Sex_Genotype"), 
                    fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

## PFF Baseline---

input_data <- read.delim("starting_files/picrust2_output_min10000_no_tax_PFF_ASV_table.qza/export_pathway_abundance/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Study =="PFF_Baseline", SampleID %in% names(df_input_data)) %>% pull(SampleID)

df_input_data <- df_input_data[, samples]

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)


df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("PICRUST2_PWY_Baseline_Maaslin2_Sex_Genotype"), 
                    fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

### Visualize MetaCyc results  ---

# Baseline  - 0 PWY 
data<-read.table("PICRUST2_PWY_Baseline_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.10)
data <- data %>% filter(metadata=="Genotype")

# Cecum - 0 PWY
data<-read.table("PICRUST2_PWY_Cecum_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.10)
data <- data %>% filter(metadata=="Genotype")

# Colon - 0 PWY
data<-read.table("PICRUST2_Pathway_Colon_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.10)
data <- data %>% filter(metadata=="Genotype")

# Jejunum - 0 PWY
data<-read.table("PICRUST2_PWY_Jejunum_Maaslin2__Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.10)
data <- data %>% filter(metadata=="Genotype")

