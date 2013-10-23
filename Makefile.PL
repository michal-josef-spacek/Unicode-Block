# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Class for unicode block manipulation.';
author 'Michal Špaček <skim@cpan.org>';
license 'bsd';
name 'Unicode-Block';
requires 'Class::Utils' => 0.02;
requires 'Error::Pure' => 0.13;
requires 'Text::CharWidth' => 0;
requires 'Unicode::Char' => 0;
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=Unicode-Block';
resources 'homepage' => 'https://github.com/tupinek/Unicode-Block';
resources 'repository' => 'git://github.com/tupinek/Unicode-Block';
test_requires 'Encode' => 0;
test_requires 'English' => 0;
test_requires 'Error::Pure::Utils' => 0.13;
test_requires 'File::Object' => 0.06;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();
