####construct ML tree using RAxML

##step 1 Extract the fourfold degenerate site
vcftools --gzvcf sheep.snp.QC.nchr.recode.vcf.gz --positions Oar_v4.0_4D_site.bed --recode --out sheep.nchr.snp.4DV

##step 2 vcf to phy
perl VCF_Phylip.pl sheep.link sheep293_Goat.nchr.snp.4DV.recode.vcf.gz sheep293_Goat.nchr.snp.4DV.phy #VCF_Phylip.pl is provided in 00.basic_scripts

##step 3 run RAxML
/stor9000/apps/users/NWSUAF/2015060152/bin/RAxML-master/raxmlHPC-PTHREADS -f a -x 123 -p 23 -# 100 -k -s sheep293_Goat.nchr.snp.4DV.phy -m GTRGAMMA -n sheep293_Goat.nchr.snp.4DV  -T 20
#-f a to run a search for the ML tree and a rapid bootstrap analysis in one run, -x a random number seed for the ML search, -p a random number seed for the parsimony inference, -# the number of bootstrap, -m substitution models
