#admixture.sh
export K=$1 #K is the number of populations
export seed=$2 #random seed for initialization
~/software/admixture -s $seed --cv sheep.Prune.bed  $K -j4 | tee log${K}.out

#bootstrap.sh
bash admixture.sh $i $seed

#!/bin/sh
cat seed | while read line #seed file includes 20 random number
do
para1=`echo $line| awk '{print $1}' `
para2=`echo $line| awk '{print $2}' `
bash bootstrap.sh $para1 $para2
done

##In summary,we ran ADMIXTURE 20 times (seed need to be changed each time) from K=2 to K=9