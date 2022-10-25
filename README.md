# slcspontaneous
scripts used for slc spontaneous project 

###this is an alteration


#### Body Weight Stats
##### WT vs MUT
```R
Welch Two Sample t-test

data:  Weight..g. by Genotype
t = -1.7597, df = 19.507, p-value = 0.09413
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -6.8381393  0.5856393
sample estimates:
mean in group MUT  mean in group WT 
         25.83000          28.95625 
```
```R
Wilcoxon rank sum test with continuity correction

data:  Weight..g. by Genotype
W = 56.5, p-value = 0.225
alternative hypothesis: true location shift is not equal to 0
```

##### WT vs HET
```R
Welch Two Sample t-test

data:  Weight..g. by Genotype
t = -0.96785, df = 27.39, p-value = 0.3416
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -4.119509  1.477598
sample estimates:
mean in group HET  mean in group WT 
         27.63529          28.95625 
```
```R
Wilcoxon rank sum test with continuity correction

data:  Weight..g. by Genotype
W = 112, p-value = 0.3972
alternative hypothesis: true location shift is not equal to 0
```
