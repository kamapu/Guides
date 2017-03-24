# TODO:   Automatic compilation of documents
# 
# Author: Miguel Alvarez
################################################################################

## taxlist_firststeps ----------------------------------------------------------
library(knitr)
setwd("M:/WorkspaceEclipse/Guides")
File <- "taxlist_firststeps"
knit(file.path("src", File, paste0(File, ".Rmd")))




