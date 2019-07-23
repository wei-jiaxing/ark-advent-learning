use strict;
use warnings;
use feature qw(say);
use lib 'lib';

use Jobeet::Models;

my $json_string1 = '{"hoge": "fuga"}';
print join ("  ", @lib);
my $data = models('Schema::Something')->create({
	json_column1 => $json_string1,
	json_column2 => '{"Foo": "Bar"}',
});

say $data->json_column1->{hoge};