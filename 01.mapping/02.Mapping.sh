####step1 mapping by bwa
for i in sample1 sample2 sample3
do 
	bwa mem -t 4 ref.fa ${i}_R1.clean.fq.gz ${i}_R2.clean.fq.gz>${i}.mem.sam
done

####step 2 Samtobam & sortbam	
for i in sample1 sample2 sample3
do
samtools view -bS $i.mem.sam|samtools sort  >$i.mem.bam
done

####step 3 MarkDuplicates
export sample_id=$1
java -Xmx30g -Djava.io.tmpdir=~/data -jar ~/bin/picard-2.18.7.jar  MarkDuplicates \
	INPUT=${sample_id}.mem.bam \
	OUTPUT=${sample_id}.mem.rmdup.bam \
	REMOVE_DUPLICATES=true \
	CREATE_INDEX=true \
	VALIDATION_STRINGENCY=LENIENT \
	METRICS_FILE=${sample_id}dup.txt

####step 4 Realign
	java -Xmx90g -Djava.io.tmpdir=~/data -jar GATK3.7/GenomeAnalysisTK.jar -T RealignerTargetCreator -R ref.fa -o ./realn.intervals -I ~/02.bwa_mem_mapping__dedup/rmdup_RG.bam
	java -Xmx90g -Djava.io.tmpdir=~/data -jar GATK3.7/GenomeAnalysisTK.jar -T IndelRealigner -R ref.fa -targetIntervals realn.intervals -I ~/02.bwa_mem_mapping__dedup/rmdup_RG.bam -o realn.bam
	