#!/bin/bash

gtf=$1
OUTDir=$2
files="${@:3}"


## 1. HTSeq-count tables
echo


#-t Feature type
#--stranded=no because we have not collected data with a strand-specific protocol
#-i ID attribute with which it will filter/ identify the selected feature type
#-f bam if we want to use BAM format instead of SAM [default]

fnames=` ls -1 *sam | paste -sd "\t" - ` #falta adicionar gene_id ao início
echo "Building HTSeq-count tables for $fnames"


#Building HTSeq-count tables

echo
echo "Building HTSeq-count tables for 3_prime_UTR feature"
htseq-count -t three_prime_UTR --stranded=no -i Parent $files $gtf > $OUTDir"3primeUTR.txt"
(echo -e "Parent_id\t$fnames" && cat $OUTDir"3primeUTR.txt") > $OUTDir"3primeUTR_header.txt" && mv $OUTDir"3primeUTR_header.txt" $OUTDir"3primeUTR.txt"



echo
echo "Building HTSeq-count tables for 5_prime_UTR feature"
htseq-count -t five_prime_UTR --stranded=no -i Parent $files $gtf > $OUTDir"5primeUTR.txt"
(echo -e "Parent_id\t$fnames" && cat $OUTDir"5primeUTR.txt") > $OUTDir"5primeUTR_header.txt" && mv $OUTDir"5primeUTR_header.txt" $OUTDir"5primeUTR.txt"


echo
echo "Building HTSeq-count tables for CDS feature"
htseq-count -t CDS --stranded=no -i protein_id $files $gtf > $OUTDir"CDS.txt"
#htseq-count -t CDS --stranded=no -i ID --additional-attr=protein_id $files $gtf > $OUTDir"CDS.txt"
(echo -e "protein_id\t$fnames" && cat $OUTDir"CDS.txt") > $OUTDir"CDS_header.txt" && mv $OUTDir"CDS_header.txt" $OUTDir"CDS.txt"

#echo
#echo "Building HTSeq-count tables for chromosome feature"
#htseq-count -t chromosome --stranded=no -i gene_id $files $gtf > $OUTDir"chr.txt"
#echo -e $fnames | cat - $OUTDir"chr.txt" > $OUTDir"chr_header.txt"


echo
echo "Building HTSeq-count tables for exon feature"
htseq-count -t exon --stranded=no -i exon_id $files $gtf > $OUTDir"exon.txt"
(echo -e "exon_id\t$fnames" && cat $OUTDir"exon.txt") > $OUTDir"exon_header.txt" && mv $OUTDir"exon_header.txt" $OUTDir"exon.txt"


echo
echo "Building HTSeq-count tables for gene feature"
htseq-count -t gene --stranded=no -i gene_id $files $gtf > $OUTDir"gene.txt"
#htseq-count -t gene --stranded=no -i gene_id $files $gtf > $OUTDir"gene.txt"
#htseq-count -t gene --stranded=no -i gene_id --nonunique all $files $gtf > $OUTDir"gene_nonuniqueALL.txt"
#htseq-count -t gene --stranded=no -i gene_id --nonunique all $files $gtf > $OUTDir"gene_nonuniqueALL.txt"
(echo -e "gene_id\t$fnames" && cat $OUTDir"gene.txt") > $OUTDir"gene_header.txt" && mv $OUTDir"gene_header.txt" $OUTDir"gene.txt"


echo
echo "Building HTSeq-count tables for lncRNA feature"
htseq-count -t lnc_RNA --stranded=no -i transcript_id $files $gtf > $OUTDir"lncRNA.txt"
(echo -e "transcript_id\t$fnames" && cat $OUTDir"lncRNA.txt") > $OUTDir"lncRNA_header.txt" && mv $OUTDir"lncRNA_header.txt" $OUTDir"lncRNA.txt"


#echo
#echo "Building HTSeq-count tables for micro_RNA feature"
#htseq-count -t miRNA --stranded=no -i ID --additional-attr=transcript_id $files $gtf > $OUTDir"microRNA.txt"
#echo -e $fnames | cat - $OUTDir"microRNA.txt" > $OUTDir"microRNA_header.txt"

echo
echo "Building HTSeq-count tables for mRNA feature"
htseq-count -t mRNA --stranded=no -i transcript_id $files $gtf > $OUTDir"mRNA.txt"
(echo -e "transcript_id\t$fnames" && cat $OUTDir"mRNA.txt") > $OUTDir"mRNA_header.txt" && mv $OUTDir"mRNA_header.txt" $OUTDir"mRNA.txt"


#echo
#echo "Building HTSeq-count tables for ncRNA feature"
#htseq-count -t ncRNA --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"ncRNA.txt"
#echo -e $fnames | cat - $OUTDir"ncRNA.txt" > $OUTDir"ncRNA_header.txt"

echo
echo "Building HTSeq-count tables for ncRNA_gene feature"
htseq-count -t ncRNA_gene --stranded=no -i gene_id $files $gtf > $OUTDir"ncRNAgene.txt"
(echo -e "gene_id\t$fnames" && cat $OUTDir"ncRNAgene.txt") > $OUTDir"ncRNAgene_header.txt" && mv $OUTDir"ncRNAgene_header.txt" $OUTDir"ncRNAgene.txt"


#echo
#echo "Building HTSeq-count tables for pseudogene feature"
#htseq-count -t pseudogene --stranded=no -i gene_id $files $gtf > $OUTDir"pseudogene.txt"
#echo -e $fnames | cat - $OUTDir"pseudogene.txt" > $OUTDir"pseudogene_header.txt"

#echo
#echo echo "Building HTSeq-count tables for pseudongenic_transcript feature"
#htseq-count -t pseudogenic_transcript --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"pseudogenicTranscript.txt"
#echo -e $fnames | cat - $OUTDir"pseudogenicTranscript.txt" > $OUTDir"pseudogenicTranscript_header.txt"


echo
echo "Building HTSeq-count tables for rRNA feature"
htseq-count -t rRNA --stranded=no -i transcript_id $files $gtf > $OUTDir"rRNA.txt"
(echo -e "transcript_id\t$fnames" && cat $OUTDir"rRNA.txt") > $OUTDir"rRNA_header.txt" && mv $OUTDir"rRNA_header.txt" $OUTDir"rRNA.txt"


echo
echo "Building HTSeq-count tables for tRNA feature"
htseq-count -t tRNA --stranded=no -i transcript_id $files $gtf > $OUTDir"tRNA.txt"
(echo -e "transcript_id\t$fnames" && cat $OUTDir"tRNA.txt") > $OUTDir"tRNA_header.txt" && mv $OUTDir"tRNA_header.txt" $OUTDir"tRNA.txt"


echo
echo "All HTSeq-count tables were built!"
echo