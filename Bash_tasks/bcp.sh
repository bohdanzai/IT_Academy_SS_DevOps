#! /bin/bash
if [ "$#" -le 1 ]
then echo "Enter two parameters. 1 - source folder; 2 - destination folder;"
exit 1
else
f_source="$1"
f_destination="$2"
[ "${f_destination: -1}" == "/" ] && f_destination=${f_destination::-1}
echo $f_destination
difference=`diff -r $1 $2`
returncode=`echo $?`
chk_time=`date`
echo $returncode
if [ $returncode -eq 1 ]
then
    echo -e "\n $chk_time" >> log.txt
    echo -e "Files have been changed\n$difference\n" >> log.txt
    rsync -avh $f_source $f_destination --delete >> log.txt
else
    echo -e "$chk_time\nFiles are the same\n" >> log.txt
fi
fi
