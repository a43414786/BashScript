#!/bin/bash

wrong_list=""
missing_list=""
file=$(ls compressed_files)
student_id=$(sort student_id)

#Start make wrong_list
echo Start make wrong_list
[ -f "wrong_list" ] && rm wrong_list
[ -f "missing_list" ] && rm missing_list
for i in $file
do
	if [ ${i#*.} != "zip" ] && [ ${i#*.} != "rar" ] && [ ${i#*.} != "tar.gz" ];then
		wrong_list="$wrong_list ${i%%.*}"
	fi
done
echo $wrong_list > wrong_list
#End make wrong_list
echo End make wrong_list

#Start make missing_list
echo Start make missing_list
[ -d temp ] || mkdir temp
for i in $student_id;
do
	echo 0 > temp/$i;
done
for i in $file
do
	if [ -f "temp/${i%%.*}" ];then
		rm temp/${i%%.*}
	fi
done
list=$(ls temp)
for i in $list
do
	missing_list="$missing_list $i"
done
rm -r temp
echo $missing_list > missing_list
#End make missing_list
echo End make missing_list
#Start classified files type
echo Start classified files type

fileDir=compressed_files
[ -d $fileDir/zip ] || mkdir $fileDir/zip
[ -d $fileDir/rar ] || mkdir $fileDir/rar
[ -d $fileDir/tar.gz ] || mkdir $fileDir/tar.gz
[ -d $fileDir/unknown ] || mkdir $fileDir/unknown
list=$(ls $fileDir)
for i in $list
do
	if [ -f $fileDir/$i ]; then
		type=${i#*.}
		if [ $type = "zip" ]; then
			mv $fileDir/$i $fileDir/zip/$i
		elif [ $type = "rar" ]; then
			mv $fileDir/$i $fileDir/rar/$i
		elif [ $type = "tar.gz" ]; then
			mv $fileDir/$i $fileDir/tar.gz/$i
		else
			mv $fileDir/$i $fileDir/unknown/$i
		fi
	fi
done
#End classified files type
echo End classified files type
#Function for uncompress files
uncompress(){
	file=$(ls compressed_files/$1/*.$1)
	dst=compressed_files/$1
	if [ ${1} = "zip" ];then
		for i in $file
		do
			unzip $i -d $dst > /dev/null
		done
	elif [ ${1} = "rar" ];then
		for i in $file
		do
			unrar x $i $dst > /dev/null
		done
	elif [ ${1} = "tar.gz" ];then
		for i in $file
		do
			tar -C $dst -xzvf $i > /dev/null
		done
	fi
}

#Start uncompress
echo Start uncompress
uncompress zip
uncompress rar
uncompress tar.gz
#End uncompress
echo End uncompress

