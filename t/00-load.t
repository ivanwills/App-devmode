#!/usr/bin/perl

use strict;
use warnings;
use FindBin qw/$Bin/;

use Test::More tests => 2;

use_ok('App::devmode');
ok( !(system 'perl', "-I $Bin/../lib", '-c', "$Bin/../bin/devmode"), "bin/devmode compiles");

diag( "Testing App::devmode $App::devmode::VERSION, Perl $], $^X" );
done_testing();
