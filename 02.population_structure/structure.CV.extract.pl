#!/usr/bin/perl-w
#######Cheng Hong########
#######20181217##########
use strict;
use Data::Dumper;
use List::Util qw(first max maxstr min minstr reduce shuffle sum);
die  "Usage: $0 <file list> <CV out>\n" unless (@ARGV == 2);
open IN,"$ARGV[0]" or die $!;
open OUT,">$ARGV[1]" or die $!;

##IN
#/01.wild_exome_add/AB/10.Rep/log2.out
#/01.wild_exome_add/AB/10.Rep/log3.out

while(<IN>){
	chomp;
	my @filename=split/\/|\./,$_;
	my $rep=$filename[-4];
	my ($k)=$filename[-2]=~ /log(\S+)$/;
	print OUT $rep,"\t",$k,"\t";
	open(tmp, $_)or die "$_ file missing!\n";
	while(<tmp>){
		chomp;
		if ($_ =~ /^CV error \(K=\d+\): (\S+)/){
			print OUT $1,"\n";
		}
		else{
			next;
		}
	}
}
close IN;
close OUT;

		
