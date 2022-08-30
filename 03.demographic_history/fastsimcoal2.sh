####fastsimcoal2

##generate bed file,which will be excluded in next steps
les GCF_000298735.2_Oar_v4.0_genomic.gff.gz |sed -n '9,$p'| cut -f 1-5 |csvtk join -H -f1 -t ChromosomeName2 - | grep -v 'region' | cut -f2,5,6 | sort -k1,1V -k2,2n gene_regions > gene_regions  #if not sort an error will be reported!


##Remove regions with gene

bedtools complement -i gene_regions -g Chr.size > bed_for_model

##extract non-gene region
bedtools intersect -a sheep.nchr.snp.flt.recode.vcf.gz -b bed_for_model -header > sheep.nchr.snp.flt.recode.for_model.vcf

##SNP genotypes are coded 0, 1 or 2 (9 for missing data) according to the number of reference
vcftools --gzvcf result.gz --012 --out sheep.nchr.snp.flt.recode.pruned.maf.for_model  #Genotypes are represented as 0, 1 and 2, where the number represent that number of non-reference alleles.

cut -f2- sheep.nchr.snp.flt.recode.pruned.maf.for_model.012 | sed 's/0/6/g' | sed 's/2/8/g'|sed 's/6/2/g'| sed 's/8/0/g'| sed 's/-1/9/g'> sheep.nchr.snp.flt.recode.pruned.maf.for_model_modfied.012


#generate A header and merge all data
for i in {1..32882}; do echo A  >> test; done
sed -i ":a;N;s/\n/\t/g;ta" test 
sed -i 's/NA/9/g' id_sex_pop
cat test sheep.nchr.snp.flt.recode.pruned.maf.for_model_modfied.012 | paste id_sex_pop - | sed 's/\s\+/\t/g' | sed '1i Example Datafile for SNP <NM=1.5NF> <MAF=hudson>' > sheep.nchr.snp.flt.recode.pruned.maf.for_model_modfied_final.012

# filter sites depth
vcftools --gzvcf sheep.nchr.snp.flt.recode.for_model.vcf.gz --site-mean-depth --out sheep.nchr.snp.flt.recode.for_model
awk '$3>=4 && $3<=36 {print$0}' sheep.nchr.snp.flt.recode.for_model.ldepth.mean > sheep.nchr.snp.flt.recode.for_model.ldepth_filtered.mean


# bedtools
cut -f 1,2 sheep.nchr.snp.flt.recode.for_model.ldepth_filtered.mean | awk '{print$1"\t"$2"\t"$2}'|bedtools intersect -a sheep.nchr.snp.flt.recode.for_model.vcf.gz -b - -header > sheep.nchr.snp.flt.recode.depth_filterd.for_model2.vcf  
bcftools query -l sheep.nchr.snp.flt.recode.depth_filterd.for_model2_final.vcf | paste - id_pop1 | sed 's/\t/ /g' | cut -d ' ' -f 2 > name_to_replace.txt
bcftools reheader -s name_to_replace.txt sheep.nchr.snp.flt.recode.depth_filterd.for_model2_final.vcf -o sheep.nchr.snp.flt.recode.depth_filterd.for_model2_final_rename.vcf 


#generate SFS file needed in fastsimcoal2, easySFS.py came from https://github.com/isaacovercast/easySFS
bash easySFS.sh

easySFS.sh:
python3 easySFS.py -i sheep.nchr.snp.flt.recode.depth_filterd.for_model2_final_rename.vcf -p id_pop1 -a --proj 24,12,20,20  

