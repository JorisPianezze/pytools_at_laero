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

ln -sf ../001_prep_pgd/PGD.nc .

# ---------------------------------------------------------
#    Loop over dates
# ---------------------------------------------------------

export YEAR='2025'
export MONTH='11'

export DAY='13'

for HOUR in '00' '06' '12' '18'
do

   echo '       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                  '
   echo '    Treatment of the date' $YEAR$MONTH$DAY 'at' $HOUR'h'
   echo '       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                  '
   echo '                                                       '

   cp PRE_REAL1.nam_tmpl PRE_REAL1.nam

   sed -i  "s/YEAR/$YEAR/g"  PRE_REAL1.nam
   sed -i "s/MONTH/$MONTH/g" PRE_REAL1.nam
   sed -i   "s/DAY/$DAY/g"   PRE_REAL1.nam
   sed -i  "s/HOUR/$HOUR/g"  PRE_REAL1.nam

   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   #--
   time mpirun -np 1 PREP_REAL_CASE${XYZ}
   #--
   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   mv OUTPUT_LISTING0 OUTPUT_LISTING0_${YEAR}${MONTH}${DAY}.${HOUR}
   mv PRE_REAL1.nam   PRE_REAL1.nam_${YEAR}${MONTH}${DAY}.${HOUR}

done

export DAY='14'

for HOUR in '00'
do

   echo '       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                  '
   echo '    Treatment of the date' $YEAR$MONTH$DAY 'at' $HOUR'h'
   echo '       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                  '
   echo '                                                       '

   cp PRE_REAL1.nam_tmpl PRE_REAL1.nam

   sed -i  "s/YEAR/$YEAR/g"  PRE_REAL1.nam
   sed -i "s/MONTH/$MONTH/g" PRE_REAL1.nam
   sed -i   "s/DAY/$DAY/g"   PRE_REAL1.nam
   sed -i  "s/HOUR/$HOUR/g"  PRE_REAL1.nam

   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   #--
   time mpirun -np 1 PREP_REAL_CASE${XYZ}
   #--
   #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   mv OUTPUT_LISTING0 OUTPUT_LISTING0_${YEAR}${MONTH}${DAY}.${HOUR}
   mv PRE_REAL1.nam   PRE_REAL1.nam_${YEAR}${MONTH}${DAY}.${HOUR}

done

