#!/bin/bash
cd /home/mafalda/Projects/InesBatista_MSc/minimapOUT

echo ===============================================================
echo "                 Building HTSeq-count Tables"
echo ===============================================================

set -uxe -o pipefail 
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
gtf=$2
OUTDir=$3

#OUTF=`basename "$miniData"`

#0.1. Needed Scripts
tableScript="/home/mafalda/Projects/InesBatista_MSc/Scripts/HTSeq-count.sh"


## 1. Output dir
#OUTDir="home/mafalda/Projects/InesBatista_MSc/htseqOUT/"$OUTF"/"
mkdir -p $OUTDir


## 2. HTSeq-count tables:
#[2DO] It is doing a table for each sam file and we want one table per version (12 .SAM files)

#for version in ` ls $miniData `; do #V1, V2, V3
#	echo "Storing .sam files from $version"
#	files="$(find $miniData/$version/*.sam)"
#	echo $files
#	OUTDir=$OUTDir$version"/"
#	mkdir -p $OUTDir
cd $miniData
files="$(find $miniData/*.sam)"
$tableScript $gtf $OUTDir $files 
#done