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

ln -sf ../001_prep_pgd/PGD* .
ln -sf ../002_prep_real_case/ERA5.* .

# -----------------------------------------------------
#    Create OUTPUT directory if necessary
# -----------------------------------------------------

if [[ ! -d "OUTPUT" ]]
then
   echo "Create OUTPUT directory."
   mkdir OUTPUT
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# --
time mpirun -np 2 MESONH${XYZ}
# --
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
