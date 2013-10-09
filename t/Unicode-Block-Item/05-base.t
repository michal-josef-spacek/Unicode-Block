# Pragmas.
use strict;
use warnings;

# Modules.
use Unicode::Block::Item;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = Unicode::Block::Item->new(
	'hex' => '0a',
);
my $ret = $obj->base;
is($ret, 'U+000x', "Get base for '0a'.");
