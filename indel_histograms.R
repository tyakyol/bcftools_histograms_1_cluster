library(dplyr)

indels = read.delim('data/only_indels.tsv',
                    stringsAsFactors = FALSE,
                    header = TRUE,
                    sep = '\t')
not_any_na = function(x) all(!is.na(x))
indels = select_if(indels, not_any_na)
addition = read.delim(file = 'data/only_indels_additional.tsv',
                      stringsAsFactors = FALSE,
                      header = TRUE,
                      sep = '\t')
addition = select_if(addition, not_any_na)
indels = cbind(indels, addition)
colstochange = c()
for(i in c(1:17, 179, 180)) {
  if('.' %in% indels[, i]) {
    colstochange = append(colstochange, i)
  }
}
indels2 = indels[, -1 * colstochange]
indels3 = indels[, colstochange]
indels3[indels3 == '.'] = NA
indels3 = indels3[ -1 * c(2, 3, 5)]
indels2 = cbind(indels2, indels3)
indels2 = indels2[indels2$X.18.results.sorted_Gifu_R.bam.GT != './.', ]
ref = indels2[indels2$X.18.results.sorted_Gifu_R.bam.GT =='0/0', ]
het = indels2[indels2$X.18.results.sorted_Gifu_R.bam.GT =='0/1', ]
alt = indels2[indels2$X.18.results.sorted_Gifu_R.bam.GT =='1/1', ]

for(i in c(3:6, 8, 10, 172:177)) {
  if(i %in% c(3, 4)) {
    print(range(log10((indels2[, i]))))
} else {
    print(range(na.omit(as.numeric(indels2[, i]))))
}
}

pdf('results/all_INDELs_hist.pdf')
for(i in c(3:6, 8, 10, 172:177)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((indels2[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(indels2[, i]))), max(log10(as.numeric(indels2[, i])))),
       main = colnames(indels2)[i])
  } else {
  hist(x = na.omit(as.numeric(indels2[, i])), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(indels2[, i]), na.rm = TRUE), max(as.numeric(indels2[, i]), na.rm = TRUE)),
       main = colnames(indels2)[i])
  }
}
dev.off()

pdf('results/ref_INDELs_hist.pdf')
for(i in c(3:6, 8, 10, 172:177)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((ref[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(indels2[, i]))), max(log10(as.numeric(indels2[, i])))),
       main = colnames(ref)[i])
  } else {
  hist(x = na.omit(as.numeric(ref[, i])), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(indels2[, i]), na.rm = TRUE), max(as.numeric(indels2[, i]), na.rm = TRUE)),
       main = colnames(ref)[i])
  }
}
dev.off()

pdf('results/het_INDELs_hist.pdf')
for(i in c(3:6, 8, 10, 172:177)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((het[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(indels2[, i]))), max(log10(as.numeric(indels2[, i])))),
       main = colnames(het)[i])
  } else {
  hist(x = na.omit(as.numeric(het[, i])), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(indels2[, i]), na.rm = TRUE), max(as.numeric(indels2[, i]), na.rm = TRUE)),
       main = colnames(het)[i])
  }
}
dev.off()

pdf('results/alt_INDELs_hist.pdf')
for(i in c(3:6, 8, 10, 172:177)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((alt[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(indels2[, i]))), max(log10(as.numeric(indels2[, i])))),
       main = colnames(alt)[i])
  } else {
  hist(x = na.omit(as.numeric(alt[, i])), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(indels2[, i]), na.rm = TRUE), max(as.numeric(indels2[, i]), na.rm = TRUE)),
       main = colnames(alt)[i])
  }
}
dev.off()
