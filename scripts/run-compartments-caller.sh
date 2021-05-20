#!/bin/bash

INPUT=$1
PHASING_TRACK=$2
OUTDIR=$3
BINSIZE=$4
CONTACT_TYPE=$5
N_EIGS=$6
SORT_METRIC=$7
CLIP_PERCENTILE=$8
IGNORE_DIAGS=$9
PERC_TOP=${10}
PERC_BOTTOM=${11}

FILE_BASE=$(basename $INPUT)
FILE_NAME=${FILE_BASE%%.*}

if [ ! -d "$OUTDIR" ]
then
    mkdir $OUTDIR
fi

python /usr/local/bin/get_compartments.py --contact_type $CONTACT_TYPE --binsize $BINSIZE --n_eigs $N_EIGS --ignore_diags $IGNORE_DIAGS --clip_percentile $CLIP_PERCENTILE --sort_metric $SORT_METRIC --perc_top $PERC_TOP --perc_bottom $PERC_BOTTOM  $INPUT $PHASING_TRACK $OUTDIR $FILE_NAME


# python /usr/local/bin/get_compartments.py --contact_type $CONTACT_TYPE --binsize $BINSIZE --n_eigs $N_EIGS --sort_metric $SORT_METRIC --clip_percentile $CLIP_PERCENTILE $INPUT $PHASING_TRACK $OUTDIR $FILE_NAME
