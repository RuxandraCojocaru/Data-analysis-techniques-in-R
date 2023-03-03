#Clustering methods

library(readxl)
library(ggplot2)
library(reshape2)
library(factoextra)
library(NbClust)
library(cluster)
library(MASS)
library(DiscriMiner)
library(e1071)
library(class)

proiect <- read_excel("D:/Ruxi/Facultate/GitHub/Data_analysis_R/NoOutliers.xlsx")

date<-proiect[,2:10]
date_std <- scale(date,scale=TRUE)
rownames(date_std)=proiect$Country

d_std = dist(as.matrix(date_std), method="euclidian")
d_std #matricea distantelor
d_std[1] #=d(Afghanistan,Angola)
date_std[1:2,]
d_euclid_2forme=sqrt((date_std[1,1]-date_std[2,1])^2+
                       (date_std[1,2]-date_std[2,2])^2+
                       (date_std[1,3]-date_std[2,3])^2+
                       (date_std[1,4]-date_std[2,4])^2+
                       (date_std[1,5]-date_std[2,5])^2+
                       (date_std[1,6]-date_std[2,6])^2+
                       (date_std[1,7]-date_std[2,7])^2+
                       (date_std[1,8]-date_std[2,8])^2+
                       (date_std[1,9]-date_std[2,9])^2)
d_euclid_2forme



m <- melt(as.matrix(d_std))
windows()
ggplot(data = m, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile() + 
  theme(axis.text.x = element_text(angle = 45)) +
  scale_fill_gradient(low="white", high="black")

#_____________Stabilirea numarului de clustere_________________
#Elbow
windows()
fviz_nbclust(date_std, hcut, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method - STD")
#Numarul optim de clustere din aplicarea metodei grafice e egal cu 4.


windows()
res<-NbClust(date_std, distance = "euclidean", min.nc=2, max.nc=4, 
             method = "ward.D2", index = "all")



#___________Clusterizare ierarhica - Metoda Ward_________________

clust_std = hclust(d_std, method = "ward.D2") # am grupat in 2, cu D2
cbind(clust_std$merge,clust_std$height) 

windows()
plot(clust_std,labels=rownames(date_std))
#dendrograma, ne spune grafic cum se grupeaza obiectele. 



si4_std <- silhouette(cutree(clust_std, k = 3), d_std)
windows()
plot(si4_std, cex.names = 0.5)
si4_std



centroizi_std <- tapply(as.matrix(date_std), list(rep(cutree(clust_std, 3), ncol(date_std)), col(date_std)), mean)
colnames(centroizi_std)=colnames(date_std)
round(centroizi_std,3)#coordonate

windows()
plot(clust_std,labels=rownames(date_std)) 



#_________________Alte metode de clusterizare________________________
# Tot ierarhice
#Metoda agregarii simple
windows()
clust2_std = hclust(d_std, method = "single") 
plot(clust2_std,labels=rownames(date_std))
rect.hclust(clust2_std,k=3, border=2:5)


#Metoda agregarii complete____________________________________________
windows()
clust3_std = hclust(d_std, method = "complete") 
plot(clust3_std,labels=rownames(date_std))
rect.hclust(clust2_std,k=3, border=2:5)


#Metoda agregarii medii_______________________________________________
windows()
clust4_std = hclust(d_std, method = "average") 
plot(clust4_std,labels=rownames(date_std))
rect.hclust(clust2_std,k=3, border=2:5)


#Metoda centroidului__________________________________________________
windows()
clust5_std = hclust(d_std, method = "centroid") 
plot(clust5_std,labels=rownames(date_std))
rect.hclust(clust2_std,k=3, border=2:5)


#__________________Algoritmul de clusterizare K Means_________________

k_std=kmeans(date_std,3) #K=3 clase
k_std
# cluster 3 = verde tari subdezvoltate ca Angola
# cluster 2 = albastru tari foarte dezvoltate
#cluster 1 = rosu tari normale

clasa_std=k_std$cluster
c_std=cbind(clasa_std,round(date_std,4))
c_std
m_std=data.frame(c_std)
windows()
plot(m_std[,3], m_std[,6], col=c("red","blue","green","black","magenta","yellow")
     [m_std$clasa_std], main="Reprezentarea claselor", xlab=colnames(m_std[3]), ylab=colnames(m_std[6]))
text(m_std[,3],m_std[,6],labels=rownames(m_std),col="magenta",pos=3,cex=0.7)



windows()
fviz_cluster(list(data = date_std, cluster = clasa_std))


# ____________Evaluarea variabilitatii intracluster si intercluster________________________
spat_std=k_std$totss           #variabilitatea totala
spaw_std=k_std$tot.withinss    #var. totala intracluster (intre obiecte din interiorul unui cluster), cat mai mica
spab_std=k_std$betweenss       #var tot interclasa (intre clustere), cat mai mare
r_cls_std=spab_std/spaw_std    #raportul var tot interclasa  si var tot intracluster 
variab_std=cbind(spat_std,spaw_std,spab_std,r_cls_std) 
variab_std

#____________Evaluarea puerii de discriminare a variabilelor______________________
library(psych)
library(ggplot2)

medii_std=data.frame(round(k_std$centers,3))
round(k_std$centers,3)
#Variabilele cu puterea de discriminarea cea mai mare sunt aceia cu centroizii cat mai diferiti de la o clasa la alta

describe(medii_std)
a=describe(medii_std)$min
b=describe(medii_std)$max
c1=t(medii_std[1,])
c2=t(medii_std[2,])
c3=t(medii_std[3,])
data=data.frame(c1,c2,c3,a,b)
rownames(data)=colnames(medii_std)
data
windows()
ggplot(data) +
  geom_segment( aes(x=rownames(data), xend=rownames(data), y=a, yend=b), color="black") +
  geom_point( aes(x=rownames(data), y=c1), color='red', size=5 ) +
  geom_point( aes(x=rownames(data), y=c2), color='blue', size=5 ) +
  geom_point( aes(x=rownames(data), y=c3), color='green', size=5 ) 




rez=rbind(round(discPower(c_std[,2:11], c_std[,1])$F_statistic,4),round(discPower(c_std[,2:11], c_std[,1])$p_value,4))
colnames(rez)=colnames(c_std[,2:11])
rownames(rez)=c("F_statistic","p-value")
rez
#constat ca toate cele 9 variabile detin capacitatea de a contribui la diferentierea obiectelor pe clase deoarece au o prob asociata testului f mai mica de 0.05 (pvalue)


# INVATARE SUPERVIZATA

date_std <- scale(date,scale=TRUE)
rownames(date_std)=proiect$Country


k=kmeans(date_std,3)
k

cls=k$cluster

set_date=cbind(date_std,cls) #am pus etichete cu clasa
df2=data.frame(set_date)
round(df2,3)

nr = round(nrow(df2)*.70) #pastrez 70% in testu de antrenare
a <- sample(seq_len(nrow(df2)), size = nr)

train <- df2[a, ]
test <- df2[-a, ]
round(train,3)
round(test,3)

df=data.frame(train)
df$cls[df$cls ==1] <- "clasa1"
df$cls[df$cls ==2] <- "clasa2"
df$cls[df$cls ==3] <- "clasa3"
cbind(round(df[,1:10],3),df[,11])


model  <- naiveBayes(as.factor(df[,11]) ~., data=df[,-11])
summary(model)
model$apriori 
model$tables
model$levels

pred <- predict(model, df[,-11], type="class")
pred
pred_2 <- predict(model, df[,-11], type="raw")
pred_2
table(pred, df[,11],dnn=c("Prediction","Actual"))


pred_test <- predict(model, test[,-11], type="class")
pred_test
pred_test2 <- predict(model, test[,-11], type="raw")
pred_test2
table(pred_test, test[,11],dnn=c("Prediction","Actual"))


#KNN

pr <- knn(train[,-11],test[,-11],cl=train[,11],k=3)
pr
pr2 <- knn(train[,-11],test[,-11],cl=train[,11],k=4)
pr2 

c1 <- table(pr,test[,11])
c1
c2 <- table(pr2,test[,11])
c2

acc <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
acc(c1)
acc(c2)
