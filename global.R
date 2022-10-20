library(shiny)
library(ggplot2)
library(data.table)
library(dplyr)
library(ggprism)
library(magrittr)
library(ggrepel)
library(stringr)


load("data/diffres.rda")

source("func/plot_volcano.R")

theme_list <- c("classic", "bw", "dark", "line_draw", "minimal", "prism")
