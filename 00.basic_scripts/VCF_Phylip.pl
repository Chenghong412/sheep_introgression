#!/usr/bin/perl -w
use strict;
die "Usage:perl $0 <LINK> <vcf|vcf.gz> <out>\n" unless @ARGV == 3;
open(LINK, "$ARGV[0]") or die "link file missing!\n";
=pod
LINK file format
vcfID	outputID
=cut
my %hash;
my $sample = 0;
while(<LINK>){
	chomp;
	$sample++;
	my @inf = split/\s+/;
	$hash{$inf[0]} = $inf[1];
}
close LINK;
my $input = $ARGV[1];
open (IN,($input =~ /\.gz$/)? "gzip -dc $input |" : $input) or die "gzipped vcf file required!\n";
my %degenerate=('A/G'=>'R','C/T'=>'Y','A/C'=>'M','G/T'=>'K','G/C'=>'S','A/T'=>'W','A/T/C'=>'H','G/T/C'=>'B','G/A/C'=>'V','G/A/T'=>'D','A/T/C/G'=>'N');
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
			#die "$_ may not be phased\n" if $geno[$index] !~ /\|/;
			my @allele = split/\/|\:/, $geno[$index];
			next if(!exists $hash{$header[$index]});
			if ($allele[0] eq "0" && $allele[1] eq "0"){		
				push @{$phy{$hash{$header[$index]}}}, $geno[3];
			}
			elsif($allele[0] eq "1" && $allele[1] eq "1"){
				push @{$phy{$hash{$header[$index]}}}, $geno[4];
			}
			elsif($allele[0] eq "0" && $allele[1] eq "1"){
				my $a="$geno[3]/$geno[4]";
                my $b="$geno[4]/$geno[3]";
                if(exists $degenerate{$a}){
					push @{$phy{$hash{$header[$index]}}}, $degenerate{$a};
				}
				else{
					push @{$phy{$hash{$header[$index]}}}, $degenerate{$b};
				}

			}
			else{
				push @{$phy{$hash{$header[$index]}}},"N";
			}				
		}
	}
}
close IN;
open (OUT, ">$ARGV[2]") or die "permission denied!\n";
print OUT $sample," $site\n";
foreach my $key (keys %hash){
	print OUT $key,"\t",join("", @{$phy{$key}}),"\n";
}
close OUT;
