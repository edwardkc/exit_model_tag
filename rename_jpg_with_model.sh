#!/bin/sh

#Adding Model name at the end of filename
#If EXIF Model tag does not exit, do nothing
#If EXIF Model tag contains space, just getting the last word

for f in *.jpg; do
	#echo "reading $f ..."
	model=`exif --tag=Model --ifd=0 --machine-readable $f 2>/dev/null`
	if [ "$?" -eq "0" ]; then
		model=`echo $model | awk '{print $NF}'`
		filename=`echo $f | sed 's/\.jpg$//'`
		filename="${filename}_${model}.jpg"
		echo -e "Rename \e[36m${f}\e[0m to \e[32m${filename}\e[0m"
		mv ${f} ${filename}
	else
		echo -e "\e[31mskip $f .... no Model found in\e[0m"
	fi
done
