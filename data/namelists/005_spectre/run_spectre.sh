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

ln -sf ../003_mesonh/EXP01.1.SEG01.004.* .

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# --
time mpirun -np 1 SPECTRE${XYZ}
# --
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
