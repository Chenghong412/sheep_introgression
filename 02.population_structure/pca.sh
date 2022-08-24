#!/bin/sh
plink -bfile /stor9000/apps/users/NWSUAF/20150505920/sheep/01.variations/01.vcf/mouflon_dom.nchr --keep IR_mou_dom.list --make-bed --out IR_MOU_dom
/stor9000/apps/users/NWSUAF/2015060152/bin/EIG-6.1.4/bin/smartpca.perl -i IR_MOU_dom.bed -a IR_MOU_dom.bim -b mouflon_dom.ind -k 5 -m 0 -o IR_MOU_dom.pca -p IR_MOU_dom.plot -e IR_MOU_dom.eval -l IR_MOU_dom.log
