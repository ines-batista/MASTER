#!/bin/bash

echo ===============================================================
echo "                 Building HTSeq-count Tables"
echo ===============================================================

#set -uxe -o pipefail 
#-ue: by setting both -e and -u, the script will exit on an Error or 
#if an Unset variable is referenced.
#-x: Print a trace of simple commands and their arguments after they 
#are expanded and before they are executed."
#pipefail: If set, the return value of a pipeline is the value of the 
#last (rightmost) command to exit with a non-zero status, or zero if 
#all commands in the pipeline exit successfully. By default, pipelines
#only return a failure if the last command errors."


## 0. Storing args as vars
miniData=$1 #Give a Directory where is stored minimapOUT data
gff=$2
OUTDir=$3


#0.1. Needed Scripts
countScript=$HOME"/Documents/MASTER/Scripts/HTSeq-count.sh"


## 1. Output dir
mkdir -p $OUTDir


## 2. HTSeq-count tables:
cd $miniData
#SAMfiles="$(find *sam)"
#$countScript $gff $OUTDir $SAMfiles 


## 3. To get the unmapped reads from the BAM files:
echo
echo "Storing unmapped reads in unmapped.sam..."
BAMfiles="$(find *[12].bam)"
for file in $BAMfiles; do
	samtools view -f 4 $file >> $OUTDir"unmapped.sam"
done

echo
echo "Building the fastqc report of unmapped reads..." 
fastqc $OUTDir"unmapped.sam" -o $OUTDir

echo
echo ===============================================================
echo "                      Process Complete!"
echo ===============================================================