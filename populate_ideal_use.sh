#!/bin/bash

export PATH=$PATH:/usr/bin/ph

begin="08-01-01"

date=""

today=`date +%y-%m-%d`

while [ "$date" != "$today" ]; do 
    date=$begin
    /usr/bin/ph/databases/posdb/bin/loadIdealUse.pl 20$date
    begin=`dsig.s $date`
done


