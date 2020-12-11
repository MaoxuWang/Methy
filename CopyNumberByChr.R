args = commandArgs(T)
#copy_data="./38.copyNumbersCalled"
copy_data_path=args[1]
outpath=args[2]

copy_data = read.table(copy_data_path,header=TRUE, stringsAsFactors=FALSE)

filenum = dim(copy_data)[2]
xmax = length(copy_data$chromosome)
ymax = 6
samples = colnames(copy_data[,5:filenum])

chroms = unique(copy_data$chromosome)

sex = data.frame(chr=chroms,stringsAsFactors = F)
for (sam in samples) {
  cn = c()
  for (chr in chroms) {
    i = 1
    cn <- c(cn, mean(copy_data[which(copy_data['chromosome'] ==chr),sam]))
    i = i + 1
  }
  sex[sam] <- cn
}

outfile=paste0(outpath,'/','CopyNumberByChr.txt')
write.table(sex, outfile, quote = F,sep = '\t',row.names = FALSE)
