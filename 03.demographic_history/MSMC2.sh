####MSMC2

##step 1 calculate the mapping coverage
sambamba depth region -L chr.bed -t 4 -o sample_id.chr.depth sample_id.realigned.bam

awk '{print $3" "$2" "$4" "$1}' sheep_depth.final.txt | csvtk join -H -f1 -d " " depth.samtools - -T| sed 's/\t\+/ /g' | awk '{print $5" "$2" "$1" "$4}'|sort -k 4,4 > sheep_depth.final2.txt

cat sheep_depth.final.txt | while read a b c d; do bash indivmask.sh ${a} ${b} ${c};done


##step 2 get vcf for each individual
for sample in `cat sample_list` 
do
  mkdir -p ${sample}/log && cd ${sample}
  for i in {1..26} #chromsome number
  do
    echo "vcftools --gzvcf \
	00.sepChrom/chr${i}.vcf.gz --indv ${sample} \
	--recode --non-ref-ac-any 1 --recode-INFO-all --stdout | bgzip -c > ${sample}_${i}.vcf.gz" > ./${sample}_${i}.sh
	bash ./${sample}_${i}.sh
  done
  cd -
done


##step 3 run MSMC2
#!/bin/sh
if [ $# -ne 3 ]; then
 echo "error.. need args"
 echo "command:$0 <pop1> <pop2> <mulsep.prefix>"
 exit 1
else

for arg in "$@"
do
 echo $arg
done
cd $1\_$2
echo "export PATH=msmc2-2.1.2/build/release:\$PATH" >msmccommand1.sh
echo "export PATH=msmc2-2.1.2/build/release:\$PATH" >msmccommand2.sh
echo "export PATH=msmc2-2.1.2/build/release:\$PATH" >msmccommand3.sh
echo -n "msmc2 -i 30 -t 24 -p 1*2+20*1+1*2+1*3 -o $1 -I 0,1,2,3" >>msmccommand1.sh
for i in {1..26}
 do
  echo -n " chr${i}_$3.multihetsep" >>msmccommand1.sh
 done
echo -n "msmc2 -i 30 -t 24 -p 1*2+20*1+1*2+1*3 -o $2 -I 4,5,6,7" >>msmccommand2.sh
for i in {1..26}
 do
  echo -n " chr${i}_$3.multihetsep" >>msmccommand2.sh
 done
echo -n "msmc2 -i 30 -t 24 -I  0-4,0-5,0-6,0-7,1-4,1-5,1-6,1-7,2-4,2-5,2-6,2-7,3-4,3-5,3-6,3-7 -s -p 1*2+20*1+1*2+1*3 -o $1_$2" >>msmccommand3.sh
for i in {1..26}
 do
  echo -n " chr${i}_$3.multihetsep" >>msmccommand3.sh
 done
bash msmccommand1.sh
bash msmccommand2.sh
bash msmccommand3.sh
cd -
fi
