package Jobeet::Schema::ResultSet::Job;
use strict;
use warnings;
use utf8;
use parent 'DBIx::Class::ResultSet';

use Jobeet::Models;

sub create_from_form {
	my ($self, $form) = @_;

	my $txn_guard = models('Schema')->txn_scope_guard;

	#パラメーターを返す同時に deleteする(あとで)
	my $category_slug = delete $form->params->{category};
	my $category = models('Schema::Category')->find({slug => $category_slug})
		or die 'no such category: ', $category_slug;

	my $job = $self->create({
		category_id => $category->id,
		%{ $form->params},
	});

	$txn_guard->commit;

	$job;
}

sub latest_post {
	my ($self) = @_;

	my $r = $self->search(
		{ is_activeated => 1 },
		{ order_by => {-desc => 'create_at'} }
	);

	$r->first;
}

sub search_fulltext {
	my ($self, $word) = @_;

	my $r = $self->search(
		{
			is_activated => 1,
			-or => [
				{ description => { -like => "%${word}%", } },
				{ how_to_apply => { -like => "%${word}%", } },
			]
		},
		{ order_by => { -desc => 'created_at' }, rows => 20 }
	);
}

1;