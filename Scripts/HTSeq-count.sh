#!/bin/bash

files=$1
OUTDir=$2
gtf=$3

cd $folder


## 1. HTSeq-count tables
echo
echo "Building HTSeq-count tables for $files files"

#-t Feature type
#--stranded=no because we have not collected data with a strand-specific protocol
#-i ID attribute with which it will filter/ identify the selected feature type
#-f bam if we want to use BAM format instead of SAM [default]


#htseq-count -t CDS --stranded=no -i ID --additional-attr=protein_id $files $gtf > $OUTDir"CDS.txt"
#htseq-count -t chromosome --stranded=no -i gene_id $files $gtf > $OUTDir"chromosome.txt"

htseq-count -t exon --stranded=no -i exon_id $files $gtf > $OUTDir"exon.txt"

#htseq-count -t five_prime_UTR --stranded=no -i Parent $files $gtf > $OUTDir"5primeUTR.txt"

htseq-count -t gene --stranded=no -i gene_id $files $gtf > $OUTDir"gene.txt"
htseq-count -t gene --stranded=no -i gene_id --nonunique all $files $gtf > $OUTDir"gene_nonuniqueALL.txt"

htseq-count -t lnc_RNA --stranded=no -i ID --additional-attr=transcript_id $files $gtf > $OUTDir"lncRNA.txt"

htseq-count -t miRNA --stranded=no -i ID --additional-attr=transcript_id $files $gtf > $OUTDir"microRNA.txt"
htseq-count -t mRNA --stranded=no -i ID --additional-attr=transcript_id $files $gtf > $OUTDir"mRNA.txt"

htseq-count -t ncRNA --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"ncRNA.txt"
htseq-count -t ncRNA_gene --stranded=no -i gene_id --additional-attr=gene_id $files $gtf > $OUTDir"ncRNAgene.txt"

#htseq-count -t pseudogene --stranded=no -i gene_id $files $gtf > $OUTDir"pseudogene.txt"
#htseq-count -t pseudogenic_transcript --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"pseudogenicTranscript.txt"

htseq-count -t rRNA --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"rRNA.txt"

#htseq-count -t scaffold --stranded=no -i gene_id $files $gtf > $OUTDir"scaffold.txt"
#htseq-count -t scRNA --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"scRNA.txt"
#htseq-count -t snoRNA --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"snoRNA.txt"
#htseq-count -t snRNA --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"snRNA.txt"

#htseq-count -t three_prime_UTR --stranded=no -i Parent $files $gtf > $OUTDir"3primeUTR.txt"
#htseq-count -t tRNA --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"tRNA.txt"

htseq-count -t unconfirmed_transcript --stranded=no -i gene_id --additional-attr=transcript_id $files $gtf > $OUTDir"unconfTranscript.txt"

echo