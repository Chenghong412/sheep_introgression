####gvcf for each sample
for j in $(cat bam.name)
do
echo $j
mkdir $j
cd $j

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 X 
do
echo $i
echo "
export Input=~/bam
export tmp=~/tmp
java -Xmx60g -Djava.io.tmpdir=\$tmp -jar ~/bin/GATK3.7/GenomeAnalysisTK.jar -R ~/Oar_rambouillet.fa -T HaplotypeCaller -L $i -ERC GVCF -I \$Input/$j.sort.dedup.realn.bam -o $j.$i.g.vcf.gz
" >> $j.$i.sh
chmod 755 $j.$i.sh
done
done

#####Combine and genotype gvcf files
export tmp=~/tmp
java -Xmx150g -Djava.io.tmpdir=$tmp -jar GATK3.7/GenomeAnalysisTK.jar -R GCF_000298735.2_Oar_v4.0_genomic_rename.fna -T CombineGVCFs --variant gvcf.list -o merge.gvcf.gz
java -Xmx150g -Djava.io.tmpdir=$tmp -jar GATK3.7/GenomeAnalysisTK.jar -R GCF_000298735.2_Oar_v4.0_genomic_rename.fna -T GenotypeGVCFs --variant merge.gvcf.gz --includeNonVariantSites -o merge.raw.vcf.gz

	
