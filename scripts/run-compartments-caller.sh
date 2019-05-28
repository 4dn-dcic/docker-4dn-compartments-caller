# !/bin/bash
shopt -s extglob
binsize=-1
reference_track=''
contact_type="cis"
num_eig_vec=3

printHelpAndExit() {
    echo "Usage: ${0##*/} [-b binsize] [-r reference_track] [-c contact_type] [-e num_eig_vec] [-o outdir] -i input_mcool"
    echo "-i input_mcool : Input file in .mcool format"
    echo "-o outdir : Output directory"
    echo "-b binsize : Default highest resolution"
    echo "-c contact_type : Type of the contacts perform eigen-value decomposition on (cis or trans). Default 'cis'."
    echo "-e num_eig_vec: Number of eigen vectors to compute (default 3)"
    echo "-r reference_track: Reference track for orienting and ranking eigenvectors"
    exit "$1"
}

while getopts "i:o:b:c:e:r:" opt; do
    case $opt in
        i) input=$OPTARG;;
        o) outdir=$OPTARG;;
        b) binsize=$OPTARG;;
        c) contact_type=$OPTARG;;
        e) num_eig_vec=$OPTARG;;
        r) reference_track=$OPTARG;;
        h) printHelpAndExit 0;;
        [?]) printHelpAndExit 1;;
        esac
done


COOL_PATH=$(python /usr/local/bin/get_cooler_path.py $input --binsize $binsize)

FILE_BASE=$(basename $input)
FILE_NAME=${FILE_BASE%%.*}

if [ ! -d "$outdir" ]
then
    mkdir $outdir
fi

if [[ ! -z $reference_track ]]
then
    reference_track="--reference-track $reference_track"
fi


cooltools call-compartments $COOL_PATH \
  --out-prefix $outdir/$FILE_NAME \
  --contact-type $contact_type \
  $REFERENCE_TRACK \
  --n-eigs $num_eig_vec \
  --bigwig
