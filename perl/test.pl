#!/usr/bin/env perl
use strict;
use warnings;
##****************************************

my $string = "a tonne of feathers or a tonne of bricks";
# Try once without /g.
$string =~ s/[aeiou]/r/;
print $string; # "r tonne of feathers or a tonne of bricks"

# Once more.
$string =~ s/[aeiou]/r/;
print $string; # "r trnne of feathers or a tonne of bricks"

# And do all the rest using /g
$string =~ s/[aeiou]/r/g;
print $string, "\n"; # "r trnnr rf frrthrrs rr r trnnr rf brrcks"