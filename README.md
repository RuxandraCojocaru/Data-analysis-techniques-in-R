# Data-analysis-techniques-in-R

## Goal: 
To study the factors that can determine technological progress, I used a sample of 114 countries, capturing the evolution of 10 indicators during 2018. The data is  studied through Principal Component Analysis, Factorial Analysis and diverse methods of Clustering. The factors considered are:

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
### Tests
<strong>The KMO test</strong> checks whether the partial correlations in the analyzed data are close enough to zero to suggest that there is at least one latent factor underlying the respective variables. The minimum acceptable value is 0.50, while I determined the KMO value of 0.819, which is higher and indicates that the factorability of the data is very good and the proposed analysis can continue.
<strong>The Bartlett test</strong> reaches a value of 768.86, which is higher than the value of the CHI^2 distribution (61.65). The obtained results indicate the rejection of the null hypothesis and the acceptance of the alternative hypothesis of the existence of at least one common factor. Factor analysis is justified on our data.


### Number of factors and Factor extraction 
+ Parallel analysis suggests that the number of factors =  2
+ <strong>Principal axis method </strong>with and without rotation is tested
+ <strong>Maximum likelihood method</strong> with and without rotation is also tested

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/222771430-8958d8df-f33e-47d7-aac8-1e7b984a9f5f.png">
</div>

From the four approaches used, the best result was obtained using the Maximum likelihood method with rotation. The factor ML1 explains 69% of the model, and ML2 31%. The components of each factor can be seen in the picture above.
RMSR (root mean square) has a value of 0.06, close to 0.
The Tucker Lewis Index is 0.905, which indicates a very good factorability of the data, much better than in the case of the pa model.
The RMSEA is 0.118, a value close to 0, suitable, indicating relatively good model accuracy.

## Clustering
### Number of clusters
The function NbClust suggested 3 as the optimal number of clusters. To make sure, I also checked the average silhouette obtained in the case of clustering with 3, 4 or 5 clusters. For 3 clusters, the average silhouette is 0.36, while for 4 clusters it is 0.35 and for 5 clusters it is 0.21. The average silhouette must be as large as possible, so the 3-cluster clustering variation is the optimal one.

### Methods applied
+ <strong>Ward method</strong>
+ <strong>Simple aggregation</strong>
+ <strong>Complete aggregation</strong>
+ <strong>Medium aggregation</strong>
+ <strong>Centroid method</strong>
+ <strong>K-means</strong>

![image](https://user-images.githubusercontent.com/101098099/222777675-12ac4ae7-946a-41e0-ae9e-6fb84b7fca21.png)

Through Ward method,the cluster identified on the left side of the dendrogram, framed in red, includes 15 countries, similar in that they are economically and technologically developed: Korea, Indonesia, Switzerland, Australia, Russia, Canada, Spain, Italy, Germany, Japan, France and England, as well as Brazil, Mexico and Turkey, countries that are likely to be among the technologically developed countries, but with the main function of exporters.
Cluster 3, containing only 10 countries of which all are underdeveloped, is boxed in green. Most of the countries in the data set fall into cluster 1, bordered in blue. These countries show an average level of economic and technological development.

![image](https://user-images.githubusercontent.com/101098099/222777301-a4e1d09f-b027-4bed-b66a-e69b7f8c5833.png)

Through K-Means,the top figure visually renders the composition of the clusters using two dimensions. Dimension 1 explains 49.3% of the variance of the data set and dimension 2 only 13.8%. The cluster of highly developed countries is illustrated on the right side of the figure in blue. On the other hand, we now have a clear picture of the components of the remaining clusters and the intracluster similarity of the countries that compose them. It seems that in red we have shown the cluster that contains the countries with a satisfactory, average level of technological development, such as Romania, Belgium, Israel, Turkey, Mexico, Belarus, etc. The nature of the elements in this cluster becomes even more evident when compared to the elements of the green cluster, where countries such as Angola, Nigeria, Ghana, Cambodia, Honduras, Tonga, Senegal, etc. show an unsatisfactory level of technological development, the countries of this last cluster can be categorized as underdeveloped.
