# Stochastic-Models
Usefull models simulating stochastic processes in different times scales with or without reproduction of long-term percistence (Hurst-Kolmogorov behaviour). Also a simple tool for determening the Hurst coefficient is provided. 
All code is in the form of Matlab functions

# Usage Notes
The models presented below are not and should not be seen as a black box. Please familiarise with the psysical notions prior to using them. The documentaion listed will help you get started. Please read the instructions before using the functions.

# Climacogram(Tseries)
This function creates a climacogram (the plot of the natural logarithm of standard deviation vs the natural logarithm of scale) and calculates an estimation oh the Hurst coefficient, which is displayed in the plot and given as an export value of the function. As an empirical rule the std is calculated only through the scale with data length of 10% of the original data. This might need adjustement according to the problem. 

Input Arguments:

Tseries: The historic time series

For documentation see P. Dimitriadis, and D. Koutsoyiannis, Climacogram versus autocovariance and power spectrum in stochastic modelling for Markovian and Hurst–Kolmogorov processes, Stochastic Environmental Research & Risk Assessment, 29 (6), 1649–1669, 2015.

# Statisticall distributions 
In all functions listed below the random numbers generated using the Pareto distribution, as it can be shown that it maximizes entropy production and thus it can be seen as the appropriate choice when modelling natural processes. Third order statistics are reproduced in all models. For documentaion see D. Koutsoyiannis, Entropy: from thermodynamics to hydrology, Entropy, 16 (3), 1287–1314, 2014.

# AR1(Tseries,ye,n)
This function simulates a Markovian process. 

Input Arguments:

Tseries= The historic time series that you want to reproduce 

ye= The disired length (years) of the synthetic time series

n= the number of the synthetic time series

# PAR1(Tseries,ye,n)
This function simulates a Markovian cyclostationary process. In this models there are considered two time scale, annual and monthly. However depending on the problem the smaller time scale can be easily changed.

Input Arguments: Same as the AR1

# SMA(Tseries,ye,n,H)
This function simulates simple scaling behavior. It uses a Symmetric Moving Average model developed by prof. Demetris Koutsoyiannis. 

Input Arguments:

Tseries= The historic time series that you want to reproduce 

ye= The disired length (years) of the synthetic time series

n= the number of the synthetic time series

H= The Hurst coefficient 

For documentation see Koutsoyiannis, D., 2000. A generalized mathematical framework for stochastic simulation and forecast of hydrologic time series. Water Resources Resarch 36 (6), 1519–1534. 

# PARSMAF(Tseries,ye,n,H)
This function simulates simple scaling behavior in monthly scale. It uses the PAR1 model with a SMA filter and it was developed by Andreas Langousis and Demetris Koutsoyiannis. 

Input Arguments: Same as SMA

For documentation see A. Langousis, and D. Koutsoyiannis, A stochastic methodology for generation of seasonal time series reproducing overyear scaling behaviour, Journal of Hydrology, 322, 138–154, 2006.
