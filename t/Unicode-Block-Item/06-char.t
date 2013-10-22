# Pragmas.
use strict;
use warnings;

# Modules.
use Encode qw(decode_utf8);
use Unicode::Block::Item;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = Unicode::Block::Item->new(
	'hex' => '2661',
);
my $ret = $obj->char;
is($ret, decode_utf8('♡'), "Get unicode character for for '2661'.");
