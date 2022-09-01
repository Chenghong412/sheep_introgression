####Trimmomatic

for i in sample1 sample2 sample3 \
do
	java -Xmx30g -Djava.io.tmpdir=~/data/ \
	-jar ~/BioSoftware/bin/trimmomatic-0.36.jar  PE -phred33 -threads 10 \
	~/data/${i}/${i}_R1.fq.gz \
	~/data/${i}/${i}_R2.fq.gz \
	~/data/${i}_R1.clean.fq.gz \
	~/data/unpaired/${i}_R1.clean.fq.gz \
	~/data/${i}_R2.clean.fq.gz \
	~/data/unpaired/${i}_R2.clean.fq.gz \
	LEADING:3 \
	TRAILING:3 \
	SLIDINGWINDOW:4:15 \
	MINLEN:36 >~/data/${i}.log
Done