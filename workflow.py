from gwf import Workflow
from templates import *

gwf = Workflow()

vcf_file = '../../InRoot/variant_calling_7/results/20200531_raw_variants.vcf'

gwf.target_from_template('selectIndel',
                         select_indel(vcf=vcf_file,
                                      indel='data/only_indels.vcf',
                                      idx='data/only_indels.vcf.idx'
                                      ))

gwf.target_from_template('selectSNPs',
                         select_snp(vcf=vcf_file,
                                    snp='data/only_snps.vcf',
                                    idx='data/only_snps.vcf.idx'
                                    ))

gwf.target_from_template('indeltotsv',
                         snp_to_tsv(vcf='data/only_indels.vcf',
                                    tsv='data/only_indels.tsv'
                                    ))

gwf.target_from_template('idv_and_imf',
                         idv_and_imf(vcf='data/only_indels.vcf',
                                     tsv='data/only_indels_additional.tsv'))

gwf.target_from_template('SNPtotsv',
                         snp_to_tsv(vcf='data/only_snps.vcf',
                                    tsv='data/only_snps.tsv'
                                    ))
