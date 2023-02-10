##Directed Study
##Working with Raw Force Plate Data - Drop and Stick

#load packages
library(tidyverse)
library(readxl)
library(signal)
library(zoo)
library(patchwork)

#---------------------------------------------------------------

#1 IMPORTING

path <- file.choose()
path %>% excel_sheets() %>%
  set_names() %>%
  map_dfr(read_excel, path = path)

#Import Test Identifier Data from first sheet
DnS_ID <- read_excel(path, sheet = 1, range = "A1:X2") %>%
  select(Subject, Squad, yearmmdd, time_string, Age, BW_KG, BW_N, ExternalLoad_Weight) %>%
  rename(Drop_Height = ExternalLoad_Weight,
         Time = time_string,
         Date = yearmmdd,
         BM_kg = BW_KG,
         BM_N = BW_N)
#maybe we can get lead foot selection in there?

#Import all data from "Left" tab and rename column headers to identify as Left Force Plate
DnS_Left <- read_excel(path, sheet = "Left") %>%
  setNames(paste0('Left_',colnames(.)))
#Import all data from "Right" tab and rename column headers to identify as Right Force Plate
DnS_Right <- read_excel(path,sheet = "Right") %>%
  setNames(paste0('Right_',colnames(.)))

# #Importing for RMD file
# path <- "SDartois_DnS_Raw_20221129.xlsx"
# 
# #Import Test Identifier Data from first sheet
# DnS_ID <- read_excel(path, sheet = 1, range = "A1:X2") %>%
#   select(Subject, Squad, yearmmdd, time_string, Age, BW_KG, BW_N, ExternalLoad_Weight) %>%
#   rename(Drop_Height = ExternalLoad_Weight,
#          Time = time_string,
#          Date = yearmmdd,
#          BM_kg = BW_KG,
#          BM_N = BW_N)
# #maybe we can get lead foot selection in there?
# 
# #Import all data from "Left" tab and rename column headers to identify as Left Force Plate
# DnS_Left <- read_excel(path, sheet = "Left") %>%
#   setNames(paste0('Left_',colnames(.)))
# #Import all data from "Right" tab and rename column headers to identify as Right Force Plate
# DnS_Right <- read_excel(path,sheet = "Right") %>%
#   setNames(paste0('Right_',colnames(.)))

#token
#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
