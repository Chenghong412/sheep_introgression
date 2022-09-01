####step 1 run Duite for each chromosome
export chr=$1
export tree=$2
export pop=$3
mkdir ./sepChrom/
/home/caiyd/Software/Dsuite/Dsuite_2020_08_11/Dsuite-master/Build/Dsuite \
    Dtrios \
    --tree $2 \
    --out  ./sepChrom/'chr'$chr \
    ~/sheep/01.vcf/'Sheep.'$chr'.imp.phase.vcf.gz' \
    $pop 
	
####step 2 combine results of all chromosomes
export pop_tree=$1 #population tree (.nwk)
~/Software/Dsuite/Dsuite_2020_08_11/Dsuite-master/Build/Dsuite \
    DtriosCombine \
	-t ${pop_tree} \
	-o out/chrAuto \
	sepChrom/chr1 \
	sepChrom/chr2 \
	sepChrom/chr3 \
	sepChrom/chr4 \
	sepChrom/chr5 \
	sepChrom/chr6 \
	sepChrom/chr7 \
	sepChrom/chr8 \
	sepChrom/chr9 \
	sepChrom/chr10 \
	sepChrom/chr11 \
	sepChrom/chr12 \
	sepChrom/chr13 \
	sepChrom/chr14 \
	sepChrom/chr15 \
	sepChrom/chr16 \
	sepChrom/chr17 \
	sepChrom/chr18 \
	sepChrom/chr19 \
	sepChrom/chr20 \
	sepChrom/chr21 \
	sepChrom/chr22 \
	sepChrom/chr23 \
	sepChrom/chr24 \
	sepChrom/chr25 \
	sepChrom/chr26

####step 3 Fbranch
~/Software/Dsuite/Dsuite_2020_08_11/Dsuite-master/Build/Dsuite \
	Fbranch ${pop_tree} out/chrAuto_combined_tree.txt > out/fbranch.txt

~/Software/Dsuite/Dsuite_2020_08_11/Dsuite-master/utils/dtools.py \
	out/fbranch.txt \
	${pop_tree}
