classification(){
	if [ "${1}" = "unknown" ];then
		file=$(ls compressed_files)
	else
		file=$(ls compressed_files/*.$1)
	fi
	echo $file
	[ -d "compressed_files/$1" ] || mkdir compressed_files/$1
	
	for i in $file
	do
 		mv $i compressed_files/$1/${i##*/}
	done
}
classification zip
classification rar
classification tar.gz
classification unknown
