#!/bin/bash

#Test OS : CentOS 7.2
#Date : 2019.06.26
#Version : 1.0
#Comment : 기반시설 점검항목 적용 아파치 제외
#          서버의 홈디렉토리 제거된 버전

LANG=C
export LANG
source /etc/profile

Release_file="/etc/redhat-release"
Release_Version=`cat $Release_file | grep -o '[0-9]' | head -n1`
if [ $Release_Version -eq 5 ] || [ $Release_Version -eq 6 ]
	then
		#OS_Version=6
		D_type=1
	elif [ `cat $Release_file | grep -o '[0-9]' | head -n1` -eq 7 ]; then
		#OS_Version=7
		D_type=2
	else
		echo "Please check OS Version"
		exit 1;
fi


case $D_type in

1)

echo ""
echo "Version is 6(5)"
echo "==============================  START  ==============================" 
echo ""


IP=`ip addr | grep -w "inet" | grep -v "127.0.0.1" | head -1 | awk '{print $2}' | awk -F/ '{print $1}'`


RESULT_FILE=./Linux@@`hostname`@@$IP.txt

echo "===============  Linux Server Security Check  ===============" > $RESULT_FILE 2>&1
echo >> $RESULT_FILE 2>&1
echo "GSSHOP STANDARD SCRIPT" >> $RESULT_FILE 2>&1
echo >> $RESULT_FILE 2>&1
echo >> $RESULT_FILE 2>&1



echo [U-1]root 계정 원격 접속 제한
echo "============================================================" >> $RESULT_FILE 2>&1
echo [U-1]root 계정 원격 접속 제한  >> $RESULT_FILE 2>&1
echo "============================================================" >> $RESULT_FILE 2>&1
echo [1-START] >> $RESULT_FILE 2>&1
if [ `find /etc -type f -name "sshd_config" | wc -l` -eq 0 ]
	then
		echo "★ sshd_config 파일을 찾을 수 없음" >> $RESULT_FILE 2>&1
		echo [1-END] >> $RESULT_FILE 2>&1
		echo >> $RESULT_FILE 2>&1
		echo [U-1]Result : MANUAL >> $RESULT_FILE 2>&1
	else
		SSHCONFIG=`find /etc -type f -name "sshd_config"`
		if [ `grep -i "permitrootlogin" $SSHCONFIG | grep -v "setting" | grep -v "#" | grep -i "no" | wc -l` -eq 0 ]
			then
				echo "★ root 계정 원격 접속이 제한되지 않음" >> $RESULT_FILE 2>&1
				echo "[현황]" >> $RESULT_FILE 2>&1
				grep -i "permitrootlogin" $SSHCONFIG | grep -v "setting" | grep -v "without" >> $RESULT_FILE 2>&1
				echo [1-END] >> $RESULT_FILE 2>&1
				echo >> $RESULT_FILE 2>&1
				echo [U-1]Result : VULNERABLE >> $RESULT_FILE 2>&1
				
			else
				echo "★ root 계정 원격 접속이 제한됨" >> $RESULT_FILE 2>&1
				echo "[현황]" >> $RESULT_FILE 2>&1
				grep -i "permitrootlogin" $SSHCONFIG | grep -v "setting" | grep -v "without" >> $RESULT_FILE 2>&1
				echo [1-END] >> $RESULT_FILE 2>&1
				echo >> $RESULT_FILE 2>&1
				echo [U-1]Result : GOOD >> $RESULT_FILE 2>&1
		fi
fi