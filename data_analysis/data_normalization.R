#import packages
packages_names <- c('tidyverse', 'readxl', 'writexl', 'limma', 'edgeR')
lapply(packages_names, require, character.only = TRUE)

#check the distribution of intensity of each channel
boxplot_protein_raw <- protein_quantification |> 
  select(cfz_1:DMSO_9) |> 
  pivot_longer(cols = cfz_1:DMSO_9, names_to = 'Exp', values_to = 'Intensity') |> 
  mutate(log2_intensity = log2(Intensity)) |> 
  ggplot() +
  geom_boxplot(
    aes(x = factor(Exp, levels = c('cfz_1', 'cfz_2', 'cfz_3', 'cfz_4H10_4', 'cfz_4H10_5', 'cfz_4H10_6', 'DMSO_7', 'DMSO_8', 'DMSO_9')),
        y = log2_intensity)
  ) +
  labs(x = '', y = expression(log[2]*'(intensity)')) +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1)
  )

ggsave(
  filename = 'data_source/data_normalization/figures/boxplot_protein_raw.tiff',
  plot = boxplot_protein_raw,
  height = 3, width = 3, units = 'in', dpi = 1200
)

#sample loading normalization
target_mean_protein <- mean(colSums(protein_quantification |> select(cfz_1:DMSO_9)))
norm_facs_protein <- target_mean_protein/colSums(protein_quantification |> select(cfz_1:DMSO_9))
protein_sl <- tibble(sweep(protein_quantification |> select(cfz_1:DMSO_9), 2, norm_facs_protein, FUN = '*'))
colnames(protein_sl) <- c(
  'cfz_1_sl', 'cfz_2_sl', 'cfz_3_sl', 
  'cfz_4H10_4_sl', 'cfz_4H10_5_sl', 'cfz_4H10_6_sl',
  'DMSO_7_sl', 'DMSO_8_sl', 'DMSO_9_sl'
)
protein_quantification_raw_sl <- bind_cols(protein_quantification, protein_sl)
write_xlsx(protein_quantification_raw_sl, path = 'data_source/data_normalization/protein_quantification_raw_sl.xlsx')

#check the distribution of intensity of each sl channel
boxplot_protein_raw_sl <- protein_quantification_raw_sl |> 
  select(cfz_1_sl:DMSO_9_sl) |> 
  pivot_longer(cols = cfz_1_sl:DMSO_9_sl, names_to = 'Exp', values_to = 'Intensity') |> 
  mutate(log2_intensity = log2(Intensity)) |> 
  ggplot() +
  geom_boxplot(
    aes(x = factor(Exp, levels = c('cfz_1_sl', 'cfz_2_sl', 'cfz_3_sl', 'cfz_4H10_4_sl', 'cfz_4H10_5_sl', 'cfz_4H10_6_sl', 'DMSO_7_sl', 'DMSO_8_sl', 'DMSO_9_sl')),
        y = log2_intensity)
  ) +
  labs(x = '', y = expression(log[2]*'(intensity)')) +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1)
  )

ggsave(
  filename = 'data_source/data_normalization/figures/boxplot_protein_raw_sl.tiff',
  plot = boxplot_protein_raw_sl,
  height = 3, width = 3, units = 'in', dpi = 1200
)

#TMM normalization
norm_facs_protein_sl_tmm <- calcNormFactors(protein_quantification_raw_sl |> select(cfz_1_sl:DMSO_9_sl))
protein_tmm <- tibble(sweep(protein_quantification_raw_sl |> select(cfz_1_sl:DMSO_9_sl), 2, norm_facs_protein_sl_tmm, FUN = "/"))
colnames(protein_tmm) <- c(
  'cfz_1_sl_tmm', 'cfz_2_sl_tmm', 'cfz_3_sl_tmm', 
  'cfz_4H10_4_sl_tmm', 'cfz_4H10_5_sl_tmm', 'cfz_4H10_6_sl_tmm',
  'DMSO_7_sl_tmm', 'DMSO_8_sl_tmm', 'DMSO_9_sl_tmm'
)
protein_quantification_raw_sl_tmm <- bind_cols(protein_quantification_raw_sl, protein_tmm)
write_xlsx(protein_quantification_raw_sl_tmm, path = 'data_source/data_normalization/protein_quantification_raw_sl_tmm.xlsx')

#check the distribution of intensity of each sl tmm channel
boxplot_protein_raw_sl_tmm <- protein_quantification_raw_sl_tmm |> 
  select(cfz_1_sl_tmm:DMSO_9_sl_tmm) |> 
  pivot_longer(cols = cfz_1_sl_tmm:DMSO_9_sl_tmm, names_to = 'Exp', values_to = 'Intensity') |> 
  mutate(log2_intensity = log2(Intensity)) |> 
  ggplot() +
  geom_boxplot(
    aes(x = factor(Exp, levels = c('cfz_1_sl_tmm', 'cfz_2_sl_tmm', 'cfz_3_sl_tmm', 'cfz_4H10_4_sl_tmm', 'cfz_4H10_5_sl_tmm', 'cfz_4H10_6_sl_tmm', 'DMSO_7_sl_tmm', 'DMSO_8_sl_tmm', 'DMSO_9_sl_tmm')),
        y = log2_intensity)
  ) +
  labs(x = '', y = expression(log[2]*'(intensity)')) +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1)
  )

ggsave(
  filename = 'data_source/data_normalization/figures/boxplot_protein_raw_sl_tmm.tiff',
  plot = boxplot_protein_raw_sl_tmm,
  height = 3, width = 3, units = 'in', dpi = 1200
)
