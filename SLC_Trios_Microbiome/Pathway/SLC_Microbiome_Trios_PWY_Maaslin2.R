library(Maaslin2)
library(funrar)
library(dplyr)
library(ggplot2)
library(cowplot)
library(plyr)

setwd("/Users/rochellelai/Box Sync/JacobsLab/slcproject/SLC_Microbiome_Trios_RL/Pathway")

## Luminal Colon

input_data <- read.delim("feature-table.tsv", header=TRUE, row.names=1) # choose filtered non rarefied csv file
df_input_data <- as.data.frame(input_data)
df_input_data <- select(df_input_data, -c("taxonomy"))

input_metadata <-read.delim("SLC_TOTAL_OCT2020_FULL_Metadata.tsv",sep="\t",header=TRUE, row.names=1)
input_metadata$SampleID <- row.names(input_metadata)

samples <- input_metadata %>% filter(Subset =="Luminal_Colon", SampleID %in% names(df_input_data)) %>% pull(SampleID)

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
                    output = paste0("PICRUST2_PWY_Luminal_Colon_Maaslin2_Sex_Genotype_Sequencing_Run"), 
                    fixed_effects = c("Sex", "Genotype", "Sequencing_Run"), normalization = "TSS", 
                    random_effects = "MouseID",
                    reference = "Genotype,WT", 
                    min_prevalence = 0.15,
                    transform ="log",plot_heatmap = FALSE,plot_scatter = FALSE)

### Visualize MetaCyc results

## Baseline WT vs MUT
data<-read.table("PICRUST2_PWY_Luminal_Colon_Maaslin2_Sex_Genotype_Sequencing_Run/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.10)
data <- data %>% filter(metadata=="Genotype")
annotation <- read.delim("annotated_pwy.tsv", row.names=1)
annotation$feature <- row.names(annotation)
annotation <- annotation %>% select(c("feature","description"))
annotation$feature <- gsub("-", ".", annotation$feature)
data <- merge(data,annotation, by="feature")

res_plot <- data %>% filter(value=="MUT")
res_plot <- unique(res_plot)
res_plot <- res_plot %>%
  mutate(site = ifelse(coef< 0, "WT", "MUT"))

y = tapply(res_plot$coef, res_plot$description, function(y) mean(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
res_plot$description= factor(as.character(res_plot$description), levels = names(y))

cols <- c("WT"="black", "HET"="blue", "MUT"="firebrick")
pwy_mut <- res_plot %>%
  arrange(coef) %>%
  filter(qval < 0.10, abs(coef) > 0) %>%
  ggplot2::ggplot(aes(coef, description, fill = site)) +
  geom_bar(stat = "identity") +
  cowplot::theme_cowplot(16) +
  theme(axis.text.y = element_text(face = "bold")) +
  scale_fill_manual(values = cols) +
  labs(x = "Effect size (MUT/WT)",
       y = "",
       fill = "") +
  theme(legend.position = "none")+
  ggtitle("Luminal Colon: WT vs MUT: PWY data") +
  theme(plot.title = element_text(hjust = 0.5))
pwy_mut

# Save plot
ggsave("SLC_Microbiome_Trios_PWY_Luminal_Colon_WTvsMUT.png", pwy_mut, width = 12.6, height = 9)

## Baseline WT vs HET
data<-read.table("PICRUST2_PWY_Luminal_Colon_Maaslin2_Sex_Genotype_Sequencing_Run/significant_results.tsv", header=TRUE)
data <- data %>% filter(qval <0.10)
data <- data %>% filter(metadata=="Genotype")
annotation <- read.delim("annotated_pwy.tsv", row.names=1)
annotation$feature <- row.names(annotation)
annotation <- annotation %>% select(c("feature","description"))
annotation$feature <- gsub("-", ".", annotation$feature)
data <- merge(data,annotation, by="feature")

res_plot <- data %>% filter(value=="HET")
res_plot <- unique(res_plot)
res_plot <- res_plot %>%
  mutate(site = ifelse(coef< 0, "WT", "HET"))

y = tapply(res_plot$coef, res_plot$description, function(y) mean(y))  # orders the genera by the highest fold change of any ASV in the genus; can change max(y) to mean(y) if you want to order genera by the average log2 fold change
y = sort(y, FALSE)   #switch to TRUE to reverse direction
res_plot$description= factor(as.character(res_plot$description), levels = names(y))

cols <- c("WT"="black", "HET"="blue", "MUT"="firebrick")
pwy_het <- res_plot %>%
  arrange(coef) %>%
  filter(qval < 0.10, abs(coef) > 0) %>%
  ggplot2::ggplot(aes(coef, description, fill = site)) +
  geom_bar(stat = "identity") +
  cowplot::theme_cowplot(16) +
  theme(axis.text.y = element_text(face = "bold")) +
  scale_fill_manual(values = cols) +
  labs(x = "Effect size (HET/WT)",
       y = "",
       fill = "") +
  theme(legend.position = "none")+
  ggtitle("Luminal Colon: WT vs HET: PWY data") +
  theme(plot.title = element_text(hjust = 0.5))
pwy_het

# Save plot
ggsave("SLC_Microbiome_Trios_PWY_Luminal_Colon_WTvsHET.png", pwy_het, width = 12.6, height = 9)
