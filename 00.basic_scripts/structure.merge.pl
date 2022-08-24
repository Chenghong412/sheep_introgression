#!/usr/bin/perl-w
#######Cheng Hong########
#######20181217##########
use strict;
use Data::Dumper;
use List::Util qw(first max maxstr min minstr reduce shuffle sum);
die  "Usage: $0 <fam file> <file list> <sample order> <merge out>\n" unless (@ARGV == 4);
open IN1,"$ARGV[0]" or die $!;
open IN2,"$ARGV[1]" or die $!;
open IN3,"$ARGV[2]" or die $!;
open OUT,">$ARGV[3]" or die $!;

##IN1 plink fam
#CAOC-BIH01 CAOC-BIH01 0 0 0 -9
#CAOC-BIH02 CAOC-BIH02 0 0 0 -9
#
##IN2 结果文件 .Q文件列表
#*2.Q 
#*3.Q
#
#IN3 输出结果顺序,一行一个样本编号
my $i=0;
my %fam;
while(<IN1>){
	chomp;
	$i+=1;
	my @in1=split/\s+/,$_;
	$fam{$i}=$in1[0];
}

my %structure;
while(<IN2>){
	chomp;
	open (tmp, $_)or die "$_ file missing!\n";
	my $i=0;
	while(<tmp>){
		chomp;
		$i+=1;
		my $sample=$fam{$i};
		my @tmp=split/\s+/,$_;
		push @{$structure{$sample}},@tmp;
	}
}

my @order;
while(<IN3>){
	chomp;
	my @in3=split/\s+/,$_;
	push @order,$in3[0];
}
foreach my $sample(@order){
	if(exists $structure{$sample}){
		print OUT $sample,"\t",join("\t",@{$structure{$sample}}),"\n";
	}
}
close IN1;
close IN2;
close IN3;
close OUT;



		
