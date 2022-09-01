# -*- coding: utf-8 -*-

import os
import sys
import click


def load_samples(varfile):
    return [x.strip() for x in os.popen(f'bcftools query -l {varfile}').readlines()]



def base2file(varfile, sample, region, nhap, regions_file, outfile):
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
@click.option('--varfile', help='vcf,bcf file are required')
@click.option('--region', help='start and end of the region', default=None)
@click.option('--regions-file', help='one region per line', default=None)
@click.option('--ploidy', help='one sample per line', default=None)
@click.option('--outfile', help='file name of output')
def main(varfile, region, regions_file, ploidy, outfile):

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
