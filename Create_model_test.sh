#!/bin/sh

#cd <path_to_bayvarc_folder>
./bin/BayVarC-Model \
  -c ./Input data/model.list \
  -p all5s_test1 \
  -cut 0.2 \
  -m ./Features_file/panel_ct_mapability.xls \
  -t ./Features_file/panel_ct_tri.xls \
  -r ./Features_file/panel_ct_repeatmask.xls \
  -s ./Features_file/panel_ct_segmentDup.xls \
  -o ./output data/ \
  1>>./output data/s1.BayVarC-M.logo \
  2>>./output data/s1.BayVarC-M.loge

