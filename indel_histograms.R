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
colstodiscard = c()
for(i in c(1:17, 179, 180)) {
  if('.' %in% indels[, i]) {
    colstodiscard = append(colstodiscard, i)
  }
}
indels = indels[, -1 * colstodiscard]
indels = indels[indels$X.18.results.sorted_Gifu_R.bam.GT != './.', ]
ref = indels[indels$X.18.results.sorted_Gifu_R.bam.GT =='0/0', ]
het = indels[indels$X.18.results.sorted_Gifu_R.bam.GT =='0/1', ]
alt = indels[indels$X.18.results.sorted_Gifu_R.bam.GT =='1/1', ]

pdf('results/all_INDELs_hist.pdf')
for(i in c(3:6, 8, 10, 172, 173)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((indels[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(indels[, i]))), max(log10(as.numeric(indels[, i])))),
       main = colnames(indels)[i])
  } else {
  hist(x = as.numeric(indels[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(indels[, i])), max(as.numeric(indels[, i]))),
       main = colnames(indels)[i])
  }
}
dev.off()

pdf('results/ref_INDELs_hist.pdf')
for(i in c(3:6, 8, 10, 172, 173)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((ref[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(indels[, i]))), max(log10(as.numeric(indels[, i])))),
       main = colnames(ref)[i])
  } else {
  hist(x = as.numeric(ref[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(indels[, i])), max(as.numeric(indels[, i]))),
       main = colnames(ref)[i])
  }
}
dev.off()

pdf('results/het_INDELs_hist.pdf')
for(i in c(3:6, 8, 10, 172, 173)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((het[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(indels[, i]))), max(log10(as.numeric(indels[, i])))),
       main = colnames(het)[i])
  } else {
  hist(x = as.numeric(het[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(indels[, i])), max(as.numeric(indels[, i]))),
       main = colnames(het)[i])
  }
}
dev.off()

pdf('results/alt_INDELs_hist.pdf')
for(i in c(3:6, 8, 10, 172, 173)) {
  if(i %in% c(3, 4)) {
      hist(x = log10((alt[, i])), col = 'gold', breaks = 200,
       xlim = c(min(log10(as.numeric(indels[, i]))), max(log10(as.numeric(indels[, i])))),
       main = colnames(alt)[i])
  } else {
  hist(x = as.numeric(alt[, i]), col = 'gold', breaks = 200,
       xlim = c(min(as.numeric(indels[, i])), max(as.numeric(indels[, i]))),
       main = colnames(alt)[i])
  }
}
dev.off()
