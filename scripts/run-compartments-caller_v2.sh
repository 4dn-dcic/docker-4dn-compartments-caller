#!/bin/bash

INPUT=$1
PHASING_TRACK=$2
OUTDIR=$3
BINSIZE=$4
CONTACT_TYPE=$5
# N_EIGS=$6
# IGNORE_DIAGS=$7
# CLIP_PERCENTILE=$8
SORT_METRIC=$6
# PERC_TOP=$10
# PERC_BOTTOM=$11
# PARTITION=$12

FILE_BASE=$(basename $INPUT)
FILE_NAME=${FILE_BASE%%.*}

if [ ! -d "$OUTDIR" ]
then
    mkdir $OUTDIR
fi

# python /usr/local/bin/get_compartments.py  --contact_type $CONTACT_TYPE --binsize $BINSIZE --n_eigs $N_EIGS --phasing_track $PHASING_TRACK \
#                                           --ignore_diags $IGNORE_DIAGS --clip_percentile $CLIP_PERCENTILE --sort_metric $SORT_METRIC \
#                                           --perc_top $PERC_TOP --perc_bottom $PERC_BOTTOM --partition $PARTITION \
#                                           $INPUT $OUTDIR $FILE_NAME

python /usr/local/bin/get_compartments.py --contact_type $CONTACT_TYPE --binsize $BINSIZE --sort_metric $SORT_METRIC $INPUT $PHASING_TRACK $OUTDIR
