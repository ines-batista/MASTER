#!/bin/bash

today=` date +%Y_%m_%d `

## 0. Storing args as vars
refGenome=$1 #dir/to/reference/Genome"
OUTDir=$2 #dir/to/output/files"
#RefGenoV=$2 #version of the reference genome Ex.: danRer11
#DataV=$3 #version of data OR identifier of raw data Ex.: V1

RAWdata="${@:3}"

#0.1. Needed Scripts
mmiScript=$HOME"/Documents/MASTER/Scripts/Minimap2index.sh"
alignScript=$HOME"/Documents/MASTER/Scripts/Minimap2align.sh"


## 1. Minimap2 indexing
$mmiScript $refGenome


## 2. Minimap2 alignment
#2.1. Generating output directory

mkdir -p $OUTDir"/fastqc/" #-p to allow create dir inside another dir

#2.2. Aligning
idx=${refGenome/.fa.gz/.mmi}
for arg in $RAWdata; do
	#if it's directory
	if [ -d "$arg" ]; then #check if arg is a directory
		for file in $RAWdata/*.gz; do #assuming raw data is a .gz file	
			echo $file			
			$alignScript $idx $file $OUTDir
		done
	#if it's file
	elif [ -f "$arg" ]; then #check if arg is file
		$alignScript $idx $arg $OUTDir
	fi
done