files="$(ls compressed_files)"
echo $files
for i in $files
do
	if [ -f "compressed_files/$i" ];then
		echo $i
	fi
done

ids=$(cat student_id)
for i in $ids
do
	echo $i
done
