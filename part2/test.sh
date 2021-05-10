#! /bin/bash

cd bad
rm output result
touch output result
for (( i=1; i <=100; i++ ))
do
	echo "test $i:\n" > output
	./bad_inst_$i >> output
	echo "\nreturn value: " >>output
	val = $?
	echo $val>>output
	diff -a ouput bad_inst_$i.out > /dev/null 2>&1
	if [ $? -eq 0 ]
	then
		echo "test $i: pass\n"
	else
		echo "test $i: failed!!! - return value: $val\n"
	fi		
done
