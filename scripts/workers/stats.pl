use 5.010;
use strict;
use warnings;
use Statistics::Basic qw(:all);
use Bio::SeqIO;

my $fcds="$ARGV[0]";
#my $outfile="$ARGV[1]";

my $in  = Bio::SeqIO-> new ( -file   => $fcds,
                             -format => 'fastq' );

my $cpt=1;
my $cptsmall=0;
my $cpt500=0;
my $cpt1000=0;
my $cpt5000=0;
my $sum=0;
my @mylength=();

while (my $record = $in->next_seq()) {
          my $get_seq=$record->seq();
          my $len=length($get_seq);
          $cpt++;
          $sum = $sum+$len;
          push @mylength, $len;

          if ($len >= 5000){
            $cpt5000++;
          }elsif ($len >= 1000){
            $cpt1000++;
          }elsif ($len >= 500){
            $cpt500++;
          }else{
            $cptsmall++;
          }
         
}

my $med = median(@mylength);
my $mod = mode(@mylength);
my $std = stddev(@mylength);
my $mean = mean(@mylength);


print "$fcds;$mean;$sum;$med;$mod;$std;$cpt;$cptsmall;$cpt500;$cpt1000;$cpt5000\n";


