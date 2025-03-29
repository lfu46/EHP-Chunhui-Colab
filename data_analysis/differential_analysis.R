# import packages
library(tidyverse)
library(limma)

# experimental model
Experiment_Model <- model.matrix(~ 0 + factor(rep(c("case1", "case2"), each = 3), levels = c("case1", "case2")))
colnames(Experiment_Model) <- c("case1", "case2")
Contrast_matrix <- makeContrasts(case1_case2 = case1 - case2, levels = Experiment_Model)

## differential analysis
log2_transformed_quantification = protein_quantification_raw_sl_tmm |> 
  mutate(
    log2_cfz_1_sl_tmm = log2(cfz_1_sl_tmm),
    log2_cfz_2_sl_tmm = log2(cfz_2_sl_tmm),
    log2_cfz_3_sl_tmm = log2(cfz_3_sl_tmm),
    log2_cfz_4H10_4_sl_tmm = log2(cfz_4H10_4_sl_tmm),
    log2_cfz_4H10_5_sl_tmm = log2(cfz_4H10_5_sl_tmm),
    log2_cfz_4H10_6_sl_tmm = log2(cfz_4H10_6_sl_tmm),
    log2_DMSO_7_sl_tmm = log2(DMSO_7_sl_tmm),
    log2_DMSO_8_sl_tmm = log2(DMSO_8_sl_tmm),
    log2_DMSO_9_sl_tmm = log2(DMSO_9_sl_tmm)
  )

# cfz vs. cfz + 4H10
log2_transformed_quantification_cfz_vs_cfz_4h10_matrix <- log2_transformed_quantification |> 
  select(starts_with("log2_cfz"), starts_with("log2_cfz_4H10")) |>
  as.matrix()

rownames(log2_transformed_quantification_cfz_vs_cfz_4h10_matrix) <- log2_transformed_quantification$UniProt_Accession

cfz_vs_cfz_4h10_toptable <- log2_transformed_quantification_cfz_vs_cfz_4h10_matrix |> 
  limma::lmFit(Experiment_Model) |>
  limma::contrasts.fit(Contrast_matrix) |>
  limma::eBayes() |>
  limma::topTable(n = Inf, coef = 1, adjust = "BH")

rownames_cfz_vs_cfz_4h10_toptable <- rownames(cfz_vs_cfz_4h10_toptable)

cfz_vs_cfz_4h10_toptable_tb <- cfz_vs_cfz_4h10_toptable |> 
  as_tibble() |> 
  mutate(
    UniProt_Accession = rownames_cfz_vs_cfz_4h10_toptable
  )

write_csv(cfz_vs_cfz_4h10_toptable_tb, "data_source/differential_analysis/cfz_vs_cfz_4h10_toptable.csv")

# cfz vs. DMSO
log2_transformed_quantification_cfz_vs_DMSO_matrix <- log2_transformed_quantification |> 
  select(log2_cfz_1_sl_tmm:log2_cfz_3_sl_tmm, starts_with("log2_DMSO")) |>
  as.matrix()

rownames(log2_transformed_quantification_cfz_vs_DMSO_matrix) <- log2_transformed_quantification$UniProt_Accession

cfz_vs_DMSO_toptable <- log2_transformed_quantification_cfz_vs_DMSO_matrix |> 
  limma::lmFit(Experiment_Model) |>
  limma::contrasts.fit(Contrast_matrix) |>
  limma::eBayes() |>
  limma::topTable(n = Inf, coef = 1, adjust = "BH")

rownames_cfz_vs_DMSO_toptable <- rownames(cfz_vs_DMSO_toptable)

cfz_vs_DMSO_toptable_tb <- cfz_vs_DMSO_toptable |> 
  as_tibble() |> 
  mutate(
    UniProt_Accession = rownames_cfz_vs_DMSO_toptable
  )

write_csv(cfz_vs_DMSO_toptable_tb, "data_source/differential_analysis/cfz_vs_DMSO_toptable.csv")

# cfz + 4H10 vs. DMSO
log2_transformed_quantification_cfz_4H10_vs_DMSO_matrix <- log2_transformed_quantification |> 
  select(log2_cfz_4H10_4_sl_tmm:log2_cfz_4H10_6_sl_tmm, starts_with("log2_DMSO")) |>
  as.matrix()

rownames(log2_transformed_quantification_cfz_4H10_vs_DMSO_matrix) <- log2_transformed_quantification$UniProt_Accession

cfz_4H10_vs_DMSO_toptable <- log2_transformed_quantification_cfz_4H10_vs_DMSO_matrix |> 
  limma::lmFit(Experiment_Model) |>
  limma::contrasts.fit(Contrast_matrix) |>
  limma::eBayes() |>
  limma::topTable(n = Inf, coef = 1, adjust = "BH")

rownames_cfz_4H10_vs_DMSO_toptable <- rownames(cfz_4H10_vs_DMSO_toptable)

cfz_4H10_vs_DMSO_toptable_tb <- cfz_4H10_vs_DMSO_toptable |> 
  as_tibble() |> 
  mutate(
    UniProt_Accession = rownames_cfz_4H10_vs_DMSO_toptable
  )

write_csv(cfz_4H10_vs_DMSO_toptable_tb, "data_source/differential_analysis/cfz_4H10_vs_DMSO_toptable.csv")
