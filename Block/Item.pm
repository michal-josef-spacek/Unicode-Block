package Unicode::Block::Item;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Readonly;
use Unicode::Char;

# Constants.
Readonly::Scalar our $SPACE => q{ };

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Hexadecimal number.
	$self->{'hex'} = undef;

	# Length of hex number.
	$self->{'hex_length'} = 4;

	# Process parameters.
	set_params($self, @params);

	# Check hex number.
	if (! defined $self->{'hex'}) {
		err "Parameter 'hex' is required.";
	}
	if (! $self->_is_hex) {
		err "Parameter 'hex' isn't hexadecimal number.";
	}

	# Object.
	return $self;
}

# Get hex base number.
sub base {
	my $self = shift;
	my $base = substr $self->hex, 0, -1;
	return 'U+'.$base.'x';
}

# Get character.
sub char {
	my $self = shift;

	# Create object.
	if (! exists $self->{'u'}) {
		$self->{'u'} = Unicode::Char->new;
	}

	# Get char.
	my $char = $self->{'u'}->u($self->{'hex'});

	# Non-Spacing Mark.
	if ($char =~ m/\p{Mn}/ms || $char =~ m/\p{Me}/ms) {
		$char = $SPACE.$char;

	# Control.
	} elsif ($char =~ m/\p{Cc}/ms) {
		$char = $SPACE;

	# Not Assigned.
	} elsif ($char =~ m/\p{Cn}/ms) {
		$char = $SPACE;
	}

	return $char;
}

# Get hex number.
sub hex {
	my $self = shift;
	return sprintf '%0'.$self->{'hex_length'}.'x',
		CORE::hex $self->{'hex'};
}

# Get last hex number.
sub last_hex {
	my $self = shift;
	return substr $self->{'hex'}, -1;
}

# Check for hex number.
sub _is_hex {
	my $self = shift;
	if ($self->{'hex'} !~ m/^[0-9a-fA-F]+$/ims) {
		return 0;
	}
	my $int = CORE::hex $self->{'hex'};
	if (! defined $int) {
		return 0;
	}
	my $hex = sprintf '%x', $int;
	my $value = lc $self->{'hex'};
	$value =~ s/^0*//ms;
	if ($value eq '') {
		$value = 0;
	}
	if ($hex ne $value) {
		return 0;
	}
	return 1;
}

1;
