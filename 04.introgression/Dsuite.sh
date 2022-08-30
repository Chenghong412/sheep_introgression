####Loter: a software package for local ancestry inference for admixed individuals

##step 1 prepare npy file for each species/population
export pop=$1
export chr=$2
python ~/Script/vcf2Loter.py \
        --vcffile sheep.chr${2}.imp.AR2.phase.vcf.gz \ #vcf should be imputated and phased 
        --samplelist ~/poplists/${1}.samples \ #
        --outprefix ${1}_${2}   #output npy file required by loter                                

		
##step 2 run loter 
export chr=$1
/stor9000/apps/users/NWSUAF/2012010954/Software/Anaconda4.4_py3.6/bin/loter_cli \
        -r donor1_${1}.npy \
           donor2_${1}.npy \
           donor3_${1}.npy \
           donor4_${1}.npy \
           donor5_${1}.npy \
           donor6_${1}.npy \
        -a recipients_${1}.npy \
        -f npy -o loter_${1}.npy -n 4 -v
		

