Custom scripts for manuscript "Long divergent haplotypes introgressed from wild sheep are associated with distinct morphological and adaptive characteristics in domestic sheep"

00.basic_scripts
including two scripts: gff2cds.pl and translateCDS2Protein.pl.
The first one was used to extract coding sequences and protein sequences with GFF file and the genome sequences.
The second one was used to convert coding sequences to protein sequences.

01.mapping
The first script 01.generate_control_file.pl was used to generate control file for MP-EST.
The following three scripts were used for run bootstrap.

02.population_structure

03.demographic_history
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