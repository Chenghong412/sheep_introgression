##step 1 vcf to plink format
plink --vcf input.vcf --allow-extra-chr --threads 6 --chr-set 27 --out $prefix 

##step 2 calculate allele frequency for each site
plink \
        --bfile $prefix \
        --chr-set 27 \
        --allow-extra-chr \
        --freq \
        --missing \
        --double-id \
        --threads 6 \
        --out sample.frq \
        --within sample.ind
##step 3 frq.strat.gz to treemix input format
python3 Plink2Treemix.py -i sample.frq.strat.gz -o sample.treemix.gz #Plink2Treemix.py is provided in 03.demographic_history, the output file is compressed


##step 4 run treemix
/stor9000/apps/users/NWSUAF/2015050469/anaconda3/bin/treemix -i sample.treemix.gz \
        -m $mig \
        -k 500 \
        -root Outgroup \  #the outgroup in this study is Goat
        -o 'sample_m'$mig #-m number of migration edges to add, range from 0-10; 

		
		