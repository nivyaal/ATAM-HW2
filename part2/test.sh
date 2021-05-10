#! /bin/bash

insmod ili.ko
cd bad
rm output result
touch output result
for (( i=1; i <=22; i++ ))
do
	./bad_inst_$i > output
	val=$?
	echo $val >> output
	diff -a output bad_inst_$i.out
	if [[ $? -eq 0 ]]
	then
		echo -e "test ${i}: pass"
	else
		echo "test ${i}: failed!!! - return value: "
		echo $val
	fi		
done
