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
The 
The script 01.hete_count_window.pl was used for calculate the heterozygosity of each individual and each window in a vcf file.
It should be noted that the vcf file used here must contain information of NON-SNP sites, which will be used as the background.



04.introgression
The script 01.extract_cds.pl was used for arrange input file, which could be modified as you like.
The script 02.codon_sta.pl was used to calculate the codon for each gene.
The script 03.collect.pl was used to collect the result from previous step.
The script 04.amino_usage.pl was used to compare the AA usage for different species.
The script 05.codon_usage.pl was used to compare the codon usage for different species.
The scripts 06.single_gene_AA.pl and 07.collect_AA_singleGene.pl were to compare the AA usage for each species in each gene.

05.haplotype_nework
The script 01.basic_table.pl was used to calculate the Ka and Ks for each species in each GO.
The script 02.fdr.rscript was used to perform FDR justification.

06.GWAS
The first script 00.prepare.sh was used to reconstruct ancestral states and perform simulations.
The second script 01.convergence.pl was used to identify convergent mutation in each simulation.