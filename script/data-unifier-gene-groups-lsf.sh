#!/bin/sh

# WARNING: Generate the jar with the right profile (assembly plugin)
#
#      profiles
#      development: db-pride-pridetst, db-pride-proteomes-prideprot-user
#      production: db-pride-pridepro, db-pride-proteomes-prideprot-user

# Set up the environment

cd /nfs/pride/work/proteomes/data-unifier

# Load environment (and make the bsub command available)
#. /etc/profile.d/lsf.sh


QUEUE=production-rh6


# Email recipients
JOB_MAIL="ntoro@ebi.ac.uk"
STD_ERR="output/gene-groups-stderr.txt"
STD_OUT="output/gene-groups-stdout.txt"
LABEL="proteomes-data-unifier-gene-groups"
COMMAND="java -Xms1024m -Xmx4096m -jar ${project.build.finalName}.jar launch-data-unifier-gene-groups-job.xml proteinGeneGroupingJob -next"
CPUS=4

#submit to LSF
bsub -q ${QUEUE} -e ${STD_ERR} -o ${STD_OUT} -M 5000 -R "rusage[mem=5000]" -n ${CPUS} -R "span[hosts=1]" -J ${LABEL} -N -u ${JOB_MAIL} ${COMMAND}