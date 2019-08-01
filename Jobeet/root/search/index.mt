? extends 'common/jobs_base';

? block content => sub {

<div id="jobs">
?= include('job/_partial_jobs', $c->stash->{jobs}->all );
</div>
? if (scalar($c->stash->{jobs}) <= 0) {
	<div> No Jobs for search text: [<?= $c->req->param('q')?>]
? } #endif
? } # endblock content