Welch Two Sample t-test

data:  Total_Time by ASO_Tg
t = 0.30437, df = 31.588, p-value = 0.7628
alternative hypothesis: true difference in means between group Negative 
and group Positive is not equal to 0
95 percent confidence interval:
 -115.2326  155.6948
sample estimates:
mean in group Negative mean in group Positive 
              497.0072               476.7761

Wilcoxon rank sum test with continuity correction

data:  Total_Time by ASO_Tg
W = 182, p-value = 0.5372
alternative hypothesis: true location shift is not equal to 0

#### GI Motility Stats
```R
output=lme(fixed= FP_output ~ ASO_Tg, random = ~1|MouseID, data=longdata)
Linear mixed-effects model fit by REML
  Data: longdata 
       AIC      BIC    logLik
  1087.199 1100.663 -539.5995

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.931196 2.464376

Fixed effects:  FP_output ~ ASO_Tg 
                   Value Std.Error  DF   t-value p-value
(Intercept)     6.529412 0.7516296 180  8.687007  0.0000
ASO_TgPositive -1.204850 1.0346139  34 -1.164541  0.2523
 Correlation: 
               (Intr)
ASO_TgPositive -0.726

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-3.36487500 -0.52124790  0.02523948  0.47014143  3.09216791 

Number of Observations: 216
Number of Groups: 36 
```

```R
output=lme(fixed= FP_output ~ ASO_Tg + Sex, random = ~1|MouseID, 
data=longdata)

Linear mixed-effects model fit by REML
  Data: longdata 
       AIC      BIC    logLik
  1086.938 1103.745 -538.4691

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.963356 2.464376

Fixed effects:  FP_output ~ ASO_Tg + Sex 
                   Value Std.Error  DF   t-value p-value
(Intercept)     6.206004 0.9391692 180  6.607972  0.0000
ASO_TgPositive -1.170807 1.0463961  33 -1.118895  0.2713
SexMale         0.610881 1.0447800  33  0.584698  0.5627
 Correlation: 
               (Intr) ASO_TP
ASO_TgPositive -0.619       
SexMale        -0.589  0.056

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-3.37856240 -0.50283152  0.01471961  0.47863579  3.10216823 

Number of Observations: 216
Number of Groups: 36 
```

```R
output=lme(fixed= FP_output ~ ASO_Tg + Genotype, random = ~1|MouseID, 
data=longdata)

Linear mixed-effects model fit by REML
  Data: longdata 
       AIC      BIC    logLik
  1081.505 1101.645 -534.7525

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.808369 2.464376

Fixed effects:  FP_output ~ ASO_Tg + Genotype 
                   Value Std.Error  DF    t-value p-value
(Intercept)     4.066124  1.473376 180  2.7597333  0.0064
ASO_TgPositive -0.721318  1.042182  32 -0.6921234  0.4939
GenotypeHET     2.911256  1.470916  32  1.9792121  0.0565
GenotypeMUT     1.118308  1.822676  32  0.6135527  0.5438
 Correlation: 
               (Intr) ASO_TP GntHET
ASO_TgPositive -0.424              
GenotypeHET    -0.869  0.113       
GenotypeMUT    -0.606 -0.133  0.649

Standardized Within-Group Residuals:
        Min          Q1         Med          Q3         Max 
-3.37887441 -0.54424529  0.05688617  0.48534989  3.08607350 

Number of Observations: 216
Number of Groups: 36
```

```R
output=lme(fixed= FP_output ~ ASO_Tg + Sex + Genotype, random = 
~1|MouseID, data=longdata)

Linear mixed-effects model fit by REML
  Data: longdata 
       AIC      BIC   logLik
  1081.396 1104.859 -533.698

Random effects:
 Formula: ~1 | MouseID
        (Intercept) Residual
StdDev:    2.850116 2.464376

Fixed effects:  FP_output ~ ASO_Tg + Sex + Genotype 
                   Value Std.Error  DF    t-value p-value
(Intercept)     3.809524  1.615581 180  2.3579907  0.0194
ASO_TgPositive -0.732385  1.056259  31 -0.6933759  0.4932
SexMale         0.438734  1.056259  31  0.4153657  0.6807
GenotypeHET     2.927034  1.490795  31  1.9634046  0.0586
GenotypeMUT     1.311008  1.904091  31  0.6885215  0.4962
 Correlation: 
               (Intr) ASO_TP SexMal GntHET
ASO_TgPositive -0.382                     
SexMale        -0.382 -0.025              
GenotypeHET    -0.813  0.113  0.025       
GenotypeMUT    -0.636 -0.136  0.244  0.635

Standardized Within-Group Residuals:
       Min         Q1        Med         Q3        Max 
-3.3895898 -0.5434264  0.0668631  0.4726454  3.0922990 

Number of Observations: 216
Number of Groups: 36 
```
