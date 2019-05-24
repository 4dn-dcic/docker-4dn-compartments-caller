# !/bin/bash

INPUT=$1
BINSIZE=$2
CONTACT_TYPE=$3
NUM_EIG_VEC=$4
OUTDIR=$5

COOL_PATH=$(python /d1/get_compartments.py $INPUT --binsize $BINSIZE)

FILE_BASE=$(basename $INPUT)
FILE_NAME=${FILE_BASE%%.*}

if [ ! -d "$OUTDIR" ]
then
    mkdir $OUTDIR
fi

cooltools call-compartments $COOL_PATH \
  --out-prefix $OUTDIR/$FILE_NAME \
  --contact-type $CONTACT_TYPE \
  --n-eigs $NUM_EIG_VEC \
  --bigwig
