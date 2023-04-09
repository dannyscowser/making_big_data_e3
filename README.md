# LinkOrgs

An R package for linking datasets on organizations using the information contained in the half a billion open collaborated records from LinkedIn. 

## Installation

The most recent version of `LinkOrgs` can be installed directly from the repository using the `devtools` package

```
devtools::install_github("cjerzak/LinkOrgs-software/LinkOrgs")
```

The machine-learning based algorithm accessible via the `algorithm="ml"` option relies on `tensorflow` and `Rtensorflow`. For details about downloading, see `https://tensorflow.rstudio.com/installation/`. The network-based linkage approaches (`algorithm="bipartite"` and `algorithm = "markov"`) do not require these packages. 

Note that all options require Internet access in order to download the LinkedIn-based network information. 

## Walkthrough

After installing the package, let's get some experience with it in a simple example. 


```
# load in package 
library(LinkOrgs)

# set up synthetic data for the merge 
x_orgnames <- c("apple","oracle","enron inc.","mcdonalds corporation")
y_orgnames <- c("apple corp","oracle inc","enron","mcdonalds")
x <- data.frame("orgnames_x"=x_orgnames)
y <- data.frame("orgnames_y"=y_orgnames)
```
After creating these synthetic datasets, we're now ready to merge them! 

``` 
# perform merge using bipartite network approach
z_linked_bipartite <- LinkOrgs(x  = x, 
                     y =  y, 
                     by.x = "orgnames_x", 
                     by.y = "orgnames_y",
                     MaxDist = 0.6, 
                     algorithm = "bipartite", 
                     DistanceMeasure = "jaccard")
                     
# perform merge using markov network approach
z_linked_bipartite <- LinkOrgs(x  = x, 
                     y =  y, 
                     by.x = "orgnames_x", 
                     by.y = "orgnames_y",
                     MaxDist = 0.6, 
                     algorithm = "markov", 
                     DistanceMeasure = "jaccard")
                     
# perform merge using machine learning approach
z_linked_ml <- LinkOrgs(x  = x, 
                     y =  y, 
                     by.x = "orgnames_x", 
                     by.y = "orgnames_y",
                     AveMatchNumberPerAlias = 10, 
                     algorithm = "ml")
                     
# perform merge using combined network + machine learning approach
z_linked_ml <- LinkOrgs(x  = x, 
                     y =  y, 
                     by.x = "orgnames_x", 
                     by.y = "orgnames_y",
                     AveMatchNumberPerAlias = 10, 
                     AveMatchNumberPerAlias_network = 1, 
                     algorithm = "markov",
                     DistanceMeasure = "ml")
```
We also have a parallelized fast fuzzy matching implementation (see for details, see `?LinkOrgs::FastFuzzyMatch`). Using the package, we can also assess performance against a ground-truth merged dataset (if available): 
``` 
# (After running the above code)
z_true <- data.frame("orgnames_x"=x_orgnames, "orgnames_y"=y_orgnames)

# Get performance matrix 
PerformanceMatrix <- AssessMatchPerformance(x  = x, 
                                            y =  y, 
                                            by.x = "orgnames_x", 
                                            by.y = "orgnames_y", 
                                            z = z_linked, 
                                            z_true = z_true)
``` 

## Improvements
We're always looking to improve the software in terms of ease-of-use and its capabilities. If you have any suggestions/feedback, or need further assistance in getting the package working for your analysis, please don't hesitate to email Connor at <connor.jerzak@gmail.com>.

## Acknowledgments
We thank Gary King, Kosuke Imai, Xiang Zhou, and members of the Imai Research Workshop for valuable feedback on this research project. We also would like to thank Gil Tamir and Xiaolong Yang for excellent research assistance. 

## License

Creative Commons Attribution-Noncommercial-No Derivative Works 4.0, for academic use only.

## References 

Brian Libgober, Connor T. Jerzak. "Linking Datasets on Organizations Using Half A Billion Open Collaborated Records." *ArXiv Preprint*, 2023.
[arxiv.org/pdf/2302.02533.pdf](https://arxiv.org/pdf/2302.02533.pdf)
