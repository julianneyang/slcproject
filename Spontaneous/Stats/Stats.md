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

#### FP output Stats
##### 5 minutes: WT vs MuT
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 36.5, p-value = 0.01769
alternative hypothesis: true location shift is not equal to 0
```
```R
Welch Two Sample t-test

data:  X5_min by Genotype
t = -3.101, df = 21.949, p-value = 0.005222
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -3.6923544 -0.7326456
sample estimates:
mean in group MUT  mean in group WT 
           0.6000            2.8125  
```

##### 5 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X5_min by Genotype
t = -3.764, df = 18.581, p-value = 0.001356
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.892287 -1.107713
sample estimates:
mean in group HET  mean in group WT 
           0.3125            2.8125 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 44.5, p-value = 0.000542
alternative hypothesis: true location shift is not equal to 0
```

##### 10 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X10_min by Genotype
t = -2.168, df = 22.975, p-value = 0.04077
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -3.88406088 -0.09093912
sample estimates:
mean in group MUT  mean in group WT 
           1.7000            3.6875 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X10_min by Genotype
W = 45.5, p-value = 0.06986
alternative hypothesis: true location shift is not equal to 0
```

##### 10 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X10_min by Genotype
t = -2.5021, df = 29.344, p-value = 0.01816
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.9746448 -0.4003552
sample estimates:
mean in group HET  mean in group WT 
           1.5000            3.6875 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X10_min by Genotype
W = 67, p-value = 0.01795
alternative hypothesis: true location shift is not equal to 0
```

##### 15 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X15_min by Genotype
t = -2.045, df = 22.2, p-value = 0.05289
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.00205721  0.02705721
sample estimates:
mean in group MUT  mean in group WT 
           2.2000            4.1875 
```

```R
Wilcoxon rank sum test with continuity correction

data:  X15_min by Genotype
W = 46, p-value = 0.07508
alternative hypothesis: true location shift is not equal to 0
```


##### 15 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X15_min by Genotype
t = -1.9846, df = 29.683, p-value = 0.0565
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.67854049  0.05354049
sample estimates:
mean in group HET  mean in group WT 
           2.3750            4.1875 

```
```R
Wilcoxon rank sum test with continuity correction

data:  X15_min by Genotype
W = 79, p-value = 0.06405
alternative hypothesis: true location shift is not equal to 0
```


#####30 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X30_min by Genotype
t = -1.5351, df = 19.093, p-value = 0.1412
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.6078464  0.7078464
sample estimates:
mean in group MUT  mean in group WT 
             3.30              5.25 

```

```R
Wilcoxon rank sum test with continuity correction

data:  X30_min by Genotype
W = 52.5, p-value = 0.1524
alternative hypothesis: true location shift is not equal to 0
```

##### 30 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X30_min by Genotype
t = -1.4516, df = 29.985, p-value = 0.157
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -3.9112307  0.6612307
sample estimates:
mean in group HET  mean in group WT 
            3.625             5.250 

```
```R
Wilcoxon rank sum test with continuity correction

data:  X30_min by Genotype
W = 90.5, p-value = 0.1603
alternative hypothesis: true location shift is not equal to 0

```

##### 45 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X45_min by Genotype
t = -1.1819, df = 20.22, p-value = 0.2509
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.732753  1.307753
sample estimates:
mean in group MUT  mean in group WT 
           4.6000            6.3125 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X45_min by Genotype
W = 58, p-value = 0.2555
alternative hypothesis: true location shift is not equal to 0
```


##### 45 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X45_min by Genotype
t = -1.4355, df = 29.947, p-value = 0.1615
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -4.6941008  0.8191008
sample estimates:
mean in group HET  mean in group WT 
           4.3750            6.3125 

```
```R

	Wilcoxon rank sum test with continuity correction

data:  X45_min by Genotype
W = 89, p-value = 0.1449
alternative hypothesis: true location shift is not equal to 0
```


##### 60 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X60_min by Genotype
t = -1.1642, df = 22.57, p-value = 0.2565
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -4.828013  1.353013
sample estimates:
mean in group MUT  mean in group WT 
           5.2000            6.9375 

```
```R
Wilcoxon rank sum test with continuity correction

data:  X60_min by Genotype
W = 62, p-value = 0.3538
alternative hypothesis: true location shift is not equal to 0
```


##### 60 minutes: WT vs HET

```R
Welch Two Sample t-test

data:  X60_min by Genotype
t = -1.4804, df = 29.973, p-value = 0.1492
alternative hypothesis: true difference in means between group HET and group WT is not equal to 0
95 percent confidence interval:
 -5.3540307  0.8540307
sample estimates:
mean in group HET  mean in group WT 
           4.6875            6.9375 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X60_min by Genotype
W = 86.5, p-value = 0.1206
alternative hypothesis: true location shift is not equal to 0
```

##### Females 5 minutes: WT vs MUT

```R
Welch Two Sample t-test

data:  X5_min by Genotype
t = -5.1393, df = 5.3172, p-value = 0.003053
alternative hypothesis: true difference in means between group MUT and group WT is not equal to 0
95 percent confidence interval:
 -6.249428 -2.131524
sample estimates:
mean in group MUT  mean in group WT 
        0.1428571         4.3333333 
```
```R
Wilcoxon rank sum test with continuity correction

data:  X5_min by Genotype
W = 0.5, p-value = 0.002535
alternative hypothesis: true location shift is not equal to 0

```
