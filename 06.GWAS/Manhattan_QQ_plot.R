#Object: Manhattan & QQ Plot for genome-wide association study
#Output: Single figure with PDF format
#Usage: Rscript commandArgs()[4] pvalue.txt sites_number traits_name png/pdf


library(qqman)
args <- commandArgs(trailingOnly = TRUE)
data <- read.table(args[1],header = T) 
colorset <- c("#4C72B0", "#DD8452") 
x <- "png"
if(args[4] == x) {
   png(file = paste0(args[3], ".", args[4]), width=1500, height=225)
} else {
   pdf(file = paste0(args[3], ".", args[4]), width = 18,height=4.5)
}
layout(matrix(c(1,2), 1, 2, byrow = TRUE),widths=c(5,1), heights=c(1,1))
par(mar = (c(3,4,2,2)+ 0.5), mgp=c(1.6,1,0))
par(bty="l", lwd=1.5)  ## bty=l  the plot is coordinate instead of box
#manhattan(data, CHR = "CHR", BP = "BP",SNP="SNP", p = "P", suggestiveline = F, genomewideline = F, cex = 0.8)  
manhattan(data, CHR = "CHR", BP = "BP",SNP="SNP", p = "P", suggestiveline = F, genomewideline = F, cex = 0.8, highlight = "11_37525005")
sites_number <- as.numeric(args[2])
abline(h=-log10(0.01/sites_number), lty=5, col="grey40") 
qq(data$P, cex = 0.8)
dev.off()
