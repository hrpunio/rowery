#!/bin/bash
OPUS=opus-vitae.txt

rm -f opus-vitae.txt

for i in c*xml ; do xsltproc -o r-$i r2r.xsl $i && \
     xsltproc r2csv.xsl r-$i >> $OPUS; done
## sh doopus.sh  | awk 'BEGIN {FS=";"}; {d+=$2}; END {print 56805 + d}'
cat $OPUS | awk 'BEGIN {FS=";"}; {d+=$2; if (NF != 5){ print "Wrong record: NF"} }; END {print 56805 + d}'
##
echo 'Done...'
rm r-c*.xml
