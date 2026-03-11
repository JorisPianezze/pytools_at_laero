#!/bin/bash

export dir_pgd_files='http://mesonh.aero.obs-mip.fr/mesonh/dir_open/dir_PGDFILES'

for file in LICENSE_ECOCLIMAP.txt LICENSE_soil_data.txt \
            gtopo30.hdr           gtopo30.dir           \
            SAND_HWSD_MOY.hdr     SAND_HWSD_MOY.dir     \
            CLAY_HWSD_MOY.hdr     CLAY_HWSD_MOY.dir     \
            ECOCLIMAP_v2.0.hdr    ECOCLIMAP_v2.0.dir    \
            etopo2.nc
do
   if [ ! -f ${file} ]
   then
      echo 'Download' ${file}
      wget -c -nd ${dir_pgd_files}/${file}.gz ; gunzip ${file}.gz
   fi
done
