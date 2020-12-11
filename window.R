args = commandArgs(T)
input = args[1]
output = args[2]

data = read.table(input,stringsAsFactors = F, check.names = F, header = TRUE)
chrs = unique(data$Chromosome)
chr_stat = c()
window_stat = c()
methy_stat = c()
for(chr in chrs){
  data_chr = data[data$Chromosome==chr,]
  windows = unique(data_chr$windows)
  for(window in windows){
    methy = weighted.mean(data_chr[data_chr$windows == window,]$methy,w = data_chr[data_chr$windows == window,]$depth)
    chr_stat = c(chr_stat, chr)
    window_stat = c(window_stat, window)
    methy_stat = c(methy_stat, methy)
  }
}

pd <- data.frame(chr=chr_stat,window=window_stat, methy=methy_stat)

write.table(pd, file = output, row.names = F,col.names = T)
