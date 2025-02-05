#import packages
packages_names <- c('tidyverse', 'readxl', 'writexl')
lapply(packages_names, require, character.only = TRUE)

#raw file
peptide_result_raw <- read_xlsx('data_source/raw_data/peptide_result_raw.xlsx')
protein_result_raw <- read_xlsx('data_source/raw_data/protein_result_raw.xlsx')

#quantification
protein_quantification <- read_xlsx('data_source/quantification/protein_quantification.xlsx')

#normalized data
