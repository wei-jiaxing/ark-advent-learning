package Jobeet::Controller::Job;
use Ark 'Controller';
with 'Ark::ActionClass::Form';

use Jobeet::Models;

# index: Path('foo')なら /job/fooにマッチして、index.mtを使う
# index: Localなら /job/indexにマッチして、index.mtを使う
sub index :Path :Args(0){
	my($self, $c) = @_;

	$c->stash->{categories} = models('Schema::Category')->get_with_jobs;
}

# /job/{job_token}
sub show :Path :Args(1){
	my ($self, $c, $job_token) = @_;

	$c->stash->{job} = models('Schema::Job')->find({token => $job_token})
		or $c->detach('/default');
}

# /job/create
sub create :Local :Form('Jobeet::Form::Job'){
	my ($self, $c) = @_;

	$c->stash->{form} = $self->form;

	if ($c->req->method eq 'POST' and $self->form->submitted_and_valid){
		my $job = models('Schema::Job')->create_from_form($self->form);
		$c->redirect( $c->uri_for('/job', $job->token));
	}
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