# Data-analysis-techniques-in-R

## Goal: 
To study the factors that can determine technological progress, I used a sample of 114 countries, capturing the evolution of 10 indicators during 2018. The data is  studied through Principal Component Analysis, Factorial Analysis and diverse methods of Cluestering. The factors considered are:

+ Exports of medium and high technology (% exports of manufactured goods)
+ Urban population (% of total population)
+ Fees for use of intellectual property, payments (BoP, current USD)
+ Trademark applications, total
+ Scientific and technical journal articles
+ GDP (updated US dollars)
+ Added value of medium and high technology production (% added value of production)
+ Communication, informatics, etc. (% of service imports, BdP)
+ Access to electricity (% of the population)
+ Internet security servers

## Principal Component Analysis
<strong>Correlation matrix:</strong> In orther to begin ACP, it is neccesary to consider the the correlation between variables. The correlation matrix captures the strength of the links between the indicators, as well as their sign. It is observed, for example, that between GDP and the amount of scientific publications in a country there is a very strong connection of a positive nature, which means that scientific studies and the phenomenon of their popularization are also reflected in the well-being of a country. This data is good for ACP.
![222461471-d5b9e94e-5419-48a7-8855-75111fad0c0f](https://user-images.githubusercontent.com/101098099/222494312-c566c093-75f4-4d76-b70c-1d80177973c1.png)
![222461471-d5b9e94e-5419-48a7-8855-75111fad0c0f (1)](https://user-images.githubusercontent.com/101098099/222494852-91acec9e-8ee2-4238-8f91-8a96a6022f27.png)

<strong>Kaiser criterion: </strong> After applying ACP,the first principal component in the data set retains 49.34% of the information. The first two components retain a cumulative percentage of 63.09%. The first three components cumulatively retain 74.08% of the information, and I will continue with these three in my analysis according to the Kaiser criterion.

<strong>Kaiser criterion: </strong> 
