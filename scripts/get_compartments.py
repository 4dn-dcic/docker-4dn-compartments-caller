from cooltools.eigdecomp import cooler_cis_eig
from cooltools.eigdecomp import cooler_trans_eig
import cooler
import click
import bioframe
import sys
import pandas as pd


@click.command()
@click.argument('mcoolfile')
@click.argument('phasing_track')
@click.argument('outdir')
@click.argument('filename')
@click.option('--contact_type', default='cis')
@click.option('--binsize', default=-1)
@click.option('--n_eigs', default=3)
@click.option('--ignore_diags', default=None)
@click.option('--clip_percentile', default=99.9)
@click.option('--sort_metric', default=None)
@click.option('--perc_top', default=99.95)
@click.option('--perc_bottom', default=1)
@click.option('--partition', default=None)
def main(mcoolfile, phasing_track, outdir, filename, contact_type, binsize, n_eigs, ignore_diags, clip_percentile, sort_metric, perc_top, perc_bottom, partition):
    f = mcoolfile

    # Get the list of resolutions in the mcool file
    cooler_list = cooler.fileops.list_coolers(f)
    old_version = False

    # gets the resolutions from a file in a older version of cooler
    if not any([res for res in cooler_list if '/resolutions/' in res]):
        old_version = True
        binsize_list = []
        for res in cooler_list:
            cooler_path = str(f)+'::' + res
            c = cooler.Cooler(cooler_path)
            binsize_list.append(int(c.binsize))
    else:
        binsize_list = []
        for res in cooler_list:
            binsize_list.append(int(res.split('/')[-1]))

    # Check the input parameters
    if binsize == -1:
        binsize = min(binsize_list)
    else:
        if binsize not in binsize_list:
            print("Error: This binsize is not available in this mcool file. This is the list of binsizes availables:")
            print(binsize_list)
            sys.exit()

    # Creates a cooler object
    if old_version:
        res_list = []
        for res in cooler_list:
            res_list.append(int(res.split('/')[-1]))
            res_index = max(res_list)

        cooler_path = str(f) + '::' + str(res_index)
    else:
        cooler_path = str(f) + '::' + cooler_list[binsize_list.index(binsize)]
    c = cooler.Cooler(cooler_path)
    print(c)

    bins = pd.read_csv(phasing_track, sep='\t', names=['chrom', 'start', 'end', 'GC'])
    # Gets the chromsizes
    chromsizes = pd.Series(c.chroms()[:]['length'].values, index=c.chroms()[:]['name'].values)

    if contact_type == 'cis':
        eigvals, eigvecs = cooler_cis_eig(c, bins, n_eigs=n_eigs, phasing_track_col='GC', ignore_diags=ignore_diags, clip_percentile=clip_percentile, sort_metric=sort_metric)
    else:
        eigvals, eigvecs = cooler_trans_eig(c, bins, n_eigs=n_eigs, partition=partition, phasing_track_col="GC", sort_metric=sort_metric)

    # Save text files
    eigvals.to_csv(f'{outdir}/{filename}.eigs.cis.lam.txt', sep='\t')
    eigvecs.to_csv(f'{outdir}/{filename}.eigs.cis.vecs.txt', sep='\t', index=False)

    # Save bigwig track
    bioframe.to_bigwig(eigvecs, chromsizes, f'{outdir}/{filename}.eigs.vecs.E1.bw', 'E1')


if __name__ == "__main__":
    main()
