####Principal component analysis (PCA)

##step 1 extract variations for required samples 
plink -bfile mouflon_dom.nchr --keep IR_mou_dom.list --make-bed --out IR_MOU_dom

##perfrom PCA using smartpca
#smartpca.pl was downloaded from https://github.com/argriffing/eigensoft
smartpca.perl -i IR_MOU_dom.bed -a IR_MOU_dom.bim -b mouflon_dom.ind -k 5 -m 0 -o IR_MOU_dom.pca -p IR_MOU_dom.plot -e IR_MOU_dom.eval -l IR_MOU_dom.log 

