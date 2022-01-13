#!/bin/bash
echo
if [ "$#" -eq 0 ]
then echo "Enter the filename of Apache log"
exit 1
else
input_file=$1
#input_file="apache_logs.txt"
result=`cat "$input_file"`
requests=`echo "$result" | awk '{print$1}' | uniq -c | sort -gr`
echo "--The most of requests were from IP:"
echo -e '\tCOUNT\tADDRESS'
echo $requests | awk '{print "\t" $1, "\t"$2}'
#echo $requests
webpage=`echo "$result" | grep -o 'GET.* H'| cut -c5- | cut -d " " -f 1 | sort | uniq -c | sort -gr`
echo "--The most requested webpage"
echo -e '\tCOUNT\tWEBPAGE'
echo $webpage | awk '{print "\t" $1, "\t"$2}'
echo "--Error codes:"
echo -e '\tCOUNT\tCODE'
echo -e -o "\t$webpage" | grep "error"
req_time=`echo "$result" | grep -o '..:..:.. ' | sort | uniq -c | sort -gr`
echo "--Most requests were made at"
echo $req_time | awk '{print "\t" $2}'
bots=`echo "$result" | grep -o '+http[^)]\+' | sort | uniq | awk -F '/' '{print $3}'`
echo "--Searchbots"
for bot in $bots
do
    echo $bot
    nslookup $bot | grep 'Address'| grep -v '#'
    echo
done
fi