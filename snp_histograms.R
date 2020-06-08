library(dplyr)

snps = read.delim('data/only_snps.tsv',
                  header = TRUE,
                  sep = '\t')
not_any_na = function(x) all(!is.na(x))
snps = select_if(snps, not_any_na)
snps = snps[, -16]
snps[, 14] = as.numeric(snps[, 14])
snps = snps[snps$X.18.results.sorted_Gifu_R.bam.GT != './.', ]
ref = snps[snps$X.18.results.sorted_Gifu_R.bam.GT =='0/0', ]
het = snps[snps$X.18.results.sorted_Gifu_R.bam.GT =='0/1', ]
alt = snps[snps$X.18.results.sorted_Gifu_R.bam.GT =='1/1', ]

print(table(snps$X.18.results.sorted_Gifu_R.bam.GT))

print(sapply(list(snps, ref, het, alt), nrow))

pdf('results/all_SNPs_hist.pdf')
for(i in c(3, 4, 6:16)) {
  hist(x = as.numeric(snps[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps[, i])), max(as.numeric(snps[, i]))),
       main = colnames(snps)[i])
}
dev.off()

pdf('results/ref_SNPs_hist.pdf')
for(i in c(3, 4, 6:16)) {
  hist(x = as.numeric(ref[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps[, i])), max(as.numeric(snps[, i]))),
       main = colnames(ref)[i])
}
dev.off()

pdf('results/het_SNPs_hist.pdf')
for(i in c(3, 4, 6:16)) {
  hist(x = as.numeric(het[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps[, i])), max(as.numeric(snps[, i]))),
       main = colnames(het)[i])
}
dev.off()

pdf('results/alt_SNPs_hist.pdf')
for(i in c(3, 4, 6:16)) {
  hist(x = as.numeric(alt[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps[, i])), max(as.numeric(snps[, i]))),
       main = colnames(alt)[i])
}
dev.off()
