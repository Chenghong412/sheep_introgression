#!/usr/bin/perl
use warnings ;
use strict ;
die "Usage : perl $0 <gtf|gff> <reference> <output>\n" unless @ARGV == 3;
=begin
This script takes a gff3 (or gtf or gff) file and a fasta file as input. 
It then identifed all four-fold degenerate positions and retains those.
=cut
open (OUT, ">$ARGV[2]") or die "permission denied!\n";
### file information is passed via command line
my $fa = &FastaReader($ARGV[1]) or die "reference fasta file required!\n";

### read in set of 4d degenerate codons
### this file can take any format as long as all it contains are \t and 4-fold degenerate codons in the second-nth columns on each line
my %codon = (
	'CG' => 'R',
	'CC' => 'P',
	'TC' => 'S',
	'CT' => 'L',
	'GT' => 'V',
	'AC' => 'T',
	'GC' => 'A',
	'GG' => 'G',
);
### gene information is extracted from standard gff3 files.
### this also work for gtf and gff files
my %gene ; 
open (GFF, "$ARGV[0]") or die "GFF file reqired!\n";
while (<GFF>) {
	next if /^#/; 
	chomp $_ ; 
	my @split = split( /\t/, $_ ); 	
	if ( $split[2] eq "CDS" ) { 
		my $id = $split[0]."_".$split[3]."_".$split[4]."_".$split[7];
		my $genename;
		if ($split[8] =~ /gene/){
			($genename) = $split[8] =~ /gene=(\S+?);/;
		}
		else{
			($genename) = $split[8] =~ /Parent=(\S+?);/;
		}
		$gene{$id}{"gene"} = $genename;
		$gene{$id}{"strand"} = $split[6] ;
		$gene{$id}{"chrom"} = $split[0] ; 
		$gene{$id}{"start"} = $split[3] - 1 ;
		$gene{$id}{"stop"} = $split[4] - 1 ; 
		$gene{$id}{"frame"} = $split[7] ;
	}
}
close GFF ; 
my %syn;
foreach my $mrna ( keys %gene ) {
	my $protein = "";
	my @sites = ();
	if ( $gene{$mrna}{"strand"} eq '+' ) {
		$protein = uc(substr( $fa->{$gene{$mrna}{"chrom"}}, $gene{$mrna}{"start"}, $gene{$mrna}{"stop"} - $gene{$mrna}{"start"} + 1));
		foreach ($gene{$mrna}{"start"}..$gene{$mrna}{"stop"}){ 
			push @sites, $_ ;
		}
	}
	else{
		### if on - strand, we need to reverse compliment this sequence
		$protein = uc(&reverse_complement(substr($fa->{$gene{$mrna}{"chrom"}}, $gene{$mrna}{"start"}, $gene{$mrna}{"stop"} - $gene{$mrna}{"start"} + 1)));
		foreach ($gene{$mrna}{"start"}..$gene{$mrna}{"stop"}){ 
			push @sites, $_ ;
		}
		@sites = reverse( @sites ) ; ### reverse list of sites to account for - strand
	}
	### identify four fold degenerate sites and non-4d sites
	for (my $i = $gene{$mrna}{"frame"}; $i < length($protein)-2; $i += 3){
		if (exists($codon{substr($protein,$i,2)})){ 
			$syn{$gene{$mrna}{"chrom"}}{$sites[$i+2]} = "$gene{$mrna}{\"gene\"}\t$gene{$mrna}{\"strand\"}";### only the third base can be 4d
		}
	}
}
### output
foreach my $chr (sort keys %syn){
	foreach my $pos (sort {$a <=> $b} keys %{$syn{$chr}}){
		print OUT "$chr\t",$pos+1,"\t$syn{$chr}{$pos}\n";
	}
}
close OUT;
### sequence data
sub FastaReader {
	my ($file) = @_;
	open IN, "<", $file or die "Fail to open file: $file!\n";
	local $/ = '>';
	<IN>;
	my ($head, $seq, %hash);
	while (<IN>){
		s/\r?\n>?$//;
		( $head, $seq ) = split /\r?\n/, $_, 2;
		my $tmp = (split/\s+/,$head)[0];
		$seq =~ s/\s+//g;
		$hash{$tmp} = $seq;
	}
	close IN;
	$/ = "\n";
	return \%hash;
}
sub reverse_complement {
	my $dna = shift;
	my $revcomp = reverse($dna);
	$revcomp =~ tr/ACGTacgt/TGCAtgca/;
	return $revcomp;
}
