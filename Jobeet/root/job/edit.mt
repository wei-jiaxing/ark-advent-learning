? extends 'common/jobs_base';

? block content => sub {

<h1>Edit Job</h1>

?= include('job/_partial_form', $c->stash->{form});

? } # endblock content