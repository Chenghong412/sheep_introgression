setwd("E:/J_L/sheep/gene/network")
library('pegas')
library(randomcoloR)
input <- "1789samples_vps13b.R1.85290732-85332457.fa"
d <- ape::read.dna(input, format = 'fasta')
e <- ape::dist.dna(d)
h <- pegas::haplotype(d)
net <- pegas::haploNet(h)
ind.hap <- with(stack(setNames(attr(h, "index"), rownames(h))), table(hap=ind, pop=rownames(d)[values]))
data <- read.table("1789samples_group.txt")
test.pop <- data[,1]
ind.hap<-with(stack(setNames(attr(h,"index"),rownames(h))),table(hap=ind,pop=test.pop[values]))
plot(net,size=5*(log2(attr(net,"freq"))+1),labels=F,threshold=c(0,0),fast=T)
mutations<-log2(net[,3])+0.5
mycolor<-distinctColorPalette(15)
plot(net, size=600*(log2(attr(net,"freq"))+1),pie=ind.hap,show.mutation=0,labels=F,threshold=c(0,0),bg=mycolor,lwd=mutations,fast=T)#关键的画图
legend("topright", colnames(ind.hap),col=mycolor, pch=20,bty='n',ncol=3,pt.cex=2)
                
                
lwdnum<-c(2,10,20)
ptnum<-c(1,2,5)
lwdsize<-c((log2(ptnum)+0.1))
ptsize<-600*(log2(ptnum)+1)
legend(0,0,lwdnum,lty=1,lwd=lwdsize,ncol=3,text.width=1,bty='n',adj=0)
legend(-10000,0,ptnum,pch=1,pt.cex=ptsize,ncol=3,text.width=1,bty='n',adj=0)
                
replot()