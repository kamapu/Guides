# TODO:   Automatic compilation of documents
# 
# Author: Miguel Alvarez
################################################################################

library(knitr)
setwd("M:/WorkspaceEclipse/Guides")

## taxlist_firststeps ----------------------------------------------------------
File <- "taxlist_firststeps"
knit(file.path("src", File, paste0(File, ".Rmd")))

## taxlist_syntax --------------------------------------------------------------
File <- "taxlist_syntax"
knit(file.path("src", File, paste0(File, ".Rmd")))



