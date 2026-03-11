#!/bin/bash

ulimit -s unlimited
ulimit -c 0

# ---------------------------------------------------------
#    Load Meso-NH environment
# ---------------------------------------------------------

if [ -z ${XYZ} ] ; then
   echo '                                                '
   echo '       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   echo '        please load a profile_mesonh            '
   echo '       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   echo '                                                '
   exit
else
   echo '                                                '
   echo '       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   echo '            You are running with                '
   echo     ${SRC_MESONH}conf/profile_mesonh${XYZ}
   echo '                environment                     '
   echo '       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~           '
   echo '                                                '
fi

# ---------------------------------------------------------
#    Link to input files
# ---------------------------------------------------------

if [ ! -d ${PREP_PGD_FILES} ] ; then
   echo '   Your directory PREP_PGD_FILES=$PREP_PGD_FILES doesnt exist.'
   echo '                                                              '
   echo '   Either:                                                    '
   echo '                                                              '
   echo '   * you just need to set the PREP_PGD_FILES environment      '
   echo '     variable with the path containing the PGD files.         '
   echo '                                                              '
   echo '   * you need to download the files for the PGD with the      '
   echo '     get_pgd_files.sh script and then set the PREP_PGD_FILES  '
   echo '     environment variable.                                    '
   echo '                                                              '
   exit
else
   ln -sf $PREP_PGD_FILES/gtopo30.??? .
   ln -sf $PREP_PGD_FILES/ECOCLIMAP_v2.0.??? .
   ln -sf $PREP_PGD_FILES/CLAY_HWSD_MOY.??? .
   ln -sf $PREP_PGD_FILES/SAND_HWSD_MOY.??? .
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# --
time mpirun -np 1 PREP_PGD${XYZ}
# --
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
