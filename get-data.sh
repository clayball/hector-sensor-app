#!/bin/bash

# Get all data from past XX5 days then XX4, XX3, etc..
# subtract day XX5 from day XX4 for that day's total.

# The location of HECTOR
HECTORSCRIPTSDIR="/opt/hector/app/scripts"
cd ${HECTORSCRIPTSDIR}

# Create the results directory if it does not exist
# - this will only work if the cd command (3 lines above) is present
if [ ! -d darknet-results ]
then
  echo "[ ] directory: darknet-results does not exist.. creating."
  mkdir darknet-results
fi

# How many days in the past would you like to query?
getday=365

#echo "[+] getday: ${getday}"

# Iterate over the past days to query
while [ $getday -gt "1" ]
do
  getday=$(($getday-1))
  # Name files so they appear sequentially (could use case)
  if [ $getday -lt "10" ]
  then
    ofile="dn00${getday}.csv"
  fi
  if [ $getday -lt "100" ]
  then
    ofile="dn0${getday}.csv"
  else
    ofile="dn${getday}.csv"
  fi

  # Call the report script and save to $ofile
  python report-darknet.py $getday > darknet-results/$ofile
  #echo "[+] getday: ${getday}, ofile ${ofile}"
done
