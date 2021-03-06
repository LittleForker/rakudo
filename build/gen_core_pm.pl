#!/usr/bin/perl
# Copyright (C) 2008, The Perl Foundation.
# $Id$

use strict;
use warnings;
use 5.008;

binmode STDOUT, ':utf8';

my @files = @ARGV;

print <<"END_SETTING";
# This file automatically generated by $0.

END_SETTING

my %classnames;
foreach my $file (@files) {
    print "# From $file\n\n";
    open(my $fh, "<:utf8",  $file) or die "$file: $!";
    local $/;
    my $x = <$fh>;
    close $fh;
    print $x;
    foreach ($x =~ /\bclass\s+(\S+)/g) { $classnames{$_}++; }
}

print "CHECK {\n";
foreach (keys(%classnames)) {
    print "    Perl6::Compiler.import('$_');\n";
}
print "}\n";

print "\n# vim: set ft=perl6 nomodifiable :\n";
