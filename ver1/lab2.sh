cd compressed_files
zip_file=$(ls *.zip)
rar_file=$(ls *.rar)
tar_file=$(ls *.tar.gz)
[ -d "zip" ] || mkdir "zip"
[ -d "rar" ] || mkdir "rar"
[ -d "tar.gz" ] || mkdir "tar.gz"
[ -d "unknown" ] || mkdir "unknown"

echo $zip_file

for i in $zip_file
do
	mv $i zip/$i
done
for i in $rar_file
do
	mv $i rar/$i
done
for i in $tar_file
do
	mv $i tar.gz/$i
done
unknown_file=$(ls)
for i in $unknown_file
do
	if [ -f $i ];then
		mv $i unknown/$i
	fi
done
cd zip
zip_file=$(ls)
for i in $zip_file
do
	unzip $i
done
cd ..
cd rar
rar_file=$(ls)
for i in $rar_file
do
	unrar $i
done
cd ..
cd tar.gz
tar_file=$(ls)
for i in $tar_file
do
	tar $i
done
cd ..
