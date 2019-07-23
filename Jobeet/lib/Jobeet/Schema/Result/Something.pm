package Jobeet::Schema::Result::Something;
use strict;
use warnings;
use Jobeet::Schema::Types;
use parent 'Jobeet::Schema::ResultBase';

__PACKAGE__->table('jobeet_something');

__PACKAGE__->add_columns(
	json_column1 => VARCHAR,
	json_column2 => VARCHAR,
);

__PACKAGE__->inflate_json_colum(qw/json_column1 json_column2/);

1;