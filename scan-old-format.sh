#!/bin/bash
#grep -v ^% c1999.txt | awk '{all+=$5} END {print all}'

#echo $*

perl -e '

print "<?xml version=\"1.0\" encoding=\"iso-8859-2\" standalone=\"no\" ?>\n";
print "<!DOCTYPE year SYSTEM \"rowery.dtd\" >\n";

while (<>) {

  chomp();

  if ($_ =~ /DATASTART/) {
     @tmp = split / /, $_;
     $year = $tmp[2];
     print "<year no=\"$year\" done=\"??????\">\n";
  }
  if ($_ =~ /MONTH/) {
    $monthno++;
    unless ( $monthno == 1 ) { print "</month>\n"; }
    print "<month no=\"\">\n";
  }

  if ( $_ =~ /^%/ ) { next ; }

  @tmp = split /\|/, $_;
  $dist = $tmp[2] ; $dist =~ s/ //g;
  if ($dist =~ /[0-9]+/) { ; }
  else { print STDERR "**** $_\n" ; next ; }
  $date = $tmp[0]; $date =~ s/ //g;
  ($dzien, $mc ) =  split /\./, $date;

  $descr = $tmp[3] ; $descr =~ s/^ +| +$//;
  $descr =~ s/Wczlno/Wiczlino/g;
  $descr =~ s/\&/_/g;

  $fulldate = "$year/$mc/$dzien";

  print "<day date=\"$fulldate\">\n";
  print "  <ride dist=\"$dist\" exdist=\"$dist\">\n";
  print "    <by name=\"$descr\"/>\n";
  print "    <comment>$descr</comment>\n";
  print "  </ride>\n";
  print "</day>\n\n";

}

print "</year>\n\n";

print "<!-- Keep this comment at the end of the file\n";
print "Local variables:\n";
print "mode: xml\n";
print "coding: iso-8859-2\n";
print "sgml-indent-step:1\n";
print "sgml-indent-data:t\n";
print "sgml-parent-document:nil\n";
print "End:\n";
print "-->\n";



 ' $*
