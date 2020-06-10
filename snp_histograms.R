library(dplyr)

snps = read.delim('data/only_snps.tsv',
                  stringsAsFactors = FALSE,
                  header = TRUE,
                  sep = '\t')
not_any_na = function(x) all(!is.na(x))
snps = select_if(snps, not_any_na)
colstodiscard = c()
for(i in c(1:17)) {
  if('.' %in% snps[, i]) {
    colstodiscard = append(colstodiscard, i)
  }
}
snps = snps[, -1 * colstodiscard]
snps = snps[snps$X.18.results.sorted_Gifu_R.bam.GT != './.', ]
ref = snps[snps$X.18.results.sorted_Gifu_R.bam.GT =='0/0', ]
het = snps[snps$X.18.results.sorted_Gifu_R.bam.GT =='0/1', ]
alt = snps[snps$X.18.results.sorted_Gifu_R.bam.GT =='1/1', ]

pdf('results/all_SNPs_hist.pdf')
for(i in c(3:6, 8, 10)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((snps[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(snps[, i]))), max(log10(as.numeric(snps[, i])))),
       main = colnames(snps)[i])
  } else {
  hist(x = as.numeric(snps[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps[, i])), max(as.numeric(snps[, i]))),
       main = colnames(snps)[i])
  }
}
dev.off()

pdf('results/ref_SNPs_hist.pdf')
for(i in c(3:6, 8, 10)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((ref[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(snps[, i]))), max(log10(as.numeric(snps[, i])))),
       main = colnames(ref)[i])
  } else {
  hist(x = as.numeric(ref[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps[, i])), max(as.numeric(snps[, i]))),
       main = colnames(ref)[i])
  }
}
dev.off()

pdf('results/het_SNPs_hist.pdf')
for(i in c(3:6, 8, 10)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((het[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(snps[, i]))), max(log10(as.numeric(snps[, i])))),
       main = colnames(het)[i])
  } else {
  hist(x = as.numeric(het[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps[, i])), max(as.numeric(snps[, i]))),
       main = colnames(het)[i])
  }
}
dev.off()

pdf('results/alt_SNPs_hist.pdf')
for(i in c(3:6, 8, 10)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((alt[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(snps[, i]))), max(log10(as.numeric(snps[, i])))),
       main = colnames(alt)[i])
  } else {
  hist(x = as.numeric(alt[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(snps[, i])), max(as.numeric(snps[, i]))),
       main = colnames(alt)[i])
  }
}
dev.off()
