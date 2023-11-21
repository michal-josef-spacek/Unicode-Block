use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Unicode::Block;

# Test.
is($Unicode::Block::VERSION, 0.09, 'Version.');
