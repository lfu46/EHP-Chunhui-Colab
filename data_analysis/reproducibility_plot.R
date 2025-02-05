#import packages
packages_names <- c('tidyverse', 'readxl', 'writexl', 'psych')
lapply(packages_names, require, character.only = TRUE)

#reproducibility plot
#cfz
cfz_log2_intensity <- protein_quantification_raw_sl_tmm |> 
  select(cfz_1_sl_tmm:cfz_3_sl_tmm) |> 
  mutate(
    cfz.Rep.1 = log2(cfz_1_sl_tmm),
    cfz.Rep.2 = log2(cfz_2_sl_tmm),
    cfz.Rep.3 = log2(cfz_3_sl_tmm)
  )

pairs.panels(cfz_log2_intensity |> select(cfz.Rep.1:cfz.Rep.3), lm = TRUE, main = '')

#cfz_4H10
cfz_4H10_log2_intensity <- protein_quantification_raw_sl_tmm |> 
  select(cfz_4H10_4_sl_tmm:cfz_4H10_6_sl_tmm) |> 
  mutate(
    cfz.4H10.Rep.1 = log2(cfz_4H10_4_sl_tmm),
    cfz.4H10.Rep.2 = log2(cfz_4H10_5_sl_tmm),
    cfz.4H10.Rep.3 = log2(cfz_4H10_6_sl_tmm)
  )

pairs.panels(cfz_4H10_log2_intensity |> select(cfz.4H10.Rep.1:cfz.4H10.Rep.3), lm = TRUE, main = '')

#DMSO
DMSO_log2_intensity <- protein_quantification_raw_sl_tmm |> 
  select(DMSO_7_sl_tmm:DMSO_9_sl_tmm) |> 
  mutate(
    DMSO.Rep.1 = log2(DMSO_7_sl_tmm),
    DMSO.Rep.2 = log2(DMSO_8_sl_tmm),
    DMSO.Rep.3 = log2(DMSO_9_sl_tmm)
  )

pairs.panels(DMSO_log2_intensity |> select(DMSO.Rep.1:DMSO.Rep.3), lm = TRUE, main = '')
