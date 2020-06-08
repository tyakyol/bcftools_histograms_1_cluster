library(dplyr)

indels = read.delim('data/only_indels.tsv',
                    header = TRUE,
                    sep = '\t')
not_any_na = function(x) all(!is.na(x))
indels = select_if(indels, not_any_na)
indels = indels[, c(-7, -8, -10, -16)]
indels[, 7] = as.numeric(indels[, 7])
indels[, 11] = as.numeric(indels[, 11])
indels = indels[indels$X.18.results.sorted_Gifu_R.bam.GT != './.', ]
ref = indels[indels$X.18.results.sorted_Gifu_R.bam.GT =='0/0', ]
het = indels[indels$X.18.results.sorted_Gifu_R.bam.GT =='0/1', ]
alt = indels[indels$X.18.results.sorted_Gifu_R.bam.GT =='1/1', ]

print(table(indels$X.18.results.sorted_Gifu_R.bam.GT))

print(sapply(list(indels, ref, het, alt), nrow))

pdf('results/all_INDELs_hist.pdf')
for(i in c(3, 4, 6:13)) {
  hist(x = as.numeric(indels[, i]), col = 'gold', breaks = 300,
       main = colnames(indels)[i])
}
dev.off()

pdf('results/ref_INDELs_hist.pdf')
for(i in c(3, 4, 6:13)) {
  hist(x = as.numeric(ref[, i]), col = 'gold', breaks = 300,
       main = colnames(ref)[i])
}
dev.off()

pdf('results/het_INDELs_hist.pdf')
for(i in c(3, 4, 6:13)) {
  hist(x = as.numeric(het[, i]), col = 'gold', breaks = 300,
       main = colnames(het)[i])
}
dev.off()

pdf('results/alt_INDELs_hist.pdf')
for(i in c(3, 4, 6:13)) {
  hist(x = as.numeric(alt[, i]), col = 'gold', breaks = 300,
       main = colnames(alt)[i])
}
dev.off()
