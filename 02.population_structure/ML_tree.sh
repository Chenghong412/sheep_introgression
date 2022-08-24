#Extract the fourfold degenerate site
vcftools --gzvcf /stor9000/apps/users/NWSUAF/20150505920/sheep/01.variations/01.vcf/sample293_Goat.snp.QC.nchr.recode.vcf.gz --positions /stor9000/apps/users/NWSUAF/20150505920/sheep/04.phylogenetics/Oar_v4.0_4D_site.bed --recode --out sheep293_Goat.nchr.snp.4DV
#vcf to phy
perl ~/script/VCF_Phylip.pl sheep293_Goat.link sheep293_Goat.nchr.snp.4DV.recode.vcf.gz sheep293_Goat.nchr.snp.4DV.phy 
#ML tree
/stor9000/apps/users/NWSUAF/2015060152/bin/RAxML-master/raxmlHPC-PTHREADS -f a -x 123 -p 23 -# 100 -k -s sheep293_Goat.nchr.snp.4DV.phy -m GTRGAMMA -n sheep293_Goat.nchr.snp.4DV  -T 20