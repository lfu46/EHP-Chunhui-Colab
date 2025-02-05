#import packages
packages_names <- c('tidyverse', 'readxl', 'writexl')
lapply(packages_names, require, character.only = TRUE)

#load result file
peptide_result_raw <- read_csv(
  'data_source/raw_data/ronghuwulab_1738769658_peptide.csv',
  col_names = TRUE, name_repair = 'universal'
) |> 
  filter(str_detect(Reference, 'HUMAN')) |> 
  filter(!str_detect(Reference, 'contaminant')) |> 
  filter(!str_detect(Reference, '##')) |> 
  filter(XCorr > 1.2) |> 
  filter(PPM > -10, PPM < 10) |> 
  filter(Sum.Sn > 45) |> 
  separate(Reference, into = c('sp', 'UniProt_Accession', 'protein_name'), sep = '\\|') |> 
  select(Peptide = Trimmed.Peptide, Pept.Length = Pept..Length, Start.Position, End.Position, Trypticity, MissedCleav,
         Obs.m.z, XCorr, PPM, UniProt_Accession, Gene.Symbol, Annotation, 
         cfz_1 = ..126.Sn, cfz_2 = ..127n.Sn, cfz_3 = ..127c.Sn,
         cfz_4H10_4 = ..128n.Sn, cfz_4H10_5 = ..128c.Sn, cfz_4H10_6 = ..129c.Sn,
         DMSO_7 = ..129c.Sn, DMSO_8 = ..130n.Sn, DMSO_9 = ..130c.Sn, Sum.Sn) 

write_xlsx(peptide_result_raw, path = 'data_source/raw_data/peptide_result_raw.xlsx')

protein_result_raw <- read_csv(
  'data_source/raw_data/ronghuwulab_1738769789_protein.csv',
  col_names = TRUE, name_repair = 'universal'
) |> 
  filter(str_detect(reference, 'HUMAN')) |> 
  filter(!str_detect(reference, 'contaminant')) |> 
  filter(!str_detect(reference, '##')) |> 
  separate(reference, into = c('sp', 'UniProt_Accession', 'protein_name'), sep = '\\|') |> 
  select(UniProt_Accession, Gene.Symbol, Total, Unique, Annotation, Coverage_Percentage = Coverage..)

write_xlsx(protein_result_raw, path = 'data_source/raw_data/protein_result_raw.xlsx')
