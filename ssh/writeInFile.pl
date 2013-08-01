#!/usr/bin/perl -w
use strict;
use warnings;

my $str="klasjdf lkasjdflkjasdlfkj alsdkfjaklsdfj";
open FILE, ">>/home/test/test/output/file.txt" or die $!; print FILE $str; close FILE;
