package Jobeet::Controller::Job;
use Ark 'Controller';

use Jobeet::Models;

# index: Path('foo')なら /job/fooにマッチして、index.mtを使う
# index: Localなら /job/indexにマッチして、index.mtを使う
sub index: Path{
	my($self, $c) = @_;
	# stashはグローバル変数の入れ物、VとCの間で変数共有に使用される
	$c->stash->{jobs} = models('Schema::Job');
}

# /job/{job_token}
sub show :Path :Arg(1){
	my ($self, $c, $job_token) = @_;
}

# /job/create
sub create: Local{
	my ($self, $c) = @_;
}

sub job :Chained('/') :PathPart :CaptureArgs(1){
	my ($self, $c, $job_token) = @_;
	$c->stash->{$job_token} = $job_token;
}

#/job/*/edit
#Chained中の引数は関数名つまり↑のjob
sub edit :Chained('job') :PathPart :Args(0){
	my ($self, $c) = @_;
}

sub delete :Chained('job') :PathPart :Args(0){
	my ($self, $c) = @_;
}

1;