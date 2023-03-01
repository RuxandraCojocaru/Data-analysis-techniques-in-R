#Analiza factoriala

library(readxl)
proiect <- read_excel("D:/Ruxi/Facultate/GitHub/Data_analysis_R/NoOutliers.xlsx")
date<-proiect[,2:11]
date_std=scale(date, scale = TRUE)
date_std=data.frame(date_std)

# Indicele KMO
R=cor(date_std)
invR <- solve(R)
A <- matrix(1,nrow(invR),ncol(invR))
for (i in 1:nrow(invR)){
  for (j in (i+1):ncol(invR)){
    A[i,j] <- invR[i,j]/sqrt(invR[i,i]*invR[j,j])
    A[j,i] <- A[i,j]
  }
} 
colnames(A) <- colnames(date_std)
rownames(A) <- colnames(date_std)
round(A,3)
kmo.num <- sum(R^2) - sum(diag(R^2))
kmo.denom <- kmo.num + (sum(A^2) - sum(diag(A^2)))
kmo <- kmo.num/kmo.denom
kmo

# Testul Barlet de sfericitate
functie_Bartlett<-function(date){ 
  R<-cor(date)
  p<-ncol(date)
  n<-nrow(date)
  chi2<- -((n-1)-((2*p)+5)/6 ) * log(det(R)) 
  df<-(p*(p-1)/2)      
  crit<-qchisq(.95,df) 
  p<-pchisq(chi2,df,lower.tail=F) 
  cat("Bartlett's test of sphericity: X2(",df,")=",chi2,", p=",
      round(p,6),sep="" )   
}
functie_Bartlett(date_std)
qchisq(0.05,45,lower.tail=F)

#Scree plots, Analiza paralela
scree(date_std) 
fa.parallel(date_std, show.legend = FALSE)  
fa.parallel(date_std) #2 factori


# Extragerea factorilor - Metoda axelor principale cu si fara rotatie 
install.packages("GPArotation")
library(GPArotation)

factori2 <- fa(date_std, nfactors =  2, rotate = "none", fm = "pa") #fara rotatie
print(factori2$loadings, cutoff = 0.4)
fa.diagram(factori2)
factori2 = fa(date_std, nfactors = 2, rotate = "Varimax", fm="pa") #cu rotatie
print(factori2, cutoff=0.4)
fa.diagram(factori2)
library(corrplot)
corrplot(factori2$loadings, method="circle")
factori2

# Extr factorilor - Met verosimilitatii maxinme(Maximum likelihood)
factori2 = fa(date_std, nfactors = 2, rotate = "none", fm="ml") #fara rotatie
print(factori2$loadings, cutoff = 0.4)
fa.diagram(factori2)

#Folosim metoda Varimax pt a imbunatati solutia
factori2 = fa(date_std, nfactors = 2, rotate = "Varimax", fm="ml")   #cu rotatie
print(factori2, cutoff = 0.4)
fa.diagram(factori2)
corrplot(factori2$loadings, method="circle")
factori2
