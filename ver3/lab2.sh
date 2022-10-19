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
		echo ${i%%.*} >> wrong_list
	fi
done
#End make wrong_list
echo End make wrong_list

#Start make missing_list
echo Start make missing_list
mkdir temp
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

#Function for classified files type
classification(){
	if [ "${1}" = "unknown" ];then
		file=$(ls compressed_files)
	else
		file=$(ls compressed_files/*.$1)
	fi
	[ -d "compressed_files/$1" ] || mkdir compressed_files/$1
	
	
	if [ "${1}" = "unknown" ];then
		for i in $file
		do
			if [ -f "compressed_files/$i" ];then
	 			mv compressed_files/$i compressed_files/$1/${i##*/}
			fi
		done
	else
		for i in $file
		do
	 		mv $i compressed_files/$1/${i##*/}
		done
	fi
}
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

#Start classified
echo Start classified
classification zip
classification rar
classification tar.gz
classification unknown
#End classified
echo End classified

#Start uncompress
echo Start uncompress
uncompress zip
uncompress rar
uncompress tar.gz
#End uncompress
echo End uncompress

