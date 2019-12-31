#!/bin/bash

#/usr/local/jdk1.8.0_181/bin/java -jar interconnection-dev-1.0.0-RELEASE.jar &  $! > opentsdb.pid

home='/home/JTBHL/jdk1.8.0_181';

file='interconnection';
operation='start';
environment='prd';

version='1.0.0-RELEASE';

app_name='interconnection';

while getopts ":h:v:e:n:o:" opt; 
do
	case $opt in
		h)
			home=$OPTARG
		;;
		v)
			version=$OPTARG
		;;
		e)
			environment=$OPTARG
		;;
		n)
			app_name=$OPTARG
		;;
		o)
			operation=$OPTARG
	esac 
done

if [ ${operation} != 'start' ] 
then
	PID=$(cat ${app_name}/pid.txt)
	kill -9 ${PID}
	echo "停止成功"
	exit 1
elif  [ -e $file ]
then
	echo "开始执行"
else
	echo "开始创建文件"
	mkdir ${app_name}
	echo "开始执行"
fi
nohup ${home}/bin/java -jar ${app_name}-${environment}-${version}.jar > ${app_name}/consoleLog.log 2>&1 &
echo $! > ${app_name}/pid.txt
PID=$(cat ${app_name}/pid.txt)
echo "启动完成 pid:${PID}"

#kill -9 $PID
