package Jobeet::Controller::Search;
use Ark 'Controller';

use Jobeet::Models;

sub index :Path {
	my ($self, $c) = @_;

	my $query = $c->req->parameters->{q}
		or $c->detach('/default');

	$c->stash->{jobs} = models('Schema::Job')->search_fulltext($query);
}

1;