#!/bin/bash
for (( i=1; i <=35 ; i++ ))
do
  as asms/bad_inst_$i.asm -o asms/bad_inst_$i.out
  ld asms/bad_inst_$i.out -o asms/bad_inst_$i
done
rm asms/*.out
