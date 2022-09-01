#!/usr/bin/perl -w
use strict;
use Data::Dumper;
die "Usage:perl $0 <LINK> <vcf|vcf.gz> <out>\n" unless @ARGV == 3;
open(LINK, "$ARGV[0]") or die "link file missing!\n";
=pod
LINK file format
vcfID	outputID
=cut
my %hash;
my $sample = 0;
my @order;
while(<LINK>){
	chomp;
	$sample++;
	my @inf = split/\s+/;
	$hash{$inf[0]} = $inf[-1];
	push @order,$inf[-1];
}
close LINK;
my $input = $ARGV[1];
open (IN,($input =~ /\.gz$/)? "gzip -dc $input |" : $input) or die "gzipped vcf file required!\n";
my @header = ();
my $site = 0;
my %phy;
while(<IN>){
	next if /^##/;
	chomp;
	if (/^#CHROM/){
		@header = split/\t/;
	}
	else{
		my @geno = split/\t/;
		$site++;
		for my $index (9..$#geno){
			die "$_ may not be phased\n" if $geno[$index] !~ /\|/;
			my @allele = split/\|/, $geno[$index];
			next if(!exists $hash{$header[$index]}); 
			if ($allele[0] eq "0"){		
				push @{$phy{$hash{$header[$index]}."-1"}}, $geno[3];
			}
			elsif ($allele[0] eq "1"){
				push @{$phy{$hash{$header[$index]}."-1"}}, $geno[4];
			}
			else{
				die "$geno[$index] may have multiple allele!\n";
			}
			if ($allele[1] eq "0"){
				push @{$phy{$hash{$header[$index]}."-2"}}, $geno[3];
			}
			elsif ($allele[1] eq "1"){
				push @{$phy{$hash{$header[$index]}."-2"}}, $geno[4];
			}
			else{
				die "$geno[$index] may have multiple allele!\n";
			}
		}
	}
}
close IN;
open (OUT, ">$ARGV[2]") or die "permission denied!\n";
#print OUT $sample*2," $site\n";
foreach my $key (@order){
	my $a=$key."-1";
	my $b=$key."-2";
	print OUT ">",$a,"\n",join("", @{$phy{$a}}),"\n";
	print OUT ">",$b,"\n",join("", @{$phy{$b}}),"\n";
	#print OUT ">",$key,"\n",join("", @{$phy{$key}}),"\n";
}
close OUT;
