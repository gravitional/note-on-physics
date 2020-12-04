#!/usr/bin/env perl
use strict;
use warnings;
#****************************************
 
CANDIDATE: for my $candidate ( 2 .. 100 ) {
	for my $divisor ( 2 .. sqrt $candidate ) {
		next CANDIDATE if $candidate % $divisor == 0;
	}
	print $candidate." is prime\n";
}
