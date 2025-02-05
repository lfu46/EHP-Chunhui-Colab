#import packages
packages_names <- c('tidyverse', 'readxl', 'writexl')
lapply(packages_names, require, character.only = TRUE)

#quantification
protein_quantification <- peptide_result_raw |> 
  group_by(UniProt_Accession, Gene.Symbol, Annotation) |> 
  summarise(
    cfz_1 = sum(cfz_1),
    cfz_2 = sum(cfz_2),
    cfz_3 = sum(cfz_3),
    cfz_4H10_4 = sum(cfz_4H10_4),
    cfz_4H10_5 = sum(cfz_4H10_5),
    cfz_4H10_6 = sum(cfz_4H10_6),
    DMSO_7 = sum(DMSO_7),
    DMSO_8 = sum(DMSO_8),
    DMSO_9 = sum(DMSO_9)
  )

write_xlsx(protein_quantification, path = 'data_source/quantification/protein_quantification.xlsx')
