library(dplyr)

snps = read.delim('data/only_snps.tsv',
                  stringsAsFactors = FALSE,
                  header = TRUE,
                  sep = '\t')
not_any_na = function(x) all(!is.na(x))
snps = select_if(snps, not_any_na)
colstochange = c()
for(i in 1:17) {
  if('.' %in% snps[, i]) {
    colstochange = append(colstochange, i)
  }
}
snps2 = snps[, -1 * colstochange]
snps3 = snps[, colstochange]
snps3[snps3 == '.'] = NA
snps2 = cbind(snps2, snps3)
snps2 = snps2[snps2$X.18.results.sorted_Gifu_R.bam.GT != './.', ]
ref = snps2[snps2$X.18.results.sorted_Gifu_R.bam.GT =='0/0', ]
het = snps2[snps2$X.18.results.sorted_Gifu_R.bam.GT =='0/1', ]
alt = snps2[snps2$X.18.results.sorted_Gifu_R.bam.GT =='1/1', ]

for(i in c(3:6, 8, 10, 172:178)) {
  if(i %in% c(3, 4)) {
    print(range(log10((snps2[, i]))))
} else {
    print(range(na.omit(as.numeric(snps2[, i]))))
}
}

pdf('results/all_SNPs_hist.pdf')
for(i in c(3:6, 8, 10, 172:178)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((snps2[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(snps2[, i]))), max(log10(as.numeric(snps2[, i])))),
       main = colnames(snps2)[i])
  } else {
  hist(x = na.omit(as.numeric(snps2[, i])), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps2[, i]), na.rm = TRUE), max(as.numeric(snps2[, i]), na.rm = TRUE)),
       main = colnames(snps2)[i])
  }
}
dev.off()

pdf('results/ref_SNPs_hist.pdf')
for(i in c(3:6, 8, 10, 172:178)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((ref[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(snps2[, i]))), max(log10(as.numeric(snps2[, i])))),
       main = colnames(ref)[i])
  } else {
  hist(x = na.omit(as.numeric(ref[, i])), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps2[, i]), na.rm = TRUE), max(as.numeric(snps2[, i]), na.rm = TRUE)),
       main = colnames(ref)[i])
  }
}
dev.off()

pdf('results/het_SNPs_hist.pdf')
for(i in c(3:6, 8, 10, 172:178)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((het[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(snps2[, i]))), max(log10(as.numeric(snps2[, i])))),
       main = colnames(het)[i])
  } else {
  hist(x = na.omit(as.numeric(het[, i])), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps2[, i]), na.rm = TRUE), max(as.numeric(snps2[, i]), na.rm = TRUE)),
       main = colnames(het)[i])
  }
}
dev.off()

pdf('results/alt_SNPs_hist.pdf')
for(i in c(3:6, 8, 10, 172:178)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((alt[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(snps2[, i]))), max(log10(as.numeric(snps2[, i])))),
       main = colnames(alt)[i])
  } else {
  hist(x = na.omit(as.numeric(alt[, i])), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps2[, i]), na.rm = TRUE), max(as.numeric(snps2[, i]), na.rm = TRUE)),
       main = colnames(alt)[i])
  }
}
dev.off()
