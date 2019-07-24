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

1;