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
<strong>Standardization: </strong> To overcome the difficulties due to the different scaling of the data, I standardized the data and obtained a new set that does not show scaling irregularities and can be easily visualized.
<strong>Correlation matrix:</strong> In orther to begin ACP, it is neccesary to consider the the correlation between variables. The correlation matrix captures the strength of the links between the indicators, as well as their sign. It is observed, for example, that between GDP and the amount of scientific publications in a country there is a very strong connection of a positive nature, which means that scientific studies and the phenomenon of their popularization are also reflected in the well-being of a country. This data is good for ACP.

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/222495217-47c49d1b-b66b-4323-9922-29235ea7f42d.png">
</div>

<strong>Kaiser criterion: </strong> After applying ACP,the first principal component in the data set retains 49.34% of the information. The first two components retain a cumulative percentage of 63.09%. The first three components cumulatively retain 74.08% of the information, and I will continue with these three in my analysis according to the Kaiser criterion.

<strong>Kaiser criterion: </strong> <p>I graphically represented the connection between the indicators and the three main components retained in the analysis. The first principal component correlates very strongly with the IntelectProp, Trademark, Journals, GDP, TechValue and InternetServers indicators.
It can be interpreted as a component that gives us information about the level of technological and scientific development in a country.</p>
    <p>The second component correlates strongly with the variables UrbanPop and AccessElectricity, which refer to preconditions that enable technological advance. We will interpret this component as the infrastructure component.</p>
     <p>The third component is made up of Communications, ExportTech, but also UrbanPop, TechValue and Access Electricity. Due to the negative correlation of two indicators, the third component brings to mind the situation of underdeveloped countries where large companies operate to reduce personnel costs. Although there is industrial activity, the population is largely rural and access to the Internet is limited. We will call this component the exploitation component.</p>

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/222744680-3dba63ad-8504-4fc0-b08c-f9c0f58dc77c.png">
</div>

