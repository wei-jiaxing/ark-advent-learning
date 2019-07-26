use strict;
use warnings;
use Test::More;

use Jobeet::Test;
use Jobeet::Models;

{
	my $new_category = models('Schema::Category')->create({name => 'CamelCase'});

	#紹介されないけど、第三引数はテストのディスクリプションらしい
	is $new_category->slug, 'camel_case', 'slug column: create slug column automatically.';

	$new_category->name('UpdateCateName');
	$new_category->update;
	is $new_category->slug, 'update_cate_name', 'slug column: update slug column automatically.';
}

done_testing;