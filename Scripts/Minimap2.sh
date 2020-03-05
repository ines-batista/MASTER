#!/bin/bash

today=` date +%Y_%m_%d `

## 0. Storing args as vars
refGenome=$1 #dir/to/reference/Genome"
RefGenoV=$2 #version of the reference genome Ex.: danRer11
DataV=$3 #version of data OR identifier of raw data Ex.: V1
RAWdata="${@:4}"

#0.1. Needed Scripts
mmiScript=$HOME"/Projects/InesBatista_MSc/Scripts/Minimap2index.sh"
alignScript=$HOME"/Projects/InesBatista_MSc/Scripts/Minimap2align.sh"


## 1. Minimap2 indexing
$mmiScript $refGenome


## 2. Minimap2 alignment
#2.1. Generating output directory
OUTDir="/home/mafalda/Projects/InesBatista_MSc/minimapOUT/"$today"_"$RefGenoV"/"$DataV"/"
mkdir -p $OUTDir #-p because it is created a dir inside another dir

#2.2. Aligning
idx="$refGenome.mmi"
for arg in $RAWdata; do
	#if it's directory
	if [ -d "$arg" ]; then #check if arg is a directory
		for file in $RAWdata/*.gz; do #assuming raw data is a .gz file				
			$alignScript $idx $file $OUTDir
		done
	#if it's file
	elif [ -f "$arg" ]; then #check if arg is file
		$alignScript $idx $arg $OUTDir
	fi
done