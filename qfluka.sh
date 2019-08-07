#!/bin/bash
# Script to launch flair-FLUKA jobs on a cluster using OpenPBS
# Author: Vasilis.Vlachoudis@cern.ch
# Date: Nov-2006

NAME="flair${!#}"
JOBFILE=${NAME}.job
NAME=`echo ${NAME} | cut -c 1-15`

WORKDIR=/project/Gruppo3/fiber5/celentano/bdxFlukaFull/full3/run1

cat > ${JOBFILE} << EOF
#!/bin/tcsh -f
setenv FLUKA $FLUKA
setenv FLUPRO $FLUPRO
cd ${WORKDIR}
$1 $2 /project/Gruppo3/fiber5/celentano/bdxFlukaFull/rootfluka $4 $5 $6
EOF

echo "Submitting job ${JOBFILE}"
echo "ALL:" $*
echo "1:" $1
echo "2:" $2 
echo "3:" $3
echo "4:" $4
echo "5:" $5 
echo "6:" $6

chmod +x ${JOBFILE}
#ssh farmuisl6 bsub -R "select[hname!=teo24]" -q long -P sl6_64 ${WORKDIR}/${JOBFILE}

