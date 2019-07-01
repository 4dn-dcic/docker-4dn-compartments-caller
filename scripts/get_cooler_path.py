import cooler
import click
import sys


@click.command()
@click.argument('mcoolfile')
@click.option('--binsize', default=-1, help='')
def main(mcoolfile, binsize):
    f = mcoolfile

    # Get the list of resolutions in the mcool file
    cooler_list = cooler.fileops.list_coolers(f)
    old_version = False

    if not any([res for res in cooler_list if '/resolutions/' in res]):  # gets the resolutions from a file in a older version of cooler
        old_version = True
        binsize_list = []
        for res in cooler_list:
            cooler_path = str(f)+'::'+res
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
    if old_version and binsize == -1:
        res_list = []
        for res in cooler_list:
            res_list.append(int(res.split('/')[-1]))
        res_index = max(res_list)
        cooler_path = str(f) + '::' + str(res_index)
    else:
        cooler_path = str(f) + '::' + cooler_list[binsize_list.index(binsize)]

    sys.stdout.write(cooler_path)


if __name__ == "__main__":
    main()
