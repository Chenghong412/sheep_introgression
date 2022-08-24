setwd("E:/J_L/sheep/pca")
mydata=read.table("China.snp.QC.nchr.pca.evec",header=FALSE)
colnames(mydata)=c("sample","pc1","pc2","pc3","pc4","pc5","pop")
library(ggplot2)
ggplot(data = mydata,aes(x=pc1,y=pc3,color=pop,shape=pop))+
  geom_point(size=3)+
  labs(x="pc1 (2.73%)",y="pc2 (1.57%)")+
  scale_shape_manual(values = c(16,16,16,16,16,16,16,16,16,16,16))+
    theme(panel.grid.major=element_line(colour=NA),
        panel.background = element_rect(fill = "transparent",colour = NA),
        panel.border = element_rect(fill = "transparent",colour = "black"),
        plot.background = element_rect(fill = "transparent",colour = NA),
        panel.grid.minor = element_blank(),
        legend.background = element_rect(color = "black"),
        legend.key = element_rect(fill = "transparent", color = NA),
        legend.position=c(0,0), legend.justification=c(0,0))+      #图例位置
  guides(color=guide_legend(title=NULL),shape=guide_legend(title=NULL)