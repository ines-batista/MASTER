#!/bin/bash

data=` date +%Y_%m_%d `

### Storage of reference genome and respective gff3 files
##(do not forget to check if extension is .fa.gz)
#echo
echo Please insert the directories for the following:
read -p 'Raw Data: ' RawData
read -p 'Reference Genome File: ' danRer
read -p 'Reference Genome Version: ' VERSION
#read -p 'Idx Genome File: ' idx
#read -p 'GTF file: ' gtf
##read -p 'Version: ' version
#
echo Input data is now stored!
echo =========================
#
#
### Minimap index, one for dan10 one for dan11:
##(do not forget to check if extension is .fa.gz)
echo
echo Indexing reference genome...
if [[ $danRer == *.f[aq].gz ]]
then
	minimap2 -d ${danRer/.gz/.mmi} $danRer
	idx=${danRer/.gz/.mmi}
elif [[ $danRer == *.f[aq] ]]
then
	minimap2 -d ${danRer/.f[aq]/.mmi} $danRer
	idx=${danRer/.f[aq]/.mmi}
else
	echo Please enter a valid format file for the reference genome and try again.
	exit 1
fi
echo
echo The outputted file is now stored at:
#echo $idx
echo =========================
#
echo


## Going to dir where raw data is stored: 
cd $RawData

OutDir="/home/mafalda/Projects/InesBatista_MSc/minimapOUT/"$data"/danRer"$VERSION
mkdir $OutDir
for run in ` ls ` #to search through ls without print
do
	echo ===============================================================
	echo "                    Data Alignment - $run"
	echo ===============================================================
	FileX=$OutDir"/"$run"/NrReads_"$run".txt"
	rm $FileX 	
	for version in ` ls $run `
	do
		echo
		echo =========================
		echo "====== Version: $version ======"
		echo		
		OUTDataV=$OutDir"/"$run"/"$version
		mkdir -p $OUTDataV
		
		for file in ` ls $run"/"$version"/DATAfastq" | grep ".gz" `
		do
			#if [[ $folder == 'DATAfastq' ]]
			#then
				#echo "Folder: $folder"
				#for file in ` ls $run"/"$version"/"$folder `
				#do
					echo "File: $file"
					echo
					echo "Counting number of reads..."
					#if [[ $file == *.gz ]]
					#then
					zcat < $run"/"$version"/DATAfastq/"$file | wc -l >> $FileX  #Appends result to FileX
					#else
					#	cat $run"/"$version"/"$folder"/"$file | $(( ` wc -l /4 ` )) >> $FileX
					#fi
					echo
					echo "Aligning $file with minimap2 against $danRer"
					#Generating alignments
					minimap2 -ax splice $idx $run"/"$version"/DATAfastq/"$file > ${file/.fast[aq].gz/.sam} 
					echo "Converting SAM to BAM..."					
					samtools view -S ${file/.fast[aq].gz/.sam} -b > ${file/.fast[aq].gz/.bam}				
					samtools sort ${file/.fast[aq].gz/.bam} > ${file/.fast[aq].gz/.sorted.bam}
					samtools index ${file/.fast[aq].gz/.sorted.bam}					
					echo					
					echo "$file successfully aligned!"
					echo =========================
					echo
				#done			
			#else 
			#	continue			
			#fi
			mv *.[bs]am -t $OUTDataV
		
		done
		
	done	
	nReads=$( paste -sd+ $FileX | bc )
	let nReads=$nReads/4
	echo "$nReads reads from $run successfully mapped!"
	echo =========================================================
	echo
done

export gtf
./Test1.sh