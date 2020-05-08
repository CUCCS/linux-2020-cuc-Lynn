#!/usr/bin/env bash

#求两个整数的最大公约数
err=0;
flag=1;
while [ ${flag} -eq 1 ]
do

	#命令行输入两个整数
	echo 'please input num a ang b:';
	read a b;

	if [[ -z "$a" || -z "$b" ]]; then
		err=1;
		echo "Error!You have to input 2 numbers.";
		break;
	fi
    
	if [[ ! -z  "$(echo "$a" | grep '[.]')" || ! -z  "$(echo "$b" | grep '[.]')" ]]; then

                err=1
                echo "Error! You should not input floating point"
                break;
    fi

	expr $a + 1 &> /dev/null
	END_CODE1=$?
	expr $b + 1 &> /dev/null
	END_CODE2=$?

	if [[ ${END_CODE1} -ne 0 || ${END_CODE2} -ne 0 ]]; then
		err=1;
		echo "Error! You should not input characters! Please input 2 integer";
		break;
	fi


	if [[ ${err} -eq 0 ]]; then

		#辗转相除法计算最大公约数
		c=$((a%b));
		while [ ${c} -ne 0 ]
		do
			gcd=${c};
			a=${b};
			b=${c};
			c=$((a%b));
		done
		echo a和b的最大公约数为：${gcd};

		echo 'Keep calculating? yes(1) or no(0):';
		read f;
		flag=${f};
	fi
done
