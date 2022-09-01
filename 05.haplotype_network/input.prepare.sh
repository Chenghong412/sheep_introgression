####step 1 vcf to fasta
python3 vcf2fasta_hap.py --varfile samples.filter.phase.vcf.gz --region chr:start-end --outfile samples.fa #the vcf file should have been phased

####step 2 extract required samples
seqkit grep --pattern-file select_sample.txt samples.fa> select_sample.fa
