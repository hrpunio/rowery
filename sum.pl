#!/usr/bin/perl
# Półroczne statystyki rowerowe

my $zPrzeniesienia = 20760;

open (O, "cat *.xml |") || die "Cannot open!\n";

while (<O>) { chomp();
   ###print "$_\n";
   if (/<day.+date=["']([^"']+)["']/ ) { $day =$1; 
     ($y, $m, $d) = split /\//, $day;  
     $Years{$y}=1; ## lata zarejestrowane
   }
   elsif (/ride.*[ \t]+dist=["']([^"']+)["']/) { 
       $dist=$1; $Dist{"$y$m"} += $dist;

       if ($m < 7) { $HalfY {"${y}_1"} += $dist } 
       else {  $HalfY {"${y}_2"} += $dist } 

       $Yr{"$y"} += $dist;
    }
   elsif (/<\/day/) { ##print "$day $dist\n"; 
   }
   
}

print "*** Półroczne statystyki rowerowe: ***\n";
print "*** ============================== ***\n\n";

my $hh = 0;

print "----------------------------------------------------\n";
print "kwartał km    %%      |  kwartał km    %%     razem%\n";
print "----------------------------------------------------\n";

##for $k (sort keys %HalfY ) {
for $y (sort keys %Years ) {

   $ytPrc = $Yr{$y} ;

   $h1 = $HalfY{"${y}_1"}/$ytPrc;  $h2 = $HalfY{"${y}_2"}/$ytPrc; 

   $hh = $h1 + $h2; # kontrolnie

   printf "%s  %4.4d %6.2f   |  %s  %4.4d %6.2f  %6.2f\n",  
      "${y}_1", $HalfY{"${y}_1"}, $h1 * 100, "${y}_2", $HalfY{"${y}_2"}, $h2 * 100, $hh * 100;

   $sum1 += $h1;
   $sum2 += $h2; 

   $totalDst += $HalfY{"${y}_1"} + $HalfY{"${y}_2"};

}
print "\n";
print "----------------------------------------------------\n";

@Years = keys %Years; $N0 = $#Years +1; ## ile lat

print "\n";
printf "Średnio: kw1 = %.2f kw2 = %.2f razem% = %.2f (%d lat)\n", 
   $sum1/$N0 * 100, $sum2/$N0 * 100, ($sum1/$N0 * 100 + $sum2/$N0 * 100 ), $N0;

printf "Razem: %.2f\n", $totalDst + $zPrzeniesienia ;

##
