K-means clustering
------------------

Another simple way of examing and organizing multi-dimensional data. As with hierarchical clustering, this technique is most useful in the early stages of analysis when you're trying to get an understanding of the data, e.g., finding some pattern or relationship between different factors or variables.

R documentation tells us that the k-means method "aims to partition the points into k groups such that the sum of squares from points to the assigned cluster centres is minimized."

k-means is a partioning approach which requires that you first guess how many clusters you have (or want). Once you fix this number, you randomly create a "centroid" (a phantom point) for each cluster and assign each point or observation in your dataset to the centroid to which it is closest. Once each point is assigned a centroid, you readjust the centroid's position by making it the average of the points assigned to it.

Once you have repositioned the centroids, you must recalculate the distance of the observations to the centroids and reassign any, if necessary, to the centroid closest to them. Again, once the reassignments are done, readjust the positions of the centroids based on the new cluster membership. The process stops once you reach an iteration in which no adjustments are made or when you've reached some predetermined maximum number of iterations.

1.  Make a guess about the centroid
2.  Measure the distances and find the clusters
3.  Recalculate the centroids using mean of all x and y for each point
4.  Reassign clusters
5.  Recalculate centroids ... ...

### kmeans()

x, (the numeric matrix of data), centers, iter.max, and nstart. The second of these (centers) can be either a number of clusters or a set of initial centroids. The third, iter.max, specifies the maximum number of iterations to go through, and nstart is the number of random starts you want to try if you specify centers as a number.

``` r
dataFrame <- data.frame(matrix(c(0.7585869, 1.0554858, 1.2168882, 0.5308605, 2.0858249, 2.1012112,
                                 1.8850520, 1.8906736, 2.8871096, 2.8219924, 2.9045615, 2.8003227,
                                 0.8447492, 1.0128918, 1.1918988, 0.9779429, 1.8977981, 1.8177609,
                                 1.8325657, 2.4831670, 1.0268176, 0.9018628, 0.9118904, 1.0919179), 
                               12, 2))
x <- as.numeric(as.character(dataFrame$x))
y <- as.numeric(as.character(dataFrame$y))

kmObj <- kmeans(dataFrame, centers = 3)
kmObj
```

    ## K-means clustering with 3 clusters of sizes 4, 4, 4
    ## 
    ## Cluster means:
    ##          X1        X2
    ## 1 0.8904554 1.0068707
    ## 2 2.8534966 0.9831222
    ## 3 1.9906904 2.0078229
    ## 
    ## Clustering vector:
    ##  [1] 1 1 1 1 3 3 3 3 2 2 2 2
    ## 
    ## Within cluster sum of squares by cluster:
    ## [1] 0.34188305 0.03298029 0.34732437
    ##  (between_SS / total_SS =  93.6 %)
    ## 
    ## Available components:
    ## 
    ## [1] "cluster"      "centers"      "totss"        "withinss"    
    ## [5] "tot.withinss" "betweenss"    "size"         "iter"        
    ## [9] "ifault"

``` r
#plot(x, y, col=kmObj$cluster, pch=19, cex=2)
#points(kmObj$centers,col=c("black","red","green"),pch=3,cex=3,lwd=3)

# If too many clusters are selected, the clustering would change time by time
#plot(x, y, col = kmeans(dataFrame,6)$cluster, pch=19, cex=2)
```
