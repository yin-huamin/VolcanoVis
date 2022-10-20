#Sys.setlocale("LC_ALL", "English")
library(shiny)
library(rsconnect)
library(ggplot2)
library(data.table)
library(dplyr)
library(ggprism)
#library(magrittr)
library(ggrepel)
library(stringr)

# saveRDS(diffres,"data/diffres.rds")
diffres <- data.table::fread("data/diffres.txt")

source("func/plot_volcano.R")

theme_list <- c("classic", "bw", "dark", "line_draw", "minimal", "prism")
