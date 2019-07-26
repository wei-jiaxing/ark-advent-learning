#!/usr/bin/env perl

use strict;
use warnings;
use FindBin::libs; # use lib 'lib'と同じ、だけど、相対パスではないからより良い

use Jobeet::Models;

my $datafile = models('home')->subdir(qw/sql fixtures/)->file('default.pl');
do $datafile or die $!;