use strict;
use warnings;
use Test::More;
use CGI::Simple;

use_ok 'Jobeet::Form::Job';

{
	my $f = Jobeet::Form::Job->new(
		CGI::Simple->new({
			category     => 'design',
			type         => 'full-time',
			company      => 'Sensio Labs',
			url          => 'http://www.sensio.com/',
			position     => 'Developer',
			location     => 'Atlanta, USA',
			description  =>
				'You will work with symfony to develop websites for our customers.',
			how_to_apply => 'Send me an email',
			email        => 'for.a.job@example.com',
		}),
	);

	ok $f->submitted_and_valid, 'form submitted_and_valid ok';
}

{
	my $f = Jobeet::Form::Job->new(
		CGI::Simple->new({
			company      => 'Sensio Labs',
            position     => 'Developer',
            location     => 'Atlanta, USA',
            email        => 'not.an.email',
		}),
	);

	ok $f->has_error, 'form has error ok';

	like $f->error_message_plain('description'), qr(required), 'description required ok';
	like $f->error_message_plain('how_to_apply'), qr/required/, 'how_to_apply required ok';
	like $f->error_message_plain('category'), qr/required/, 'category required ok';
	like $f->error_message_plain('type'), qr/required/, 'type required ok';
	like $f->error_message_plain('email'), qr/invalid/, 'email is invalid ok';
}

{
	my $f = Jobeet::Form::Job->new(
		CGI::Simple->new({
			category     => 'design',
			type         => 'full-time',
			url          => 'http.not.url',
			description  =>
				'You will work with symfony to develop websites for our customers.',
			how_to_apply => 'Send me an email',
			email        => 'for.a.job@example.com',
		}),
	);

	ok $f->has_error, 'form has error ok';

	like $f->error_message_plain('location'), qr/required/, 'location required ok';
	like $f->error_message_plain('position'), qr/required/, 'position required ok';
	like $f->error_message_plain('company'), qr/required/, 'company required ok';
	like $f->error_message_plain('url'), qr/invalid/, 'url is invalid ok';
}

done_testing;