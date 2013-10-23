# Pragmas.
use strict;
use warnings;

# Modules.
use Unicode::Block::Item;
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $obj = Unicode::Block::Item->new(
	'hex' => '0a',
);
my $ret = $obj->width;
is($ret, '1', "Get width for '0a'.");

# Test.
$obj = Unicode::Block::Item->new(
	'hex' => '3111',
);
$ret = $obj->width;
is($ret, '2', "Get width for '3111'.");
