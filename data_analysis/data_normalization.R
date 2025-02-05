#import packages
packages_names <- c('tidyverse', 'readxl', 'writexl', 'limma', 'edgeR', 'showtext')
lapply(packages_names, require, character.only = TRUE)

#check the distribution of intensity of each channel
font_add(family = 'arial', regular = 'arial.ttf')
showtext_auto()

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

