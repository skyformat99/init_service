#!/bin/sh

# ����sql�ű�
#������ȡ
inputFile=$1
host=$2
user=$3
passwd=$4
dbname=$5

if [ "" = "$inputFile" ];then
    echo "please input filename"
    exit 0
fi

if [ "" = "$host" ];then
    echo "please input db address"
    exit 0
fi

if [ "" = "$user" ];then
    echo "please input db username"
    exit 0
fi

if [ "" = "$passwd" ];then
    echo "please input db password"
    exit 0
fi
if [ "" = "$dbname" ];then
    echo "please input db name"
    exit 0
fi

curDir=$PWD
cd $curDir

serviceInit=$(date +%Y%m%d%T)".sql"
echo "insert into t_service_list(serviceName) values " > $serviceInit;

while read line
do
    values="('"${line//,/\'),(\'}"'),";
    echo $values >> $serviceInit;
done < $inputFile;
#ɾ�����һ�е�����Ǹ�,
sed -i '$s/,$//' $serviceInit

# ���뵽mysql
mysql -h$host -u$user -p$passwd $dbname < $serviceInit

#ɾ����ʱsql�ļ�
rm -rf $serviceInit
echo "Data import successfully"
