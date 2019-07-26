use strict;
use warnings;

use Test::More;
use Jobeet::Test;
use Jobeet::Models;
use DateTime;

my $datafile = models('home')->subdir(qw/sql fixtures/)->file('default.pl');
do $datafile or die $!;

{
	my $c = ctx_get('/job');
	is $c->req->action->reverse, 'job/index', 'index action call ok';
	is $c->res->status, 200 , '200 status ok';
}

done_testing;