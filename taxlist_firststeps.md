# Quick start on taxlist
*Miguel Alvarez*

<br>

## Introduction
This is a guide for constructing `taxlist` objects via command lines.
For accessing this document from your **R console** use following command:


```r
browseURL("https://github.com/kamapu/Guides/blob/master/taxlist_firststeps.md")
```

To install the last version of `taxlist`, you can use the package `devtools`:


```r
library(devtools)

install_github("kamapu/taxlist")
```

## Starting with building blocks

I will take an example from "Helechos de Chile" **(Gunkel 1984)** to demonstrate
how to construct a `taxlist` object from its building blocks.
The first step will be to generate an empty `taxlist` object:


```r
library(taxlist)
```

```
## Loading required package: vegdata
```

```
## Loading required package: foreign
```

```
## This is vegdata 0.9
```

```
## This is taxlist 0.0.0.9014
```

```
## 
## Attaching package: 'taxlist'
```

```
## The following object is masked from 'package:base':
## 
##     levels
```

```r
Fern <- new("taxlist")
summary(Fern)
```

```
## object size: 4.9 Kb 
## validation of 'taxlist' object: TRUE 
## 
## number of names: 0 
## number of concepts: 0 
## trait entries: 0 
## reference entries: 0
```

As you can see, there is nothing in there.
We start including taxonomic levels, we like to insert in the list.
Remember, the levels have to be provided in an upward sequence, that is to say
from lower to higher levels:


```r
levels(Fern) <- c("variety","species","genus")
```
Then you can add a species:


```r
Fern <- add_concept(Fern, TaxonName="Asplenium obliquum", AuthorName="Forster",
	Level="species")
```

Then add varieties:


```r
Fern <- add_concept(Fern,
	TaxonName=c("Asplenium obliquum var. sphenoides",
		"Asplenium obliquum var. chondrophyllum"),
	AuthorName=c("(Kunze) Espinosa",
		"(Bertero apud Colla) C. Christense & C. Skottsberg"),
	Level="variety")
```

Finally add the genus and check the object:


```r
Fern <- add_concept(Fern, TaxonName="Asplenium", AuthorName="L.", Level="genus")
summary(Fern)
```

```
## object size: 5.8 Kb 
## validation of 'taxlist' object: TRUE 
## 
## number of names: 4 
## number of concepts: 4 
## trait entries: 0 
## reference entries: 0 
## 
## hierarchical levels: variety < species < genus 
## number of concepts in level variety: 2
## number of concepts in level species: 1
## number of concepts in level genus: 1
```

```r
summary(Fern, "all")
```

```
## ------------------------------ 
## concept ID: 1 
## view ID: none 
## level: species 
## parent: none 
## 
## # accepted name: 
## 1 Asplenium obliquum Forster 
## ------------------------------ 
## concept ID: 2 
## view ID: none 
## level: variety 
## parent: none 
## 
## # accepted name: 
## 2 Asplenium obliquum var. sphenoides (Kunze) Espinosa 
## ------------------------------ 
## concept ID: 3 
## view ID: none 
## level: variety 
## parent: none 
## 
## # accepted name: 
## 3 Asplenium obliquum var. chondrophyllum (Bertero apud Colla) C. Christense & C. Skottsberg 
## ------------------------------ 
## concept ID: 4 
## view ID: none 
## level: genus 
## parent: none 
## 
## # accepted name: 
## 4 Asplenium L. 
## ------------------------------
```

## Set parent-child relationships and synonyms

Now set the parent-child relations.
Relating to the previous display, you know that the species (concept ID **1**)
is the parent of the varieties (IDs **2** and **3**), and the genus (ID **4**)
is the parent of the species (ID **1**).
Thus the relationships are set as:


```r
add_parent(Fern, c(2,3)) <- 1
add_parent(Fern, 1) <- 4
summary(Fern)
```

```
## object size: 5.8 Kb 
## validation of 'taxlist' object: TRUE 
## 
## number of names: 4 
## number of concepts: 4 
## trait entries: 0 
## reference entries: 0 
## 
## concepts with parents: 3 
## concepts with children: 2 
## 
## hierarchical levels: variety < species < genus 
## number of concepts in level variety: 2
## number of concepts in level species: 1
## number of concepts in level genus: 1
```

Similarly to the addition of concepts, you can also add synonyms:


```r
Fern <- add_synonym(Fern, ConceptID=2, TaxonName=c("Asplenium sphenoides"),
	AuthorName="Kunze")
summary(Fern, "all")
```

```
## ------------------------------ 
## concept ID: 1 
## view ID: none 
## level: species 
## parent: 4 
## 
## # accepted name: 
## 1 Asplenium obliquum Forster 
## ------------------------------ 
## concept ID: 2 
## view ID: none 
## level: variety 
## parent: 1 
## 
## # accepted name: 
## 2 Asplenium obliquum var. sphenoides (Kunze) Espinosa 
## 
## # synonyms (1): 
## 5 Asplenium sphenoides Kunze 
## ------------------------------ 
## concept ID: 3 
## view ID: none 
## level: variety 
## parent: 1 
## 
## # accepted name: 
## 3 Asplenium obliquum var. chondrophyllum (Bertero apud Colla) C. Christense & C. Skottsberg 
## ------------------------------ 
## concept ID: 4 
## view ID: none 
## level: genus 
## parent: none 
## 
## # accepted name: 
## 4 Asplenium L. 
## ------------------------------
```

Hierarchical levels, parent-child relationships and synonyms are included in the
exemple data set `Easplist`.
For further functions, look to the package's manual.
