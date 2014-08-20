package Unicode::Block::Item;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Readonly;
use Text::CharWidth qw(mbwidth);
use Unicode::Char;

# Constants.
Readonly::Scalar our $SPACE => q{ };

# Version.
our $VERSION = 0.02;

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

# Get character width.
sub width {
	my $self = shift;
	if (! exists $self->{'_width'}) {
		$self->{'_width'} = mbwidth($self->char);
		if ($self->{'_width'} == -1) {
			$self->{'_width'} = 1;
		}
	}
	return $self->{'_width'};
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

__END__

=pod

=encoding utf8

=head1 NAME

Unicode::Block::Item - Class for unicode block character.

=head1 SYNOPSIS

 use Unicode::Block::Item;
 my $obj = Unicode::Block::Item->new(%parameters);
 my $base = $obj->base;
 my $char = $obj->char;
 my $hex = $obj->hex;
 my $last_hex = $obj->last_hex;
 my $width = $obj->width;

=head1 METHODS

=over 8

=item C<new(%parameters)>

Constructor.

=over 8

=item * C<hex>

 Hexadecimal number.
 Default value is undef.
 It is required.

=item * C<hex_length>

 Length of hex number.
 Default value is 4.

=back

=item C<base()>

 Get hex base number in format 'U+???x'.
 Example: 'hex' => 1234h; Returns 'U+123x'.
 Returns string with hex base number.

=item C<char()>

 Get character.
 Example: 'hex' => 1234h; Returns 'ሴ'.
 Returns string with character.

=item C<hex()>

 Get hex number in 'hex_length' length.
 Example: 'hex' => 1234h; Returns '0x1234'.
 Returns string with hex number.

=item C<last_hex()>

 Get last hex number.
 Example: 'hex' => 1234h; Returns '4'.
 Returns string with last hex number.

=item C<width()>

 Get character width.
 Returns string with width.

=back

=head1 ERRORS

 new():
         Parameter 'hex' is required.
         Parameter 'hex' isn't hexadecimal number.
         From Class::Utils::set_params():
                 Unknown parameter '%s'.

=head1 EXAMPLE

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Encode qw(encode_utf8);
 use Unicode::Block::Item;

 # Object.
 my $obj = Unicode::Block::Item->new(
        'hex' => 2505,
 );

 # Print out.
 print 'Character: '.encode_utf8($obj->char)."\n";
 print 'Hex: '.$obj->hex."\n";
 print 'Last hex character: '.$obj->last_hex."\n";
 print 'Base: '.$obj->base."\n";

 # Output.
 # Character: ┅
 # Hex: 2505
 # Last hex character: 5
 # Base: U+250x

=head1 DEPENDENCIES

L<Class::Utils>,
L<Error::Pure>,
L<Readonly>,
L<Text::CharWidth>,
L<Unicode::Char>.

=head1 REPOSITORY

L<https://github.com/tupinek/Unicode-Block>

=head1 AUTHOR

Michal Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.02

=cut
