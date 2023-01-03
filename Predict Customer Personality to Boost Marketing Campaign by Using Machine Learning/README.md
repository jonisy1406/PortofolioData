# Predict Customer Personality to Boost Marketing Campaign by Using Machine Learning
## Background
A company can develop rapidly when it knows its customers' personalities and behaviors, so it can provide better services and benefits to customers who have the potential to become loyal customers. Our focus is to create a cluster prediction model to make it easier for companies to make decisions by processing historical marketing campaign data to improve performance and target the right customers so they can transact on the company's platform.  
## Goal
Enhance the effectiveness of marketing initiatives and target the appropriate customers to encourage them to transact on the company's platform.      
## Objective
Create a cluster prediction model using unsupervised learning to facilitate decision-making for businesses.
## Data
The data set contains behavior features of customers who's made transaction and interaction in our platform. There are 2240 rows and 30 columns, and there is no data duplicate.

## Stages
The project will go through several stages as follows:

1. Exploratory Data Analysis : such as Correlation, Distribution and statistika descriptice
2. Insights : generate some insight from the data
3. Data Preprocessing : feature selection using LRFMC methods, Handling outliers, Feature transformation and feature scaling using standarization.  
4. Modeling   : Using K-Means
5. Cluster Interpretation  
6. Business Strategy Recomendations  

## Results     
![alt text](/Predict%Customer%Personality%to%Boost%Marketing%Campaign%by%Using%Machine%Learning/images/pca.png)   

Based on model, there are 4 customer clusters:  
**Interpretasi Clusters**  
* Cluster 0  
Cluster 0 is a group of customers with an average age of 65 years, an average of many transactions or purchases, and also a cluster with a fairly high total spent. The average customer is neither a new nor an old customer, but rather somewhere in the middle. In addition to the recency, this cluster has an averagely short purchase distance from the last purchase. These clusters are referred to as "Potential Loyalists".  
* Cluster 1   
Cluster 1 is a cluster with an average age of 51 years, average newcomers, small average transactions, a small total spent, and making purchases from the last purchase over a long period of time. This cluster can be referred to as "Hibernating".
* Cluster 2  
Cluster 2 is a cluster with an average age of 46 years. This cluster is the cluster with the most average purchases and total spent. From the perspective of recency, this cluster includes those that make purchases from the last purchase at a considerable distance. In addition, the average cluster consists of old customers. These clusters are referred to as "Can't Lose Them".   
* Cluster 3  
Cluster 3 is a cluster with an average age of 48 years and consists of an average number of new customers. This cluster is the cluster with the smallest average recency, meaning that this cluster makes purchases from the last purchase with an average adjacent time distance. Nevertheless, this cluster is the one with the least number of purchases and the lowest total spent. These clusters are referred to as "Promising."       

![alt text](/Predict%Customer%Personality%to%Boost%Marketing%Campaign%by%Using%Machine%Learning/images/boxenplot.png)      

## Business Strategy Recomendations
1. Loyalist Potential Cluster     
Because the customers in this cluster are clusters that make quite a lot of purchases, the total amount of money spent is also quite large. So in this cluster, customers can be given loyalty programs such as discounts. Furthermore, because customers in this cluster have a short distance to the next purchase, they can offer products to this cluster in order to increase recency activities.   
2. Promising Cluster    
Because the customers in this cluster are clusters of new entrants and make quite small purchases, the strategy that can be applied is to provide opportunities such as offers so that these customers are interested in making purchases (brand awareness).
3. Can't Lose Them Cluster    
This cluster purchases the most products, and the total amount spent is also substantial. Customers in this cluster are the most potential customers and provide high profits. In addition, the number of customers in this cluster is also the largest. However, customers in this cluster make purchases after the purchase is quite far away.Therefore, the strategy that can be done is to contact and provide offers to this cluster so that it can attract them to make purchases that can be in the form of products that suit most of the ages in this cluster and also provide discounts.   
4. Hibernating Cluster   
This cluster contains small purchases and total money spent. In addition, the distance from the last purchase to the next purchase is also far. The strategy that can be implemented is to provide special offers and products that are relevant to the customers in this cluster (according to the age of the customers in this cluster).   

!['alt text'](https://github.com/jonisy1406/PortofolioData/tree/master/Predict%20Customer%20Personality%20to%20Boost%20Marketing%20Campaign%20by%20Using%20Machine%20Learning/images/barplot.png)   
Of the above strategies, two clusters that can be prioritized are "potential loyalists" and "can't lose them". These two clusters make the most purchases and spend the most money in total. With the total customers of these two clusters being more than 55% of the total customers and the total spent being more than 80%, these two clusters can be used as the main focus. The potential impact of focusing on these two clusters is that we will obtain a GMV of IDR 566 million from the Potential Loyalist cluster and IDR 679 million from the Can't Lose Them cluster.  




