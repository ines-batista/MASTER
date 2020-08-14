#!/bin/bash

gtf=$1
OUTDir=$2
INDir=$3

cd $INDir
fnames=` ls -1 *[12].bam | paste -sd "\t" - `

echo
echo "Counting reads of $fnames"

echo
echo "Building tables for gene feature using featureCounts"
featureCounts -a $gtf -F GTF -t gene -g gene_id -o $OUTDir/gene.txt *[12].bam

echo
echo "Building tables for exon feature using featureCounts"
featureCounts -a $gtf -F GTF -t exon -g gene_id -o $OUTDir/exon.txt *[12].bam

echo
echo "Building tables for CDS feature using featureCounts"
featureCounts -a $gtf -F GTF -t CDS -g gene_id -o $OUTDir/CDS.txt *[12].bam

echo
echo "Building tables for transcript feature using featureCounts"
featureCounts -a $gtf -F GTF -t transcript -g gene_id -o $OUTDir/transcript.txt *[12].bam