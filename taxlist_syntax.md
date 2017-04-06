# Quick start on taxlist
*Miguel Alvarez*

<br>

## Introduction
This guide demonstrates the application of `taxlist` objects to syntaxonomic
schemes.
For accessing this document from your **R console** use following command:


```r
browseURL("https://github.com/kamapu/Guides/blob/master/taxlist_syntax.md")
```

It is strongly recommended to install the last version of the `taxlist` package
in every session.


```r
library(devtools)
install_github("kamapu/taxlist")
```

## Example syntaxonomic scheme
For this guide it will be used as example an scheme proposed by the author for
aquatic and semi-aquatic vegetation in Tanzania (**Alvarez 2017**).
The scheme includes 10 associations classified into 4 classes:

![](images/wetlands_syntax.png)

Start the session loading the package `taxlist` and the required data:


```r
library(taxlist)
load(url("https://github.com/kamapu/Guides/raw/master/data/wetlands_syntax.rda"))
```


```r
head(Concepts)
```

```
##   TaxonConceptID Parent                                TaxonName
## 1              1     NA                         Lemnetea minoris
## 2              2      1                 Salvinio-Eichhornietalia
## 3              3      2                       Pistion stratiotes
## 4              4      3 Lemno paucicostatae-Pistietum stratiotes
## 5              5     NA                                Potametea
## 6              6      5                       Nymphaeetalia loti
##                                   AuthorName       Level
## 1    Koch & Tüxen ex den Hartog & Segal 1964       class
## 2 Borhidi ex Borhidi, Muñiz & del Risco 1979       order
## 3                (Schmitz 1971) Schmitz 1988    alliance
## 4                                Lebrun 1947 association
## 5                Klika ex Klika & Novák 1941       class
## 6                                Lebrun 1947       order
```

```r
# Creating taxlist object
Syntax <- new("taxlist")
levels(Syntax) <- c("association","alliance","order","class")
taxon_views(Syntax) <- data.frame(ViewID=1, Author="Alvarez M", Year=2017,
        Title="Classification of aquatic and semi-aquatic vegetation in East Africa",
        stringsAsFactors=FALSE)

Syntax <- with(Concepts, add_concept(Syntax, TaxonName=TaxonName,
                AuthorName=AuthorName, Parent=Parent, Level=Level,
                ViewID=rep(1, nrow(Concepts))))

summary(Syntax)
```

```
## object size: 10.1 Kb 
## validation of 'taxlist' object: TRUE 
## 
## number of names: 26 
## number of concepts: 26 
## trait entries: 0 
## reference entries: 1 
## 
## concepts with parents: 22 
## concepts with children: 16 
## 
## hierarchical levels: association < alliance < order < class 
## number of concepts in level association: 10
## number of concepts in level alliance: 7
## number of concepts in level order: 5
## number of concepts in level class: 4
```

```r
# Adding synonyms
Syntax <- with(Synonyms, add_synonym(Syntax, ConceptID=TaxonConceptID,
                TaxonName=TaxonName, AuthorName=AuthorName))

# Adding traits
taxon_traits(Syntax) <- Codes

# Get Phragmitetalia
Syntax_Phr <- subset(Syntax, charmatch("Phragmitetalia", TaxonName), slot="names")
Syntax_Phr <- get_parents(Syntax, Syntax_Phr)
Syntax_Phr <- get_children(Syntax, Syntax_Phr)

summary(Syntax_Phr)
```

```
## object size: 9.6 Kb 
## validation of 'taxlist' object: TRUE 
## 
## number of names: 20 
## number of concepts: 14 
## trait entries: 7 
## reference entries: 1 
## 
## concepts with parents: 13 
## concepts with children: 7 
## 
## hierarchical levels: association < alliance < order < class 
## number of concepts in level association: 7
## number of concepts in level alliance: 4
## number of concepts in level order: 2
## number of concepts in level class: 1
```

```r
summary(Syntax_Phr, "all", maxsum=20)
```

```
## ------------------------------ 
## concept ID: 9 
## view ID: 1 
## level: class 
## parent: none 
## 
## # accepted name: 
## 9 Phragmito-Magno-Caricetea Klika ex Klika & Novák 1941 
## 
## # synonyms (1): 
## 31 Phragmitetea Tüxen & Preising 1942 
## ------------------------------ 
## concept ID: 10 
## view ID: 1 
## level: order 
## parent: 9 
## 
## # accepted name: 
## 10 Cyperetalia papyri (Lebrun 1947) Alvarez 2017 
## 
## # synonyms (1): 
## 32 Papyretalia Lebrun 1947 
## ------------------------------ 
## concept ID: 11 
## view ID: 1 
## level: alliance 
## parent: 10 
## 
## # accepted name: 
## 11 Cyperion papyri (Lebrun 1947) Alvarez 2017 
## 
## # synonyms (1): 
## 33 Papyrion Lebrun 1947 
## ------------------------------ 
## concept ID: 12 
## view ID: 1 
## level: association 
## parent: 11 
## 
## # accepted name: 
## 12 Cypero papyro-Dryopteridetum gongylodes (Germain 1951) Schmitz 1963 
## ------------------------------ 
## concept ID: 13 
## view ID: 1 
## level: association 
## parent: 9 
## 
## # accepted name: 
## 13 Ipomoeo aquaticae-Typhetum domingensis Alvarez 2017 
## ------------------------------ 
## concept ID: 14 
## view ID: 1 
## level: association 
## parent: 9 
## 
## # accepted name: 
## 14 Leersio hexandrae-Cyperetum exaltati Alvarez 2017 
## ------------------------------ 
## concept ID: 15 
## view ID: 1 
## level: order 
## parent: 9 
## 
## # accepted name: 
## 15 Phragmitetalia communis Koch 1926 
## ------------------------------ 
## concept ID: 16 
## view ID: 1 
## level: alliance 
## parent: 15 
## 
## # accepted name: 
## 16 Phragmition communis Koch 1926 
## ------------------------------ 
## concept ID: 17 
## view ID: 1 
## level: association 
## parent: 16 
## 
## # accepted name: 
## 17 Phragmitetum mauritiani (Lebrun 1947) Schmitz 1988 
## 
## # synonyms (1): 
## 34 Phragmitetum afro-lacustre Lebrun 1947 
## ------------------------------ 
## concept ID: 18 
## view ID: 1 
## level: association 
## parent: 16 
## 
## # accepted name: 
## 18 Pycreo polystachyos-Panicetum subalbidum Alvarez 2017 
## ------------------------------ 
## concept ID: 19 
## view ID: 1 
## level: alliance 
## parent: 15 
## 
## # accepted name: 
## 19 Magno-Cyperion divitis (Lebrun 1947) Schmitz 1988 
## 
## # synonyms (1): 
## 35 Magno-Cyperion africanum Lebrun 1947 
## ------------------------------ 
## concept ID: 20 
## view ID: 1 
## level: association 
## parent: 19 
## 
## # accepted name: 
## 20 Cyperetum latifolii (Germain 1951) Schmitz 1988 
## ------------------------------ 
## concept ID: 21 
## view ID: 1 
## level: alliance 
## parent: 15 
## 
## # accepted name: 
## 21 Echinochloion crus-pavonis (Léonard 1950) Schmitz 1988 
## 
## # synonyms (1): 
## 36 Echinochloion tropicale Léonard 1950 
## ------------------------------ 
## concept ID: 22 
## view ID: 1 
## level: association 
## parent: 21 
## 
## # accepted name: 
## 22 Ammannio prieurianae-Ethulietum conyzoides Alvarez 2017 
## ------------------------------
```


