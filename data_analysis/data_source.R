# import packages
library(tidyverse)
library(readxl)

# raw file
peptide_result_raw <- read_xlsx('data_source/raw_data/peptide_result_raw.xlsx')
protein_result_raw <- read_xlsx('data_source/raw_data/protein_result_raw.xlsx')

# quantification
protein_quantification <- read_xlsx('data_source/quantification/protein_quantification.xlsx')

## normalized data
# sample loading
protein_quantification_raw_sl <- read_xlsx('data_source/data_normalization/protein_quantification_raw_sl.xlsx')

# TMM
protein_quantification_raw_sl_tmm <- read_xlsx('data_source/data_normalization/protein_quantification_raw_sl_tmm.xlsx')

## differential analysis
# cfz vs. cfz + 4h10
cfz_vs_cfz_4h10_toptable_tb <- read_csv('data_source/differential_analysis/cfz_vs_cfz_4h10_toptable.csv')

# cfz vs. DMSO
cfz_vs_DMSO_toptable_tb <- read_csv('data_source/differential_analysis/cfz_vs_DMSO_toptable.csv')

# cfz + 4h10 vs. DMSO
cfz_4h10_vs_DMSO_toptable_tb <- read_csv('data_source/differential_analysis/cfz_4h10_vs_DMSO_toptable.csv')
