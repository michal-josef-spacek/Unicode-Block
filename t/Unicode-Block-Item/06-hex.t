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
my $ret = $obj->hex;
is($ret, '000a', "Get hex number for '0a'.");
