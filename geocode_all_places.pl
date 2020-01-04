open (PLACES, "visited-places-unique.csv") || die 'Cannot open';

while (<PLACES>) {
 chomp();
 $_ =~ s/[ \t]//g;
 ($city, $state) = split /=/, $_;
 $addr = `geocodeCoder0.pl -a "$city" -country $state -log Places.log`;
 $line = "$_;$addr\n";
 print STDERR $line;
 print $line;
}
