#!/bin/sh

#samtools mpileup -A -B -C 0 -q 20 -Q 20 -d 1000000000 -O -f $ref -l $bed $bam  1>$outdir/$sample.mpileup

#cd <path_to_bayvarc_folder>
./bin/BayVarC \
  -i ./Input data/OS-01.mpileup \
  -s OS-01 \
  -m ./Panel_of_mormal_model/ \
  -p all40s \
  -a 1e-04 \
  -ins 10 \
  -del 14 \
  -d 100 \
  -c 2 \
  -f 0.0005 \
  -n 16 \
  -o ./output data/

