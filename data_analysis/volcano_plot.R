# import packages
library(tidyverse)

## volcano plot
# cfz vs. cfz + 4H10
volcano_plot_cfz_vs_cfz_4h10 <- cfz_vs_cfz_4h10_toptable_tb |> 
  mutate(
    log_p_value = -log10(P.Value)
  ) |> 
  ggplot() +
  geom_point(
    aes(
      x = logFC, 
      y = log_p_value
    ), 
    size = 0.5
  ) +
  geom_hline(
    yintercept = -log10(0.05),
    linetype = 'dashed'
  ) +
  labs(
    x = 'log2(CFZ vs. CFZ+4H10)',
    y = '-log10(P value)'
  ) +
  theme_bw() +
  theme(
    axis.title = element_text(size = 10)
  )

ggsave(
  'figures/volcano_plot_cfz_vs_cfz_4h10.png',
  plot = volcano_plot_cfz_vs_cfz_4h10,
  width = 2,
  height = 2,
  unit = 'in'
)

# cfz vs. DMSO
volcano_plot_cfz_vs_DMSO <- cfz_vs_DMSO_toptable_tb |> 
  mutate(
    log_p_value = -log10(P.Value)
  ) |> 
  ggplot() +
  geom_point(
    aes(
      x = logFC, 
      y = log_p_value
    ), 
    size = 0.5
  ) +
  geom_hline(
    yintercept = -log10(0.05),
    linetype = 'dashed'
  ) +
  labs(
    x = 'log2(CFZ vs. DMSO)',
    y = '-log10(P value)'
  ) +
  theme_bw() +
  theme(
    axis.title = element_text(size = 10)
  )

ggsave(
  'figures/volcano_plot_cfz_vs_DMSO.png',
  plot = volcano_plot_cfz_vs_DMSO,
  width = 2,
  height = 2,
  unit = 'in'
)

# cfz + 4H10 vs. DMSO
volcano_plot_cfz_4h10_vs_DMSO <- cfz_4h10_vs_DMSO_toptable_tb |> 
  mutate(
    log_p_value = -log10(P.Value)
  ) |> 
  ggplot() +
  geom_point(
    aes(
      x = logFC, 
      y = log_p_value
    ), 
    size = 0.5
  ) +
  geom_hline(
    yintercept = -log10(0.05),
    linetype = 'dashed'
  ) +
  labs(
    x = 'log2(CFZ+4H10 vs. DMSO)',
    y = '-log10(P value)'
  ) +
  theme_bw() +
  theme(
    axis.title = element_text(size = 10)
  )

ggsave(
  'figures/volcano_plot_cfz_4h10_vs_DMSO.png',
  plot = volcano_plot_cfz_vs_DMSO,
  width = 2,
  height = 2,
  unit = 'in'
)
