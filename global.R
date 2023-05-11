#import library
library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggpubr)
library(scales)
library(glue)
library(plotly)
library(lubridate)
library(DT)
library(stringr)
options(scipen = 100)

# EDA
movies <- read.csv("top-500-movies.csv", stringsAsFactors = T)
movies <- drop_na(movies)
movies$release_date <- ymd(movies$release_date)

#insert column (profit, crr)
movies <- movies %>% 
  mutate(profit= worldwide_gross - production_cost) %>% 
  mutate(crr = production_cost/worldwide_gross*100)

# fungsi pilih tahun
select_year <- function(df, tahun){
  df <- df %>% 
    select(year, title, profit, genre, crr) %>% 
    filter(year==tahun) %>% 
    head(10)
}

# fungsi pilih genre
select_genre <- function(df, pil_genre){
  df <- df %>% 
    select(year, title, production_cost, profit, genre, crr) %>% 
    filter(genre==pil_genre) %>% 
    head(10)
}
