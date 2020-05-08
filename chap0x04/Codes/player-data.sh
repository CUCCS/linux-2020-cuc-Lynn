#!/usr/bin/env bash

#帮助信息
function helpInfo {
	echo -e "player.sh - For World Cup Player Infomation Statistics Analysing.\n"
	echo -e "Tips: Before using this script, making sure the worldcupplayerinfo.tsv file is in the working directory\n"
       #try 'wget http://sec.cuc.edu.cn/huangwei/course/LinuxSysAdmin/exp/chap0x04/worldcupplayerinfo.tsv' to download worldcupplayerinfo.tsv\n"

	echo "Usage: bash player.sh [arguments]"
	echo "Arguments:"
	echo "  -ar		: Num and percentage of players with their age in specific range."
	echo "  -ac		: Names of the oldest and the youngest players."
	echo "  -p		: Num and percentage of players on diffrent positions."
	echo "  -n		: Names of players with the longest name length."
	echo "  -h or --help	: Print Help (this message) and exit."

}

#数据文件表头参数Group  Country  Rank  Jersey  Position  Age  Selections  Club  Player  Captain	


#统计不同年龄区间范围的球员数量和百分比
function AgeData {

	below20=0	#20岁以下球员数
    between20and30=0	#[20,30]岁球员数
    above30=0	#30岁以上球员数

	#每行按TAB分隔，输出文本中的第6项--age
	age_data=$(awk -F "\t" '{print $6}' "$1")
        for age in $age_data; do
		if [[ "$age" != 'Age' ]]; then #滤去表头Age
			if [[ "$age" -lt 20 ]];then
			  below20=$((below20+1))
			elif [[ "$age" -ge 20 && "$age" -le 30 ]];then
			  between20and30=$((between20and30+1))
			elif [[ "$age" -gt 30 ]];then
			  above30=$((above30+1))
			fi
			line_num=$((line_num+1))
		fi
	done
        
	#计算百分比，-1使用标准数学库
	below20_ratio=$(printf "%.3f" "$(echo "100*${below20}/$line_num" | bc -l)")
	between20and30_ratio=$(printf "%.3f" "$(echo "100*${between20and30}/$line_num" | bc -l)")
	above30_ratio=$(printf "%.3f" "$(echo "100*${above30}/$line_num" | bc -l)")

        #使用echo打印不用格式替代符
	echo -e "\n-------- Age Statistics --------"
	echo -e "(0, 20) \t$below20\t${below20_ratio}%"
	echo -e "[20, 30]\t$between20and30\t${between20and30_ratio}%"
	echo -e "(30, +∞)\t$above30\t${above30_ratio}%"
}

#统计不同场上位置的球员数量、百分比
function Position {

	declare -A positions_dict 	#声明关联数组

	#每行按TAB分隔，输出文本中的第5项--position
	position_data=$(awk -F "\t" '{ print $5 }' "$1")

	for position in $position_data; do
		if [[ "$position" != 'Position' ]];then
			if [[ -z "${positions_dict[$position]}" ]];then
				positions_dict[$position]=1
			else
				temp="${positions_dict[$position]}"
				positions_dict[$position]=$((temp+1))
			fi
			line_num=$((line_num+1))
		fi
	done
        
	#遍历关联数组输出结果
	echo -e "\n-------- Positions Statistics --------"
	for position in "${!positions_dict[@]}";do
		count="${positions_dict[$position]}"
		ratio=$(printf "%.3f" "$(echo "100*${count}/$line_num" | bc -l)")
		echo -e "$position\t$count\t${ratio}%"
	done
}

#比较年龄大小，得到最大与最小年龄
function AgeCompare {

	max_age=0 	#假设最大年龄
    min_age=1024 	#假设最小年龄

	age_data=$(awk -F "\t" '{ print $6 }' "$1")
	for age in $age_data; do
		if [[ "$age" != 'Age' ]]; then
			if [[ "$min_age" -gt "$age" ]]; then
				min_age="$age"
			fi
			if [[ "$max_age" -lt "$age" ]]; then
				max_age="$age"
			fi
			line_num=$((line_num+1))
		fi
	done
        
	#最大年龄的球员可能有多个
	oldest_name=$(awk -F '\t' '{if($6=='"${max_age}"') {print $9}}' "$1");
	echo -e "\n-------- Oldest Names --------"
	for name in $oldest_name; do
		echo -e "$name\t$max_age"
	done

	youngest_name=$(awk -F '\t' '{if($6=='"$min_age"') {print $9}}' "$1");
	echo -e "\n-------- Youngest Names --------"
	for name in $youngest_name ;do
		echo -e "$name\t$min_age"
	done
}

#统计名字最长最短的球员
function NameCompare {

    longest_name_len=0 	#假设最长名字长0
    shortest_name_len=1024   #假设最短名字长1024

	#每行按TAB分隔，输出文本中的第9项--name的长度
	name_len_data=$(awk -F "\t" '{ print length($9) }' "$1")
	for name_len in $name_len_data; do
		if [[ "$longest_name_len" -lt "$name_len" ]]; then
			longest_name_len="$name_len"
		fi
		if [[ "$shortest_name_len" -gt "$name_len" ]]; then
			shortest_name_len="$name_len"
		fi
	done

	longest_name_data=$(awk -F '\t' '{if (length($9)=='"$longest_name_len"'){print $9}}' "$1")
	echo -e "\n-------- Longest Names --------"
	echo -e "$longest_name_data\t$longest_name_len"

	shortest_name_data=$(awk -F '\t' '{if (length($9)=='"$shortest_name_len"'){print $9}}' "$1")
	echo -e "\n-------- Shortest Names --------"
	echo -e "$shortest_name_data\t$shortest_name_len"
}


if [[ "$#" -eq 0 ]]; then
	echo -e "Please input some arguments, refer the Help information below:\n"
	helpInfo
fi
while [[ "$#" -ne 0 ]]; do
	case "$1" in
		"-ar")AgeData "worldcupplayerinfo.tsv"; shift;;
		"-ac")AgeCompare "worldcupplayerinfo.tsv"; shift;;
		"-p")Position "worldcupplayerinfo.tsv"; shift;;
		"-n")NameCompare "worldcupplayerinfo.tsv"; shift;;
		"-h" | "--help")helpInfo; exit 0
	esac
done



