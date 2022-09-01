Custom scripts for manuscript "Long divergent haplotypes introgressed from wild sheep are associated with distinct morphological and adaptive characteristics in domestic sheep"

00.basic_scripts
including several scripts usually used in whole-genome sequences researches: 
VCF_Phylip.pl was used to translate vcf to phylip format required for construct phylogenetic tree.
Identify_4D_Sites.pl was used to identify Fourfold Degenerate Synonymous Site(4DTv) according to GFF file and the genome sequences.


The first one was used to extract coding sequences and protein sequences with GFF file and the genome sequences.
The second one was used to convert coding sequences to protein sequences.

01.mapping
The scriptes from 01 to 04 were the general process for resequencing data, including quality control, mapping, variant calling and the subsequent filter. 

02.population_structure
The script ML_tree.sh was used to contruct ML tree with 4DTv using RAxML software.
The script PCA.sh was used to perform PCA using SNP dataset, and PCA_plot.R was used to visualize the PCA result.
The script Structure.sh was used to run ADMIXTURE with repetations, and the other scripts with "structure" prefix were used to further processing the results, structure.CV.extract.pl for extracting the CV values for each K in each repetation, structure.merge.pl for combining the results with lowest CV values, and structure_plot.R for ploting the ADMIXTURE results using R.


03.demographic_history
The script Treemix.sh was used to infer admixture signals among different speicies or populations.
The script Fastsimcoal2.sh was used to perform demographic inference under complex evolutionary scenarios.

04.introgression
The script Dsuite.sh was used to do genome scale calculations of the D and f4-ratio statistics across all combinations of multiple species or populations directly using VCF file.
The script Loter.sh was used to perform local ancestry inference for each SNP site. The VCF file should be phased and transformed to numpy format as Loter input.  
The script Sliding_window_fd.sh was used to calculate the D statistic and f estimators in sliding windows across the genome. These results can be used to detect the most significant introgressed regions. 
The script Population_dxy.sh  was used to calculate the genetic divergence (Dxy) in sliding windows across the genome. 

05.haplotype_nework
The script input.prepare.sh was used to calculate the Ka and Ks for each species in each GO.
The script network.R was used to construct the hapltype network using R pacakage pegas.

06.GWAS
The script GWAS.sh was used to perform Genome-Wide Association Studies (GWAS). 
The script Manhattan_QQ_plot.R was used to visualize the GWAS results using R package qqman.