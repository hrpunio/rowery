while (<>) {
 ## <ride dist="55" exdist="56.67" bike='cx' gpx='20181206'>
 if (/exdist="([0-9\.]+)"/) {  $exsum += $1 }
 if (/ dist="([0-9\.]+)"/) {  $distsum += $1 }
}

print "Total: $exsum ($distsum)\n";
