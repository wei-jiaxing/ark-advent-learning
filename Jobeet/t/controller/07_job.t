use strict;
use warnings;

use Test::More;
use Jobeet::Test;
use Jobeet::Models;
use DateTime;
use Data::Dumper;

my $datafile = models('home')->subdir(qw/sql fixtures/)->file('default.pl');
do $datafile or die $!;

{
	my $c = ctx_get('/job');
	is $c->req->action->reverse, 'job/index', 'index action call ok';
	is $c->res->status, 200 , '200 status ok';
}

{
	my $c = ctx_get('/job/dummy_token');
	is $c->req->action->reverse, 'job/show', 'show action call ok';
	is $c->res->status, 404 , '404 status ok';
	ok !$c->stash->{job}, 'job not set';
}

{
	my $j = models('Schema::Category')->find({name => 'Programming'})->get_active_jobs->first;
	my $c = ctx_get('/job/'.$j->token);
	is $c->req->action->reverse, 'job/show', 'show action call ok';
	is $c->res->status, 200, '200 status ok';
	my $job = $c->stash->{job};

	isa_ok $job, 'Jobeet::Schema::Result::Job';

	#実際は使わないと思う練習用だけ
	is $job->expires_at->delta_days($job->created_at)->in_units('days'), models('conf')->{active_days}, 'expires_at 30 days after created.'; #更新しない限りだけど

	#deleteのテスト
	my $c2 = ctx_get('/job/'.$j->token.'/delete');
	is $c2->req->action->reverse, 'job/delete', 'delete action call ok';

	is $c2->res->status, 302, 'redirection ok';

	$c = ctx_get('/job/'.$j->token);
	is $c->res->status, 404 , 'job delete ok';
}

done_testing;