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
uncompress(){
	file=$(ls compressed_files/$1/*.$1)
	echo $file
	dst=compressed_files/$1
	if [ ${1} = "zip" ];then
		for i in $file
		do
			unzip $i -d $dst
		done
	elif [ ${1} = "rar" ];then
		for i in $file
		do
			unrar x $i $dst
		done
	elif [ ${1} = "tar.gz" ];then
		for i in $file
		do
			tar -C $dst -xzvf $i
		done
	fi
}

classification zip
classification rar
classification tar.gz
classification unknown
uncompress zip
uncompress rar
uncompress tar.gz
