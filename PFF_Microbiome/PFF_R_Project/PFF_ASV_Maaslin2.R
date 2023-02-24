library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)
setwd("C:/Users/Jacobs Laboratory/Documents/JCYang/SLC_GitHub/slcproject/PFF_Microbiome/differential_taxa/")

### Note: First remove "#Constructed from biom file row"
### Run Maaslin2 and get table of relative abundances

run_Maaslin2 <- function(counts_filepath, metadata_filepath, subset_string) {
#input_data <- read.delim("export_s3_min10000_PFF_Baseline_min10000_no_tax_PFF_ASV_table/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
input_data <- read.delim(counts_filepath, header=TRUE, row.names=1) # choose filtered non rarefied csv file


df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

transposed_input_data <- t(df_input_data)
transposed_input_data <- as.matrix(transposed_input_data) #taxa are now columns, samples are rows. 
df_relative_ASV <- make_relative(transposed_input_data)
df_relative_ASV <- as.data.frame(df_relative_ASV)
Relative_Abundance <- summarize_all(df_relative_ASV, mean)
Relative_Abundance <- as.data.frame(t(Relative_Abundance))

readr::write_rds(Relative_Abundance,paste0("Relative_Abundance_",subset_string,"_ASV.RDS"))

input_metadata <-read.delim(metadata_filepath,sep="\t",header=TRUE, row.names=1)
#input_metadata <-read.delim("../starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)

target <- colnames(df_input_data)
input_metadata = input_metadata[match(target, row.names(input_metadata)),]
target == row.names(input_metadata)

df_input_metadata<-input_metadata
df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
df_input_metadata$Sex <- factor(df_input_metadata$Sex)
sapply(df_input_metadata,levels)

?Maaslin2
fit_data = Maaslin2(input_data=df_input_data, 
                    input_metadata=df_input_metadata, 
                    output = paste0("ASV-level_",subset_string,"_Maaslin2_Sex_Genotype"), 
                    fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                    min_prevalence = 0.14,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
}

run_Maaslin2_long <- function(counts_filepath, metadata_filepath, subset_string) {
  #input_data <- read.delim("export_s3_min10000_PFF_Baseline_min10000_no_tax_PFF_ASV_table/feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
  input_data <- read.delim(counts_filepath, header=TRUE, row.names=1) # choose filtered non rarefied csv file
  
  
  df_input_data <- as.data.frame(input_data)
  df_input_data <- select(df_input_data, -c("taxonomy"))
  
  transposed_input_data <- t(df_input_data)
  transposed_input_data <- as.matrix(transposed_input_data) #taxa are now columns, samples are rows. 
  df_relative_ASV <- make_relative(transposed_input_data)
  df_relative_ASV <- as.data.frame(df_relative_ASV)
  Relative_Abundance <- summarize_all(df_relative_ASV, mean)
  Relative_Abundance <- as.data.frame(t(Relative_Abundance))
  
  readr::write_rds(Relative_Abundance,paste0("Relative_Abundance_",subset_string,"_ASV.RDS"))
  
  input_metadata <-read.delim(metadata_filepath,sep="\t",header=TRUE, row.names=1)
  #input_metadata <-read.delim("../starting_files/PFF_Mapping.tsv",sep="\t",header=TRUE, row.names=1)
  
  target <- colnames(df_input_data)
  input_metadata = input_metadata[match(target, row.names(input_metadata)),]
  target == row.names(input_metadata)
  
  df_input_metadata<-input_metadata
  df_input_metadata$MouseID <- factor(df_input_metadata$MouseID)
  df_input_metadata$Genotype <- factor(df_input_metadata$Genotype, levels=c("WT","HET", "MUT"))
  df_input_metadata$Sex <- factor(df_input_metadata$Sex)
  sapply(df_input_metadata,levels)
  
  ?Maaslin2
  fit_data = Maaslin2(input_data=df_input_data, 
                      input_metadata=df_input_metadata, 
                      output = paste0("ASV-level_",subset_string,"_Maaslin2_Sex_Genotype"),
                      random_effects = c("MouseID"),
                      fixed_effects = c("Sex","Genotype"),normalization="TSS", 
                      min_prevalence = 0.14,
                      transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)
}

## Sex and Genotype

# Baseline
run_Maaslin2("export_s3_min10000_PFF_Baseline_min10000_no_tax_PFF_ASV_table/feature-table.tsv",
             "../starting_files/PFF_Mapping.tsv","PFF_Baseline")

# Jejunum 
run_Maaslin2("export_s5_min10000_PFF_Jejunum_min10000_no_tax_PFF_ASV_table/feature-table.tsv",
             "../starting_files/PFF_Mapping.tsv","PFF_Jejunum")

# Cecum  
run_Maaslin2("export_s5_min10000_PFF_Cecum_min10000_no_tax_PFF_ASV_table/feature-table.tsv",
             "../starting_files/PFF_Mapping.tsv","PFF_Cecum")

# Colon
run_Maaslin2("export_s5_min10000_PFF_Colon_min10000_no_tax_PFF_ASV_table/feature-table.tsv",
             "../starting_files/PFF_Mapping.tsv","PFF_Colon")

# Longitudinal
run_Maaslin2_long("export_s9_min10000_Yes_min10000_no_tax_PFF_ASV_table/feature-table.tsv",
             "../starting_files/PFF_Mapping.tsv","PFF_Longitudinal")

### Make a Dotplot: Sex and Diet  ---

phyla_colors <- c("#F8766D", "#A3A500", "#00BF7D", "#00B0F6", "#E76BF3")
names(phyla_colors)<-unique(data$Phylum)

#readr::write_rds(phyla_colors, "UCLA/phylacolors.RDS")

phyla_colors <- readRDS("UCLA/phylacolors.RDS")
phyla_colors <- c("Verrucomicrobia"="#F8766D", "Firmicutes"="purple",
                  "Bacteroidetes"= "#00BF7D", "Proteobacteria"="#00B0F6", "Actinobacteria"="#E76BF3")
# Baseline
data<-read.table("ASV-level_PFF_Baseline_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Genotype")
taxonomy <- read.csv("Taxonomy_Key.csv")
data <- merge(data,taxonomy, by="feature")
data$Phylum <- gsub(".*p__","",data$taxonomy)
data$Phylum <- gsub(";.*","",data$Phylum)
data$Family<- gsub(".*f__","",data$taxonomy)
data$Family <-  gsub(";.*","",data$Family)
data$Genus<- gsub(".*g__","",data$taxonomy)
data$Genus <-  gsub(";.*","",data$Genus)
data$Species <- gsub(".*s__","",data$taxonomy)
data$annotation <- paste0(data$Genus," ", data$Species)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(annotation = ifelse(data$Genus=="", paste(data$Family,"(f)"), data$annotation))

#append relative abundance data 
relA <- readRDS("Relative_Abundance_PFF_Baseline_ASV.RDS")
relA$feature <- row.names(relA)
relA$Relative_Abundance <- relA$V1
data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)

#make graph
y = tapply(data$coef, data$annotation, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$annotation= factor(as.character(data$annotation), levels = names(y))
baseline_DAT <- ggplot(data, aes(x = coef, y = annotation, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.3)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.001","0.01","0.1")) + 
  scale_color_manual(name="Phylum", values = phyla_colors)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(16) +
  ggtitle("Baseline: Sex + Genotype") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none") 

# Cecum - no significant DAT
data<-read.table("ASV-level_PFF_Cecum_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Genotype")

# Colon
data<-read.table("ASV-level_PFF_Colon_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Genotype")
taxonomy <- read.csv("Taxonomy_Key.csv")
data <- merge(data,taxonomy, by="feature")
data$Phylum <- gsub(".*p__","",data$taxonomy)
data$Phylum <- gsub(";.*","",data$Phylum)
data$Family<- gsub(".*f__","",data$taxonomy)
data$Family <-  gsub(";.*","",data$Family)
data$Genus<- gsub(".*g__","",data$taxonomy)
data$Genus <-  gsub(";.*","",data$Genus)
data$Species <- gsub(".*s__","",data$taxonomy)
data$annotation <- paste0(data$Genus," ", data$Species)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(annotation = ifelse(data$Genus=="", paste(data$Family,"(f)"), data$annotation))

#append relative abundance data 
relA <- readRDS("Relative_Abundance_PFF_Colon_ASV.RDS")
relA$feature <- row.names(relA)
relA$Relative_Abundance <- relA$V1
data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)

#make graph
y = tapply(data$coef, data$annotation, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$annotation= factor(as.character(data$annotation), levels = names(y))
colon_DAT <- ggplot(data, aes(x = coef, y = annotation, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.3)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.001","0.01","0.1")) + 
  scale_color_manual(name="Phylum", values = phyla_colors)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(16) +
  ggtitle("Colon: Sex + Genotype") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none") 


# Jejunum - 0 DAT 
data<-read.table("ASV-level_PFF_Jejunum_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Genotype")

# Longitudinal - 0 DAT 
data<-read.table("ASV-level_PFF_Longitudinal_Maaslin2_Sex_Genotype/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.05)
data <- data %>% filter(metadata=="Genotype")

taxonomy <- read.csv("Taxonomy_Key.csv")
data <- merge(data,taxonomy, by="feature")
data$Phylum <- gsub(".*p__","",data$taxonomy)
data$Phylum <- gsub(";.*","",data$Phylum)
data$Family<- gsub(".*f__","",data$taxonomy)
data$Family <-  gsub(";.*","",data$Family)
data$Genus<- gsub(".*g__","",data$taxonomy)
data$Genus <-  gsub(";.*","",data$Genus)
data$Species <- gsub(".*s__","",data$taxonomy)
data$annotation <- paste0(data$Genus," ", data$Species)
#data$Genus <- gsub("\\..*","",data$Genus)
data <- data %>% mutate(annotation = ifelse(data$Genus=="", paste(data$Family,"(f)"), data$annotation))

#append relative abundance data 
relA <- readRDS("Relative_Abundance_PFF_Longitudinal_ASV.RDS")
relA$feature <- row.names(relA)
relA$Relative_Abundance <- relA$V1
data<-merge(data,relA,by="feature")
min(data$Relative_Abundance)
max(data$Relative_Abundance)

#make graph
y = tapply(data$coef, data$annotation, function(y) max(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
data$annotation= factor(as.character(data$annotation), levels = names(y))
long_DAT <- ggplot(data, aes(x = coef, y = annotation, color = Phylum)) + 
  geom_point(aes(size = sqrt(Relative_Abundance))) + 
  scale_size_continuous(name="Relative Abundance",range = c(0.5,8),
                        limits=c(sqrt(0.0001),sqrt(0.3)),
                        breaks=c(sqrt(0.0001),sqrt(0.001),sqrt(0.01),sqrt(0.1)),
                        labels=c("0.0001","0.001","0.01","0.1")) + 
  scale_color_manual(name="Phylum", values = phyla_colors)+
  geom_vline(xintercept = 0) + 
  xlab(label="Log2 Fold Change")+
  ylab(label=NULL)+
  theme_cowplot(16) +
  ggtitle("Longitudinal Colon: Sex + Genotype + (1|MouseID)") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none") 


### Make Final Figure ---
plot_grid(baseline_DAT, colon_DAT, long_DAT,
          labels=c("A","B","C"))
