#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Path::Class;

my $lib = file($0)->parent->parent->subdir('lib');
my @files = $lib->children;

while ( my $file = shift @files ) {
    if ( -d $file ) {
        push @files, $file->children;
    }
    elsif ( $file =~ /[.]pm$/ ) {
        require_ok $file;
    }
}

my $bin = $base->subdir('bin');
@files = $bin->children;

while ( my $file = shift @files ) {
    if ( -d $file ) {
        push @files, $file->children;
    }
    elsif ( $file !~ /[.]sw[ponx]$/ ) {
        my ($bang) = $file->slurp;
        next if $bang !~ /perl/;
        ok !(system qw/perl -Ilib -c /, $file), "$file compiles";
    }
}

diag( "Testing App::devmode $App::devmode::VERSION, Perl $], $^X" );
done_testing();
