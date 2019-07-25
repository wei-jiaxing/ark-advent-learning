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

1;