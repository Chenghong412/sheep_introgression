# -*- coding: utf-8 -*-


import os
import sys
import click


def load_samples(varfile):
    return [x.strip() for x in os.popen(f'bcftools query -l {varfile}').readlines()]



def base2file(varfile, sample, region, nhap, regions_file, outfile):
    """生成迭代器，每次返回80个碱基和一个\n
    nhap是返回第几个haplotype, 1或者2
    """
    if os.path.exists(outfile):
        with open(outfile, 'a') as f:
            f.write(f'\n>{sample}-{nhap}\n')
    else:
        with open(outfile, 'a') as f:
            f.write(f'>{sample}-{nhap}\n')
    if regions_file:
        os.system(f"bcftools query -f '[%TGT]\n' -s {sample} -R {regions_file} {varfile} | awk -F'[/|]' '{{print ${nhap}}}' | sed 's/\./N/g' | tr --delete '\n' | fold -w80 >> {outfile}")
    elif region:
        os.system(f"bcftools query -f '[%TGT]\n' -s {sample} -r {region} {varfile} | awk -F'[/|]' '{{print ${nhap}}}' | sed 's/\./N/g' | tr --delete '\n' | fold -w80 >> {outfile}")
    else:
        os.system(f"bcftools query -f '[%TGT]\n' -s {sample} {varfile} | awk -F'[/|]' '{{print ${nhap}}}' | sed 's/\./N/g' | tr --delete '\n' | fold -w80 >> {outfile}")




@click.command()
@click.option('--varfile', help='vcf,bcf文件')
@click.option('--region', help='需要转的区域(如1:1-1000), 默认全部', default=None)
@click.option('--regions-file', help='区域文件，默认None，覆盖--region', default=None)
@click.option('--ploidy', help='倍性文件, tab分割, 一行一个个体. 如 sample1\\t2', default=None)
@click.option('--outfile', help='输出fasta文件名')
def main(varfile, region, regions_file, ploidy, outfile):
    """
    输入文件不能有indel
    """
    if os.path.exists(outfile):
        sys.exit('outfile exists!')
    samples = load_samples(varfile)
    if ploidy:
        plo = {x.split()[0]: int(x.strip().split()[1]) for x in open(ploidy).readlines()}
    for nsample, sample in enumerate(samples, 1):
        sys.stdout.write(' ' * 30 + '\r')
        sys.stdout.flush()
        sys.stdout.write(f'{nsample}-1/{len(samples)} {sample}' + '\r')
        sys.stdout.flush()
        base2file(varfile, sample, region, 1, regions_file, outfile)
        if (not ploidy) or (plo[sample]==2):
            sys.stdout.write(' ' * 30 + '\r')
            sys.stdout.flush()
            sys.stdout.write(f'{nsample}-2/{len(samples)} {sample}' + '\r')
            sys.stdout.flush()
            base2file(varfile, sample, region, 2, regions_file, outfile)

if __name__ == '__main__':
    main()
