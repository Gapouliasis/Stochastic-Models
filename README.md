# Stochastic-Models
Usefull models simulating stochastic processes in different time scales with or without reproduction of long-term persistence (Hurst-Kolmogorov behaviour). Also a simple tool for determining the Hurst coefficient is provided. Special thanks to my professor Demetris Koutsoyiannis for his tips on this project.
All code is in the form of Matlab functions

# Usage Notes
The models presented below are not and should not be seen as a black box. Please familiarise with the psysical notions prior to using them. The documentaion listed will help you get started. Please read the instructions before using the functions.

# Climacogram(Tseries)
This function creates a climacogram (the plot of the natural logarithm of standard deviation vs the natural logarithm of scale) and calculates an estimation of the Hurst coefficient, which is displayed in the plot and given as an export value of the function. This function does not include the bias correction. As an empirical rule the std is calculated only through the scale with data length of 10% of the original data. This might need adjustement according to the problem. 

Input Arguments:

Tseries: The historic time series

For documentation see P. Dimitriadis, and D. Koutsoyiannis, Climacogram versus autocovariance and power spectrum in stochastic modelling for Markovian and Hurst–Kolmogorov processes, Stochastic Environmental Research & Risk Assessment, 29 (6), 1649–1669, 2015.

# Statisticall distributions 
In all functions listed below the random numbers generated using the Pareto distribution, as it can be shown that it maximizes entropy when using as background measure the function h(z)=1/(p+z) and thus it can be seen as the appropriate choice when modelling natural processes. Third order statistics are reproduced in all models. For documentaion see D. Koutsoyiannis, Entropy: from thermodynamics to hydrology, Entropy, 16 (3), 1287–1314, 2014.

# AR1(Tseries,ye,n)
This function simulates a Markovian process. 

Input Arguments:

Tseries= The historic time series that you want to reproduce 

ye= The disired length (years) of the synthetic time series

n= the number of the synthetic time series

# PAR1(Tseries,ye,n)
This function simulates a Markovian cyclostationary process. In this models there are considered two time scale, annual and monthly. However depending on the problem the smaller time scale can be easily changed.

Input Arguments: Same as the AR1 except

Tseries= The historic time series given in a table where the rows represent the years and the columns repsresent the months

# SMA(Tseries,ye,n,H)
This function simulates simple scaling behavior. It uses a Symmetric Moving Average model developed by prof. Demetris Koutsoyiannis. 

Input Arguments:

Tseries= The historic time series that you want to reproduce 

ye= The disired length (years) of the synthetic time series

n= the number of the synthetic time series

H= The Hurst coefficient 

For documentation see D. Koutsoyiannis, The Hurst phenomenon and fractional Gaussian noise made easy, Hydrological Sciences Journal, 47 (4), 573–595, 2002.

# PARSMAF(Tseries,ye,n,H)
This function simulates simple scaling behavior in monthly scale. It uses the PAR1 model with a SMA filter and it was developed by Andreas Langousis and Demetris Koutsoyiannis. 

Input Arguments: Same as SMA except

Tseries= The historic time series given in a table where the rows represent the years and the columns repsresent the months

For documentation see A. Langousis, and D. Koutsoyiannis, A stochastic methodology for generation of seasonal time series reproducing overyear scaling behaviour, Journal of Hydrology, 322, 138–154, 2006.
