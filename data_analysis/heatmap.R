#import packages
packages_names <- c('tidyverse', 'readxl', 'writexl', 'ComplexHeatmap', 'circlize')
lapply(packages_names, require, character.only = TRUE)

#calcuate the transformed intensity of each protein
protein_avg_scaled_intensity <- protein_quantification_raw_sl_tmm |> 
  select(UniProt_Accession, Gene.Symbol, Annotation, ends_with('sl_tmm')) |> 
  rowwise() |> 
  mutate(
    cfz_avg = (cfz_1_sl_tmm + cfz_2_sl_tmm + cfz_3_sl_tmm)/3,
    cfz_4H10_avg = (cfz_4H10_4_sl_tmm + cfz_4H10_5_sl_tmm + cfz_4H10_6_sl_tmm)/3,
    DMSO_avg = (DMSO_7_sl_tmm + DMSO_8_sl_tmm + DMSO_9_sl_tmm)/3
  ) |> 
  mutate(
    max_value = max(across(ends_with('avg'))),
    min_value = min(across(ends_with('avg')))
  ) |> 
  ungroup() |> 
  mutate(
    scaled_cfz_avg = (cfz_avg - min_value)*2/(max_value - min_value) - 1,
    scaled_cfz_4H10_avg = (cfz_4H10_avg - min_value)*2/(max_value - min_value) - 1,
    scaled_DMSO_avg = (DMSO_avg - min_value)*2/(max_value - min_value) - 1
  )

write_xlsx(protein_avg_scaled_intensity, path = 'data_source/protein_avg_scaled_intensity.xlsx')

#heatmap
scaled_intensity_matrix <- data.matrix(protein_avg_scaled_intensity |> select(starts_with('scaled')))
colnames(scaled_intensity_matrix) <- c('cfz', 'cfz.4H10', 'DMSO')
col_intensity <- colorRamp2(breaks = c(-1, 0, 1), colors = c('blue', 'white', 'red'))
Heatmap(matrix = scaled_intensity_matrix, col = col_intensity, name = 'scaled.intensity')

