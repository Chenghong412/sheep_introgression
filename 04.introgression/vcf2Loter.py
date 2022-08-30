# -*- coding: utf-8 -*-

import click
import allel
import numpy as np

def vcf2npy(vcffile, samples):
    callset = allel.read_vcf(vcffile, samples=samples)
    haplotypes_1 = callset['calldata/GT'][:,:,0]
    haplotypes_2 = callset['calldata/GT'][:,:,1]

    m, n = haplotypes_1.shape
    mat_haplo = np.empty((2*n, m))
    mat_haplo[::2] = haplotypes_1.T
    mat_haplo[1::2] = haplotypes_2.T

    return mat_haplo.astype(np.uint8)


@click.command()
@click.option('--vcffile')
@click.option('--samplelist')
@click.option('--outprefix')
def main(vcffile, samplelist, outprefix):
    """
    convert vcf to Loter input
    """
    samples = [x.strip() for x in open(samplelist)]
    mat_haplo = vcf2npy(vcffile, samples)
    np.save(f'{outprefix}', mat_haplo)


if __name__ == '__main__':
    main()

