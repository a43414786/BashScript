file=$(ls compressed_files)
[ -f "wrong_list" ] && rm wrong_list
[ -f "missing_list" ] && rm missing_list
for i in $file
do
	if [ ${i#*.} != "zip" ] && [ ${i#*.} != "rar" ] && [ ${i#*.} != "tar.gz" ];then
		echo $i >> wrong_list
	fi
done

mkdir temp
student_id=$(sort student_id)
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
missinglist=$(ls temp)
for i in $missinglist
do
	echo $i >> missing_list
done

rm -r temp

