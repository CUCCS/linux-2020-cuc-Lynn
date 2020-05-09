#!/usr/bin/env bash

LANG=en_US.UTF-8

#帮助信息
function helpInfo {
	echo -e "weblog.sh - For Web Client Access Log Analysing.\n"
	echo -e "Tips: Before using this script, making sure the web_log.tsv file is in the working directory\n"
	echo "Usage: bash weblog.sh [arguments]"
	echo "Arguments:"
	echo "  -o <num>		: Top num hosts and appearing times."
	echo "  -i <num>		: Top num IP and appearing times."
	echo "  -u <num>		: Top num URL accessed most frequently"
	echo "  -r       		: Appearing times and ratio of diffrent response status code"
	echo "  -u4 <num>		: Top num URL and appearing times by diffrent 4XX status code"
	echo "  -uh <num><URL>	: Given URL, print top num hosts accessed"
	echo "  -h or --help	: Print Help (this message) and exit."
}

#数据文件表头: host	logname	time	method	url	response	bytes	referer	useragent

#统计访问来源主机TOP 100和分别对应出现的总次数
function HostTop {
	#$1--file, $2--num
	file=$1
	num=$2

       	#sed 读取文件内容到模式空间并删除第一行表头
	#awk以TAB为分隔符，得到sed输文本出的第一项host
	#sort默认是从小到大，uniq -c表示显示该主机重复出现的次数
	#-n 按数值大小排序 -r逆序
	#head -n指定显示行数

	host=$(sed '1d' "$file" | awk -F '\t' '{print $1}' | sort | uniq -c | sort -nr | head -n $num)
	echo -e "Top ${num} Host:\n${host}\n"  >> HostTop.log
	cat HostTop.log
}

#统计访问来源主机TOP 100 IP和分别对应出现的总次数
function IpTop {
	#$1--file, $2--num
	file=$1
	num=$2

	#awk识别ip并统计出现次数
	# ~ 匹配正则表达式 END语句块在读完所有行后执行
	IP=$(sed '1d' "$file" | awk '{if ($1~/^([0-2]*[0-9]*[0-9])\.([0-2]*[0-9]*[0-9])\.([0-2]*[0-9]*[0-9])\.([0-2]*[0-9]*[0-9])$/){print $1}}'| awk -F '\t' '{a[$1]++} END{for(i in a) {print (a[i],i)}}' | sort -nr | head -n $num)
	echo -e "Top ${num} IP:\n${IP}\n" >> IpTop.log
	cat IpTop.log
}

#统计最频繁被访问的URL TOP 100
function UrlTop {
	file=$1
        num=$2

	URL=$(sed '1d' "$file" | awk -F '\t' '{print $5}' | sort | uniq -c | sort -nr | head -n $num)
	echo -e "Top${num} URL:\n${URL}\n" >> UrlTop.log
	cat UrlTop.log
}

#统计不同响应状态码的出现次数和对应百分比
function Response {
	file=$1

	code=$(sed '1d' "$file" | awk -F '\t' 'BEGIN{ans=0}{a[$6]++;ans++} END{for(i in a) {printf ("%-10s%-10d%10.3f\n",i,a[i],a[i]*100/ans)}}')
	echo -e " Responses appearing times and ratio:\n${code}\n" >> Response.log
	cat Response.log
}

#分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
function Response4XX {
	file=$1
        num=$2

	#先找出4XX的状态码
	#-u 去除重复行
	code=$(sed '1d' "$file" | awk -F '\t' '{if($6~/^4/) {print $6}}' | sort -u )
	
	#对每一个4XX状态码重新遍历文件
	for n in $code ; do
		top=$(awk -F '\t' '{ if($6=='"$n"') {a[$5]++}} END {for(i in a) {print a[i],i}}' "$1" | sort -nr | head -n $num)
		echo -e "${n} Top ${num} URL:\n${top}\n" >> Response4xxTop.log
	done
	cat Response4xxTop.log
}

#给定URL输出TOP 100访问来源主机
function SpecifiedURLHosts {
	file=$1
	URL=$2
	num=$3

	uh=$(sed '1d' "$file" | awk -F '\t' '{if($5=="'$URL'") {host[$1]++}} END{for (i in host) {print host[i],i}}' | sort -nr | head -n $num)
	echo -e "URL: ${URL}\n\n${uh}" >> SpecifiedURLHost.log
	cat SpecifiedURLHost.log

}

#main 

if [[ "$#" -eq 0 ]]; then
	echo -e "Please input some arguments, refer the help information below:\n"
	helpInfo
fi

while [[ "$#" -ne 0 ]]; do
	case "$1" in    #$1--choice, $2--num
		"-o")HostTop "web_log.tsv" "$2"; shift 2;;
		"-i")IpTop "web_log.tsv" "$2"; shift 2;;
		"-u")UrlTop "web_log.tsv" "$2"; shift 2;; 
		"-r")Response "web_log.tsv"; shift;;
		"-u4")Response4XX "web_log.tsv" "$2"; shift 2;;
		"-uh")
			#$2--URL, $3--num
			if [[ -n "$2" ]]; then
				SpecifiedURLHosts "web_log.tsv" "$2" "$3"
				shift 3
			else
				echo "Please input an URL after '-uh'."
				exit 0
			fi
			;;
		"-h" | "--help")helpInfo;exit 0
        esac
done
