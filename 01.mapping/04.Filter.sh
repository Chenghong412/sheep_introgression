export vcf=$1
export b=`basename $vcf .raw_snp.vcf.gz`
java -Xmx10g -Djava.io.tmpdir=tmp \
	-jar GATK3.7/GenomeAnalysisTK.jar -R A.fa -T VariantFiltration \
	--filterExpression "QD <2.0 || FS > 60.0 || MQRankSum <-12.5 || ReadPosRankSum < -8.0 || SOR >3.0 || MQ <40.0" \
	--filterName Filter \
	--missingValuesInExpressionsShouldEvaluateAsFailing \
	--variant $vcf \
	--logging_level ERROR \
	-o $b.flt.vcf.gz