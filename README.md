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

### Other Visualization Methods

![Rplot02](https://user-images.githubusercontent.com/101098099/222758404-f8f212a4-3f10-495e-ad84-bd7ca50cb96c.png)

The graph above captures the positioning of the countries taking into account components 2 and 3. We notice that in the upper left are underdeveloped countries that are producing export technology such as Ethiopia, Angola, Kenya. The higher a country is on the left side of the graph, the more likely it is to be part of component 3. Countries on the right side of the graph are highly developed and have a large urban environment with internet access.

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/222754831-789c4625-ba17-4297-b17a-6fcfb2eadcd6.png">
</div>

In the representation above one can see the block of vectors from component 1, consisting of IntelectProp, Trademark, Journals, GDP, TechValue and InternetServers. These vectors, in addition to the approximate parallelism with the OX line denoting it belongs to component 1, are colored in shades of red and orange. According to the legend, this means that the named variables have a large contribution to component 1. Moreover, as written on the axis, together they form 54.7% of the total amount of information of the original data set.

## Factorial Analysis
## Clustering
