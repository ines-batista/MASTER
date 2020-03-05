#!/bin/bash
cd /home/mafalda/Projects/InesBatista_MSc/minimapOUT

echo ===============================================================
echo "                 Building HTSeq-count Tables"
echo ===============================================================

set -uxe -pipefail

## 0. Storing args as vars
miniData=$1 #Give a Directory where is stored minimapOUT data
gtf=$2
#OUTF=$3
OUTF=`basename "$miniData"`

#0.1. Needed Scripts
tableScript=$HOME"/Projects/InesBatista_MSc/Scripts/HTSeq-count.sh"


## 1. Output dir
OUTDir=$HOME"/Projects/InesBatista_MSc/htseqOUT/"$OUTF"/"
mkdir -p $OUTDir


## 2. HTSeq-count tables:
#[2DO] It is doing a table for each sam file and we want one table per version (12 .SAM files)
for version in ` ls $miniData `; do #V1, V2, V3
	echo "Storing .sam files from $version"
	files="$(find $miniData/$version/*.sam)"
	echo $files
	OUTDir=$OUTDir$version"/"
	mkdir -p $OUTDir
	$tableScript $files $OUTDir $gtf 
done