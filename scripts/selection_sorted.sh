#!/bin/bash
$1 list of chr according to selection
$2 list of path of runs separated by space
$3 output file

cat $1 | while read chr
do 
	for fname in $2
	do
		zgrep "$chr[^0123456789]" $fname
	done >> $3
done
