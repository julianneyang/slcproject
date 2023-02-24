Using DADA2 preprocessed dataset
"Study " signifies timepoint

## Longitudinal Colon
With repeated measures PERMANOVA
```R
Permutation: free
Number of permutations: 0

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2    Pr(>F)    
Sex        1    14.594  14.594  14.445 0.12069 9.999e-05 ***
Genotype   2     0.530   0.265   0.262 0.00438    0.9087    
Study      1    50.231  50.231  49.717 0.41539 9.999e-05 ***
Residuals 55    55.568   1.010         0.45953 9.999e-05 ***
Total     59   120.923                 1.00000              
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

## Baseline
### Sex  and Genotype
```R
> data.adonis=adonis(data.dist ~ Sex+ Genotype, data=metadata, permutations=10000)
'adonis' will be deprecated: use 'adonis2' instead
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)   
Sex        1     9.616  9.6161  5.6840 0.19853 0.0043 **
Genotype   2     4.984  2.4918  1.4729 0.10289 0.2320   
Residuals 20    33.835  1.6918         0.69857          
Total     23    48.435                 1.00000          
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

### Sex Genotype interaction
```R
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

             Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)   
Sex           1     9.616  9.6161  6.6688 0.19853 0.0024 **
Genotype      2     4.984  2.4918  1.7281 0.10289 0.1685   
Sex:Genotype  2     7.880  3.9402  2.7325 0.16270 0.0377 * 
Residuals    18    25.955  1.4420         0.53587          
Total        23    48.435                 1.00000          
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

## Jejunum
```R
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2    Pr(>F)    
Sex        1    18.193 18.1929 11.1470 0.26047 9.999e-05 ***
Genotype   2     2.691  1.3453  0.8243 0.03852    0.5223    
Residuals 30    48.963  1.6321         0.70101              
Total     33    69.846                 1.00000              
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
```R
> data.adonis$aov.tab
Permutation: free
Number of permutations: 10000

Terms added sequentially (first to last)

             Df SumsOfSqs MeanSqs F.Model      R2    Pr(>F)    
Sex           1    18.193 18.1929 11.3838 0.26047 9.999e-05 ***
Genotype      2     2.691  1.3453  0.8418 0.03852    0.5122    
Sex:Genotype  2     4.215  2.1073  1.3186 0.06034    0.2803    
Residuals    28    44.748  1.5982         0.64067              
Total        33    69.846                 1.00000              
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```