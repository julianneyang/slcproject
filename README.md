# slcspontaneous
scripts used for slc spontaneous project 

###this is an alteration
<<<<<<< HEAD
im jacob
=======


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

#### Open Field Stats
##### Center Time
###### WT vs MUT
```R
Welch Two Sample t-test

data:  Center_Time by Genotype
t = -0.71663, df = 18.752, p-value = 0.4824
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -91.27853  44.74671
sample estimates:
mean in group MUT  mean in group WT 
         238.8091          262.0750 
```

```R
Wilcoxon rank sum test with continuity correction

data:  Center_Time by Genotype
W = 76, p-value = 0.5703
alternative hypothesis: true location shift is not equal to 0
```
###### WT vs HET
```R
Welch Two Sample t-test

data:  Center_Time by Genotype
t = 0.20709, df = 27.173, p-value = 0.8375
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -57.93672  70.94922
sample estimates:
mean in group HET  mean in group WT 
         268.5813          262.0750 
```

```R
Wilcoxon rank sum exact test

data:  Center_Time by Genotype
W = 131, p-value = 0.926
alternative hypothesis: true location shift is not equal to 0
```

##### Distance
###### WT vs MUT
```R
Welch Two Sample t-test

data:  Distance by Genotype
t = -0.14523, df = 19.425, p-value = 0.886
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.816201  4.190349
sample estimates:
mean in group MUT  mean in group WT 
         15.21064          15.52356 
```

```R
Wilcoxon rank sum exact test

data:  Distance by Genotype
W = 87, p-value = 0.9807
alternative hypothesis: true location shift is not equal to 0
```

###### WT vs HET
```R
Welch Two Sample t-test

data:  Distance by Genotype
t = 0.21257, df = 28.763, p-value = 0.8332
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -2.953991  3.638991
sample estimates:
mean in group HET  mean in group WT 
         15.86606          15.52356 
```

```R
Wilcoxon rank sum exact test

data:  Distance by Genotype
W = 126, p-value = 0.9556
alternative hypothesis: true location shift is not equal to 0
```


>>>>>>> d33cb938d73839f744ec31701e1c25368311234c
