# TODO:   Reading data for tutorial
# 
# Author: Miguel Alvarez
################################################################################

library(xlsx)

setwd("M:/WorkspaceEclipse/Guides")

Concepts <- read.xlsx("data/wetlands_syntax.xlsx", sheetName="Concepts",
        stringsAsFactors=FALSE, encoding="UTF-8")
Synonyms <- read.xlsx("data/wetlands_syntax.xlsx", sheetName="Synonyms",
        stringsAsFactors=FALSE, encoding="UTF-8")
Codes <- read.xlsx("data/wetlands_syntax.xlsx", sheetName="Codes",
        stringsAsFactors=FALSE, encoding="UTF-8")

save(Codes, Concepts, Synonyms, file="data/wetland_syntax.rda")
