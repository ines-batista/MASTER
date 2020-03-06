#!/bin/bash

gtf=$1
OUTDir=$2
files="${@:3}"
#cd $folder


## 1. HTSeq-count tables
echo


#-t Feature type
#--stranded=no because we have not collected data with a strand-specific protocol
#-i ID attribute with which it will filter/ identify the selected feature type
#-f bam if we want to use BAM format instead of SAM [default]

fnames=` ls -1 *sam | paste -sd "\t" - `       #Store names of the sam files, separated by tab
echo "Building HTSeq-count tables for $fnames" 
fnames="gene_id\t$fnames"                      #Assigning gene_id to the first column

echo
echo "Building HTseq-count tables for exon feature"
htseq-count -t exon --stranded=no -i gene_id $files $gtf > $OUTDir"/exon.txt"
echo -e $fnames | cat - $OUTDir"/exon.txt" > $OUTDir"/exon_header.txt" #Assigning fnames to the header of output file

echo
echo "Building HTseq-count tables for CDS feature"
htseq-count -t CDS --stranded=no -i gene_id $files $gtf > $OUTDir"/CDS.txt"
echo -e $fnames | cat - $OUTDir"/CDS.txt" > $OUTDir"/CDS_header.txt"

echo
echo "Building HTseq-count tables for start_codon feature"
htseq-count -t start_codon --stranded=no -i gene_id $files $gtf > $OUTDir"/start_codon.txt"
echo -e $fnames | cat - $OUTDir"/start_codon.txt" > $OUTDir"/start_codon_header.txt"

echo
echo "Building HTseq-count tables for stop_codon feature"
htseq-count -t stop_codon --stranded=no -i gene_id $files $gtf > $OUTDir"/stop_codon.txt"
echo -e $fnames | cat - $OUTDir"/stop_codon.txt" > $OUTDir"/stop_codon_header.txt"

echo
echo "All HTSeq-count tables were built!"
echo
