idx=$1
file=$2
OUTDir=$3

echo
filename="$(basename -- $file)"
idxname="$(basename -- $idx)"
echo "Aligning $filename against $idxname with Minimap2..."
minimap2 -ax splice $idx $file > $OUTDir${filename/.fast[aq].gz/.sam} 
samtools view -S $OUTDir${filename/.fast[aq].gz/.sam} -b > $OUTDir${filename/.fast[aq].gz/.bam}
samtools sort $OUTDir${filename/.fast[aq].gz/.bam} > $OUTDir${filename/.fast[aq].gz/.sorted.bam}
samtools index $OUTDir${filename/.fast[aq].gz/.sorted.bam} > $OUTdir${filename/.fast[aq].gz/.sorted.bai}
echo
echo "$filename successfully aligned!"
			