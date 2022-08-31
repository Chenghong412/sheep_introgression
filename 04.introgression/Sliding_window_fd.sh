##step 1 parse and filter genotype data from vcf files
export chr=$1
python ~/Software/SlidD/genomics_general-master/VCF_processing/parseVCF.py \
        -i sheep.chr${chr}.vcf.gz \
        | bgzip > 01.input/sheep.chr${chr}.geno.gz


##step 2 calculate fd value in sliding windows
python ~/Software/SlidD/genomics_general-master/ABBABABAwindows.py \
        -g sheep.all.chr.geno.gz \
        -f phased \
        --windType coordinate \
        -o Argali_CN-PRT.slidD.50K.gz \
        -w 50000 \ 
        -s 20000 \ 
        -m 100 \
        -P1 EU-OA DEOA-DEM23,DEOA-DEM24,DEOA-DEM25,ESOA-SAL01,ESOA-SAL02,ESOA-SAL03,ESOA-CHU01,ESOA-CHU02,ESOA-OJA01,ESOA-OJA02,ESOA-CAS01,ESOA-CAS02,CHOA-SWA01,CHOA-SWA02,CHOA-SWA03,CHOA-SWA04,CHOA-SMS01,FIOA-FIN01,FIOA-FIN02,FROA-LAC01,FROA-LAC02,GBOA-CHV01,GBOA-CHV02,GBOA-ROM01,GBOA-TWM01,GBOA-DWM01,GBOA-WHS01,NLOA-TEX01 \
        -P2 CN-PRT CNOA-PRT01,CNOA-PRT02,CNOA-PRT03,CNOA-PRT04,CNOA-PRT05,CNOA-PRT06,CNOA-PRT07,CNOA-PRT08,CNOA-PRT09,CNOA-PRT10 \
        -P3 Argali KGOM-AGL01,KGOM-AGL02,KGOM-AGL03,KGOM-AGL04,KGOM-AGL05,KGOM-AGL06,KGOM-AGL07,KGOM-AGL50,KGOM-AGL51,KGOM-AGL52,KGOM-AGL53,KGOM-AGL54 \
        -O Outgroup Goat \
        -T 1 --minData 0.5 --writeFailedWindows ##-w window size, -s step size,-m Minumum good sites per window