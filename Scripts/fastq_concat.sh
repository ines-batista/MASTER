#!/bin/bash
# Define a partition where it is going to be executed
#SBATCH -p level3
# Define number of nodes
#SBATCH -N 1
# Define number of cores
#SBATCH -n 1
# Set max wallclock time (max time which this job has to be executed. If not defined applies partition walltime)
#SBATCH --time=10:00:00
# Set name of job
#SBATCH --job-name=ensembl_wget
# Mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL
# Send mail to this address
#SBATCH --mail-user=inesbrbs.batista@gmail.com
# Set memory pool for all cores
#SBATCH --mem 100

# Load modules
#module load <module>

# Run the application
cd ~/RawData/SepRun/
mkdir all-reads
cd RUN30V3/

#07: ZF_RNAseq-I_1_1-1-1-RUN_RNAzeb
#08: ZF_RNAseq-I_2_2-1-1-RUN_RNAzeb
#09: ZF_RNAseq-I_3_3-1-1-RUN_RNAzeb
#10: ZF_RNAseq-B_1_1-1-1-RUN_RNAzeb
#11: ZF_RNAseq-B_2_2-1-1-RUN_RNAzeb
#12: ZF_RNAseq-B_3_3-1-1-RUN_RNAzeb

cp -vp *{7,8,9,10,11,12}.fastq.gz ../all-reads
cd ../all-reads
mv barcode07.fastq.gz > ZF_RNAseq-I_1_1-1-1-RUN_RNAzeb.fastq.gz
mv barcode08.fastq.gz > ZF_RNAseq-I_2_2-1-1-RUN_RNAzeb.fastq.gz
mv barcode09.fastq.gz > ZF_RNAseq-I_3_3-1-1-RUN_RNAzeb.fastq.gz
mv barcode10.fastq.gz > ZF_RNAseq-B_1_1-1-1-RUN_RNAzeb.fastq.gz
mv barcode11.fastq.gz > ZF_RNAseq-B_2_2-1-1-RUN_RNAzeb.fastq.gz
mv barcode12.fastq.gz > ZF_RNAseq-B_3_3-1-1-RUN_RNAzeb.fastq.gz
gzip -d *.gz

cd ../RUN30R2V3
cp -vp *{7,8,9,10,11,12}.fastq.gz ../all-reads
cd ../all-reads
gzip -d *.gz
cat barcode07.fastq >> ZF_RNAseq-I_1_1-1-1-RUN_RNAzeb.fastq
cat barcode08.fastq >> ZF_RNAseq-I_2_2-1-1-RUN_RNAzeb.fastq
cat barcode09.fastq >> ZF_RNAseq-I_3_3-1-1-RUN_RNAzeb.fastq
cat barcode10.fastq >> ZF_RNAseq-B_1_1-1-1-RUN_RNAzeb.fastq
cat barcode11.fastq >> ZF_RNAseq-B_2_2-1-1-RUN_RNAzeb.fastq
cat barcode12.fastq >> ZF_RNAseq-B_3_3-1-1-RUN_RNAzeb.fastq

