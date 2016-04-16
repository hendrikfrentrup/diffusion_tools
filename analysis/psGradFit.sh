#!/bin/bash
TMP_DIR=`pwd`
RES_FILE=gradFit.csv
rm $TMP_DIR/$RES_FILE

for dir in $(ls -d */); do
 cd $TMP_DIR/$dir/ #f1/
 rm fit.log
 normGradient
 normProfile
done
cd $TMP_DIR

echo forces >> $TMP_DIR/$RES_FILE
for dir in $(ls -d */); do
 echo $dir >> $TMP_DIR/$RES_FILE
done

echo "fit x=[-20:-12]" >> $TMP_DIR/$RES_FILE 
for dir in $(ls -d */); do
cd $TMP_DIR/$dir #/f1
 gnuplot << TOEND
  f(x) = a+b*x
  fit [-20:-12] f(x) "./norm_gradient0.dat" using 1:2 via a,b
TOEND
 tail fit.log | grep '[[:alpha:]]               =' | awk '{print $3, $5}' | paste - - >> $TMP_DIR/$RES_FILE
 rm fit.log
done
cd $TMP_DIR

echo "fit x=[-5:5]" >> $TMP_DIR/$RES_FILE
for dir in $(ls -d */); do
cd $TMP_DIR/$dir #/f1
 gnuplot << TOEND
  f(x) = a+b*x
  fit [-5:5] f(x) "./norm_gradient0.dat" using 1:2 via a,b
TOEND
 tail fit.log | grep '[[:alpha:]]               =' | awk '{print $3, $5}' | paste - - >> $TMP_DIR/$RES_FILE
 rm fit.log
done
cd $TMP_DIR

echo "fit x=[14:22]" >> $TMP_DIR/$RES_FILE
for dir in $(ls -d */); do
cd $TMP_DIR/$dir #/f1
 gnuplot << TOEND
  f(x) = a+b*x
  fit [14:22] f(x) "./norm_gradient0.dat" using 1:2 via a,b
TOEND
 tail fit.log | grep '[[:alpha:]]               =' | awk '{print $3, $5}'  | paste - - >> $TMP_DIR/$RES_FILE
 rm fit.log;
done
cd $TMP_DIR
