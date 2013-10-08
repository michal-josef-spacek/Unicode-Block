package Unicode::Block;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Unicode::Block::Item;

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Character from.
	$self->{'char_from'} = '0000',

	# Character to.
	$self->{'char_to'} = '007F',

	# Process parameters.
	set_params($self, @params);

	# Count.
	$self->{'count'} = $self->{'char_from'};

	# Object.
	return $self;
}

# Get next character.
sub next {
	my $self = shift;
	my $char_hex = $self->_count;
	if (defined $char_hex) {
		return Unicode::Block::Item->new('hex' => $char_hex);
	} else {
		return;
	}
}

# Get actual character and increase number.
sub _count {
	my $self = shift;
	my $ret = $self->{'count'};
	if (! defined $ret) {
		return;
	}
	my $num = hex $self->{'count'};
	$num++;
	my $last_num = hex $self->{'char_to'};
	if ($num > $last_num) {
		$self->{'count'} = undef;
	} else {
		$self->{'count'} = sprintf '%x', $num;
	}
	return $ret;
}

1;
