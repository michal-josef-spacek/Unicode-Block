use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Unicode::Block::Item;

# Test.
is($Unicode::Block::Item::VERSION, 0.09, 'Version.');
