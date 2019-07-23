use strict;
use warnings;
use lib 'lib';
use feature 'say';

use Jobeet::Schema;
my $schema = Jobeet::Schema->connect('dbi:SQLite:./test.db');

my $category_rs = $schema->resultset('Category');

#my $category = $category_rs->create({
#	name => 'new category',
#});
say $category_rs->count;
my $new_rs = $category_rs->search({ name => 'new category'});
say $new_rs->count;

#リファレンスの配列
my @categories = $category_rs->all;
say $categories[0]->id.$categories[0]->name;

while (my $c = $category_rs->next) {
    say $c->id."  ".$c->name;
	$c->update({name => 'new name'});
	say $c->id."  ".$c->name;

	#$c->delete;
}
