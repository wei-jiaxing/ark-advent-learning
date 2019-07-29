package Jobeet::Models;
use strict;
use warnings;
use Ark::Models '-base';
use Cache::FastMmap;

#registerはArkモデルを登録する関数らしい
register Schema => sub {
	my $self = shift;

	my $conf = $self->get('conf')->{database}
		or die 'require database config';

	$self->ensure_class_loaded('Jobeet::Schema');
	Jobeet::Schema->connect(@$conf);
};

for my $table (qw/Job Category CategoryAffiliate Affiliate/){
	register "Schema::$table" => sub {
		my $self = shift;
		$self->get('Schema')->resultset($table);
	};
}

autoloader qr/^Schema::/ => sub {
	my ($self, $name) = @_;

	my $schema = $self->get('Schema');
	for my $t ($schema->sources){
		$self->register("Schema::$t" => sub { $schema->resultset($t) });
	}
};

register cache => sub {
	my $self = shift;

	my $conf = $self->get('conf')->{cache}
		or die 'require cache config';

	$self->ensure_class_loaded('Cache::FastMmap');
    Cache::FastMmap->new(%$conf);
};

1;
