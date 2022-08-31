
##step 1 imputaion and filteration
export chr=$1
java -Xmx20g -jar conform-gt.24May16.cee.jar gt=vcf ref=ref.vcf chrom=${chr} match=POS out=out_${chr}.imputation.vcf.gz

bcftools view -i 'INFO/DR2>0.8' out_${chr}.imputation.vcf.gz -Oz -o ${chr}.imputation.DR0.8.vcf.gz 
bcftools concat -f gzlist -Oz -o all_chr.filtered.imputation.DR0.8.vcf.gz

##running GWAS
plink --vcf all_chr.filtered.imputation.DR0.8.vcf.gz --recode --double-id --chr-set 26 --allow-extra-chr --out all_chr.filtered.imputation.DR0.8 #vcf to plink format

gemma-0.98.1-linux-static -bfile all_chr.filtered.imputation.DR0.8 -p ear_type -gk 2 -o ear_type #calculate the matrix of affiliation 

gemma-0.98.1-linux-static -bfile all_chr.filtered.imputation.DR0.8 -k ear_type.sXX.txt -lmm 1 -p ear_type -c covar.txt -o ear_type #gwas
