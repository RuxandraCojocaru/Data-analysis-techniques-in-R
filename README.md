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
+ Access to electricity (% of the population)
+ Internet security servers

## Principal Component Analysis
### Standardization:  
To overcome the difficulties due to the different scaling of the data, I standardized the data and obtained a new set that does not show scaling irregularities and can be easily visualized.

### Correlation matrix:
In orther to begin ACP, it is neccesary to consider the the correlation between variables. The correlation matrix captures the strength of the links between the indicators, as well as their sign. It is observed, for example, that between GDP and the amount of scientific publications in a country there is a very strong connection of a positive nature, which means that scientific studies and the phenomenon of their popularization are also reflected in the well-being of a country. This data is good for ACP.

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/222748510-fadc907c-3a0d-45fe-94a8-680905d37587.png">
    <img src="https://user-images.githubusercontent.com/101098099/222748279-4de6db15-5995-47b0-bd0b-952395641199.png">
</div>


### Kaiser criterion:
After applying ACP,the first principal component in the data set retains 49.18% of the information. The first two components retain a cumulative percentage of 62.59%. The first three components cumulatively retain 71.38% of the information, and I will continue with these three in my analysis according to the Kaiser criterion.

### Components resulted:  
I graphically represented the connection between the indicators and the three main components retained in the analysis. 
+ <strong>The first principal component</strong> correlates very strongly with the IntelectProp, Trademark, Journals, GDP, TechValue and InternetServers indicators.
It can be interpreted as a component that gives us information about the level of technological and scientific development in a country.
+ <strong>The second component</strong> correlates strongly with the variables UrbanPop and AccessElectricity, which refer to preconditions that enable technological advance. We will interpret this component as the infrastructure component.
+ <strong>The third component</strong> is made up of Communications, ExportTech, but also UrbanPop, TechValue and Access Electricity. Due to the negative correlation of two indicators, the third component brings to mind the situation of underdeveloped countries where large companies operate to reduce personnel costs. Although there is industrial activity, the population is largely rural and access to the Internet is limited. We will call this component the exploitation component.

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/222753874-3e6a96d1-c431-4a5d-8a5b-ae0f8b32a9ab.png">
    <img src="https://user-images.githubusercontent.com/101098099/222754273-554e2a5d-6c46-471b-b057-7d26b753d934.png">
</div>


