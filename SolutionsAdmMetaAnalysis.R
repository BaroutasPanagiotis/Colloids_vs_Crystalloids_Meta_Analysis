##Import appropriate libraries
library(gridExtra)
library(meta)
library(dmetar)
library(metafor)
library(dplyr)
library(ggplot2)
library(readxl)

##Create a variable that contains the data set
Mortality_df = read_excel('28_days_mortality_df.xlsx')

##A quick view in type of variables and values
glimpse(Mortality_df)

##Create the meta-analysis model
meta_model = metabin(event.e = event.e, 
                     n.e = n.e,
                     event.c = event.c,
                     n.c = n.c,
                     studlab = Author,
                     data = Mortality_df,
                     sm = "RR",
                     method = "MH",
                     MH.exact = TRUE,
                     fixed = FALSE,
                     random = TRUE,
                     method.tau = "PM",
                     method.random.ci = "HK",
                     title = '28 days mortality pooled effect')
## This meta analysis model created by using metabin function for pooling effect sizes
##that deals with dichotomus outcomes and more precise with Relative Risk. As intervention
##event has defined the administration of colloids and compared to the administration
##of crystalloids. The summary measure is Relative Risk, the chosen method for calculating 
##study weights is the exact Mantel Haenszel without continuity correction because there
##are no zero cells in the contingency table when calculated the Relative Risk. Because we
##anticipated some degree of between-study heterogeneity it is used the random effect model
##for pooling the effect sizes. Because we expected some degree of heterogeneity and the number 
##of studies is low, it is used the Paule-Mandel method (Paule and Mandel 1982) to estimate the 
##between study heterogeneity tau squared with Knapp-Hartung adjustments  (Knapp and Hartung 2003)
##for standard error and confidence interval of pooled effect size.

summary(meta_model)
##The result of pooled effect size using random effects model gave a Risk Ratio of 1.01 indicating that the 
##experimental group of colloids had  1% higher mortality than the control group of crystalloids
##In other word the administration of colloid solutions during the septic shock in critically ill patient can 
##increase the mortality rate about 1% comparing the administration of crystalloid solutions. Nevertheless,
##the p-value is much greater than 0.05 (p=0.60) and the confidence interval ranges from 0.948 to 1.083 including
##the number 1. This means that it is not statistically significant and the result would be product of change.
##The I squared is 0. This means that 0% of variability in effect sizes is not caused by sampling error.
##So there is no between study heterogeneity (J. P. Higgins and Thompson 2002). Similar to I squared the 
##H statistic is 1 meaning that there is no difference between observed variation and expected variance 
##due to sampling error (J. P. Higgins and Thompson 2002). Q test (Cochran 1954) is equal to 1.22 indicating that the 
##there is a degree of variance in the observed effect sizes across the studies but the p-value is way 
##greater than 0.05 (p-value = 0.87) meaning it is not statistically significant. So the variability is not statistically
##significant and can be attributed to chance. The tau and tau-squared measures of heterogeneity quantification
##also is 0 indicating no heterogeneity between studies.
##Observing such a robust homogeneity in data set, it would be interesting to try calculate the pooled estimate using 
##fixed effect model

##Include prediction interval for future studies and fixed effect model
meta_model_fixed = update(meta_model,prediction = TRUE,fixed = TRUE, random = FALSE)

summary(meta_model_fixed)
##The prediction interval produced wider range of possible future effect sizes without giving more insights in 
##this meta analysis
##Fixed effect model gave a Relative Risk of 1.014, almost identical with random effect model (RR = 1.013).
##p-value equals 0.74 and CI ranges from 0.93 to 1.1 including the value 1. This indicates no statistical significance
##in model. As fixed effect model brings no significant change in pooled estimate we carry on with random effect model.



##In this meta analysis seems that that there is no heterogeneity between studies. Although it is not necessary, we 
##could make the result more robust by checking for outliers and influential cases

##Check for outliers
find.outliers(meta_model)
##The result shows no outliers detected. The same we would be indicate if we check the confidence interval of each study

##Influential analysis
meta_model_inf = InfluenceAnalysis(meta_model)
meta_model_inf
##It seems like McIntyre L., et. all. 2008 and Perner A., et. all. 2012 influence more this meta analysis but their values
##bring no concern

##Visualizing the cases
plot(meta_model_inf,'baujat')
##In baujat plot we can see visually these two studies 

##Plot diagnostics
plot(meta_model_inf,'influence')

##Create forest plots
forest = meta::forest(meta_model,
                      sortvar = TE,
                      comb.random = T,
                      text.random = 'Random effects model',
                      prediction = T,
                      label.e = 'Colloids',
                      label.c = 'Crystalloids',
                      smlab = 'Relative Risk',
                      leftlabs = c("Author", "g", "SE"),
                      rightlabs = c('RR', '95%-CI','Weight')
)

forest_fixed = meta::forest(meta_model_fixed,
                            sortvar = TE,
                            comb.random = F,
                            comb.fixed = T,
                            text.fixed = "Fixed effect model",
                            prediction = T,
                            label.e = 'Colloids',
                            label.c = 'Crystalloids',
                            smlab = 'Relative Risk',
                            leftlabs = c("Author", "g", "SE"),
                            rightlabs = c('RR', '95%-CI','Weight')
)

##Check for publication bias
##Produce funnel plot for small-study effects
meta::funnel(meta_model,
             studlab = TRUE)

##Add title
title("Funnel Plot (28 dasy mortality)")
##Overall the data seems to be symmetrical. Most studies are concentrated in the middle of the plot where
##the effect size is average. This means there is no publication bias in our data. One minor exception is
##McIntyre L., et. all. 2008 that does not follow the same pattern.
##Now lets check for asymmetry quantitatively.

##Perform Egger's test
eggers= metabias(meta_model, method.bias = "linreg",k.min = 5)
eggers
##Result shows there is not significant deviation from 0 (Bias estimate: 0.4709, SE = 0.6034) this means there is 
##no asymmetry in our data. Nevertheless, p_value is greater than 0.05 and the result is not statistical significant.
##This may occur due to very small sample size.

