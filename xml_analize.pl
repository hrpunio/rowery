#!/usr/bin/perl

use XML::LibXML;
use Getopt::Long;
$YY =`date '+%Y'`;

my $xmlfile;

GetOptions( "f=s"  => \$xmlfile,
	    "help|h|?" => \$showhelp, );

if ($showhelp ) { print "$USAGE"; exit 1;}

if ( -e "$xmlfile" ) {
  
$parser = XML::LibXML->new();
  
my $log = XML::LibXML->load_xml( location => $xmlfile);


  for $t ( $log->getElementsByTagName('day') ) {
     if ($t->getAttributeNode ("date")) { $date = $t->getAttributeNode ("date")->getValue() }
     for $s ( $t->getElementsByTagName('ride') ) {
       if ($s->getAttributeNode ("dist")) { 
       
          $dist = $s->getAttributeNode ("dist")->getValue();
          ($y, $m, $d) = split /[^0-9]/, $date;
          if ($y < 1990 || $y > $YY ) {die "*** Błąd*** Rok: $y\n"; }
          if ($m < 1 || $m > 12 ) {die "*** Błąd*** Miesiąc: $m\n"; }
          if ($d < 1 || $d > 31 ) {die "*** Błąd*** Dzień: $d\n"; }

          if ($dist < 1 || $dist > 250 ) {die "*** Błąd*** Dystans: $dist\n"; }

          $date =~ s/\//-/g;

          print "$d;$m;$y;$dist\n";
       }

     }
  } 

}
