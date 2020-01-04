%BN = ('ridley' => 'ridley',
   'r' => 'ridley',
   'b' => 'ridley', ### black
   'cx' => 'cx',
   'traction' => 'mtb',
   'mtb' => 'mtb',
   'fenix' => 'fenix',
);

open (PLCS, ">visited-places.csv");
print PLCS "place;country;date\n";

while (<>) {
  chomp();
  if (/date/) {
     $_ =~ /date[ \t]*=[ \t]*([^ \t]*)/; $date = $1; $date =~ s/['"><\/]//g;
  }
  elsif (/bike/ ) {
     ##<ride dist="100" exdist="102.00" bike='fenix' gpx='20180729'>
     $_ =~ /dist[ \t]*=[ \t]*([^ \t]*)/; $dist = $1; $dist =~ s/['"><\/]//g;
     $_ =~ /bike[ \t]*=[ \t]*([^ \t]*)/; $bike = $1; $bike =~ s/['"><\/]//g;

     if (exists $BN{$bike} ) { $bike = $BN{$bike}; }

     $B{$bike} += $dist;
     #print STDERR "$_ [$bike => $dist]\n";
  } elsif (/name/) {
     $_ =~ s/country[ \t]*=[ \t]*([^ \t]*)//; $country = $1; $country =~ s/['"><\/]//g;
     $_ =~ s/ //g;
     $_ =~ /name[ \t]*=[ \t]*([^ \t]*)/; $name = $1; $name =~ s/['"><\/]//g;

     if ($country eq '' ) {$country ='pl'};

     print PLCS "$name;$country;$date\n";
  }

}

close (PLCS);

print STDERR "\n\n";
print "Podsumowanie roczne:\n";

for $b (sort keys %B ) {
    print "$b = $B{$b}\n" ;
}
