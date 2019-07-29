package Jobeet;
use Ark;
use Data::Page::Navigation;

use_model 'Jobeet::Models';
our $VERSION = '0.01';

__PACKAGE__->meta->make_immutable;

use_plugins qw(
	Session
	Session::State::Cookie
	Session::Store::Model
);

config 'Plugin::Session' => {
	expires => '+30d',
};

config 'Plugin::Session::State::Cookie' => {
	cookie_name => 'Jobeet_session',
};

config 'Plugin::Session::Store::Model' => {
	model => 'cache',
};

__END__

=head1 NAME

Jobeet -

=head1 SYNOPSIS

use Jobeet;

=head1 DESCRIPTION

Jobeet is

=head1 AUTHOR

Wei Jiaxing E<lt>rockwjx@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
