package Jobeet::Schema::Result::Job;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Schema::Types;
use Jobeet::Models;
use Digest::SHA1 qw(sha1_hex);
use Data::UUID;

# __PACKAGE__はこのファイルのパーケージ名を取得する
__PACKAGE__->table('jobeet_job');

__PACKAGE__->add_columns(
	id => PK_INTEGER,
	category_id => PK_INTEGER,
	type => NULLABLE_VARCHAR,
	position => VARCHAR,
    company => NULLABLE_VARCHAR,
    logo => NULLABLE_VARCHAR,
    url => NULLABLE_VARCHAR,
    location => VARCHAR,
    description => {
        data_type   => 'TEXT',
        is_nullable => 0,
    },
    how_to_apply => {
        data_type   => 'TEXT',
        is_nullable => 0,
    },
    token => VARCHAR,
    is_public => TINYINT(
        default_value => 1,
    ),
    is_activated => TINYINT,
    email => VARCHAR,
    expires_at => DATETIME,
    created_at => DATETIME,
    updated_at => DATETIME,
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['token']);

__PACKAGE__->belongs_to( category => 'Jobeet::Schema::Result::Category', 'category_id');

sub insert {
    my $self = shift;
    $self->expires_at( models('Schema')->now->add( days => models('conf')->{active_days} ));
    $self->token( sha1_hex(Data::UUID->new->create) );
    $self->next::method(@_);
}

sub is_expired {
    my ($self) = @_;
    $self->days_before_expired < 0;
}

sub days_before_expired {
    my ($self) = @_;
    ($self->expires_at - models('Schema')->now)->days;
}

sub expires_soon {
    my ($self) = @_;
    $self->days_before_expired < 5;
}

sub publish {
    my ($self) = @_;
    $self->update({ is_activated => 1 });
}

sub update_from_form {
    my ($self, $form) = @_;
    my $category_slug = delete $form->params->{category};
    my $category = models('Schema::Category')->find({slug => $category_slug})
        or die 'no such category: ', $category_slug;
    $self->update({
        category_id => $category->id,
        %{ $form->params },
    });
}