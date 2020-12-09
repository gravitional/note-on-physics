#!/usr/bin/env perl
use strict;
use warnings;
#****************************************
 
sub contextualSubroutine {
	# Caller wants a list. Return a list
	return ("Everest", "K2", "Etna", "\n") if wantarray;

	# Caller wants a scalar. Return a scalar
	return 3 ."\n";
}

my @array = contextualSubroutine();
print @array; # "EverestK2Etna"

my $scalar = contextualSubroutine();
print $scalar; # "3"