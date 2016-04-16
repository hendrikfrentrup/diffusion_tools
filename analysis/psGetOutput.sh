#!/bin/bash

TMP_DIR=`pwd`
RES_FILE=results.csv
rm $TMP_DIR/$RES_FILE 

echo fluxes    >> $TMP_DIR/$RES_FILE
for dir in $(ls -d */); do
echo $dir >> $TMP_DIR/$RES_FILE
done

echo fluxes  >> $TMP_DIR/$RES_FILE
for dir in $(ls -d */); do
cd $TMP_DIR/$dir #/f1
 grep "Total Flux\*Area" output.dat | awk '{print $6}' >> $TMP_DIR/$RES_FILE
done
cd $TMP_DIR

echo res.times  >> $TMP_DIR/$RES_FILE
for dir in $(ls -d */); do
cd $TMP_DIR/$dir #/f1
 grep "Rel. residence time*" output.dat | awk '{print $4}' >> $TMP_DIR/$RES_FILE
done
cd $TMP_DIR

echo i_ads/t_pore  >> $TMP_DIR/$RES_FILE
for dir in $(ls -d */); do
cd $TMP_DIR/$dir #/f1
 grep "Ad-/Desorption events per total T_pore" output.dat | awk '{print $6}' >> $TMP_DIR/$RES_FILE
done
cd $TMP_DIR

echo i_ads/t_ads  >> $TMP_DIR/$RES_FILE
for dir in $(ls -d */); do
cd $TMP_DIR/$dir #/f1
 grep "Ad-/Desorption events per T_ads" output.dat | awk '{print $5}' >> $TMP_DIR/$RES_FILE;
done
cd $TMP_DIR
