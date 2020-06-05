def select_indel(vcf, indel, idx):
    inputs = [vcf]
    outputs = [indel, idx]
    options = {
        'cores': 4,
        'memory': '8g',
        'walltime': '1:00:00'
    }
    spec = '''
gatk SelectVariants \
-V {vcf} \
--select-type-to-exclude SNP \
-O {indel}    
    '''.format(vcf=vcf, indel=indel)
    return inputs, outputs, options, spec


def select_snp(vcf, snp, idx):
    inputs = [vcf]
    outputs = [snp, idx]
    options = {
        'cores': 4,
        'memory': '8g',
        'walltime': '1:00:00'
    }
    spec = '''
gatk SelectVariants \
-V {vcf} \
--select-type-to-include SNP \
-O {snp}    
    '''.format(vcf=vcf, snp=snp)
    return inputs, outputs, options, spec


def indel_to_tsv(vcf, tsv):
    inputs = [vcf]
    outputs = [tsv]
    options = {
        'cores': 4,
        'memory': '8g',
        'walltime': '1:00:00'
    }
    spec = '''
bcftools query -H \
  -f '%CHROM\t%POS\t%QUAL\t%IDV\t%IMF\t%DP\t%VDB\t%SGB\t%MQ0F\t%ICB\t%HOB\t%AC\t%AN\t%DP4\t%MQ[\t%GT\t]\n' \
  {vcf} > {tsv}    
    '''.format(vcf=vcf, tsv=tsv)
    return inputs, outputs, options, spec


def snp_to_tsv(vcf, tsv):
    inputs = [vcf]
    outputs = [tsv]
    options = {
        'cores': 4,
        'memory': '8g',
        'walltime': '1:00:00'
    }
    spec = '''
bcftools query -H \
  -f '%CHROM\t%POS\t%QUAL\t%DP\t%VDB\t%SGB\t%RPB\t%MQB\t%MQSB\t%BQB\t%MQ0F\t%ICB\t%HOB\t%AC\t%AN\t%DP4\t%MQ[\t%GT\t]\n' \
  {vcf} > {tsv}    
    '''.format(vcf=vcf, tsv=tsv)
    return inputs, outputs, options, spec
