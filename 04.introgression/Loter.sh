####Loter: a software package for local ancestry inference for admixed individuals

##step 1 prepare npy file for each species/population
export pop=$1
export chr=$2
python ~/Script/vcf2Loter.py \
        --vcffile sheep.chr${chr}.imp.AR2.phase.vcf.gz \ #vcf should be imputated and phased 
        --samplelist ~/poplists/${pop}.samples \ 
        --outprefix ${pop}_${chr}   #output npy file required by loter                                

		
##step 2 run loter 
export chr=$1
~/Software/Anaconda4.4_py3.6/bin/loter_cli \
        -r donor1_${chr}.npy \
           donor2_${chr}.npy \
           donor3_${chr}.npy \
           donor4_${chr}.npy \
           donor5_${chr}.npy \
           donor6_${chr}.npy \
        -a recipients_${chr}.npy \
        -f npy -o loter_${chr}.npy -n 4 -v
		