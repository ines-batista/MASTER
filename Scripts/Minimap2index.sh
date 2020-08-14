#check for minimap2 index
refGenome=$1
idx=${refGenome/.fa.gz/.mmi}

echo
echo "Verifying if .mmi file exists..."
if [ -f "$idx" ]; then
	idxName="$(basename -- $idx)"
	echo "$idxName already exists!"
	echo
else
	echo	
	echo "Building minimap2 index for $refGenome"
	minimap2 -d $idx $refGenome
	echo "Minimap2 index done!"
	echo
fi
