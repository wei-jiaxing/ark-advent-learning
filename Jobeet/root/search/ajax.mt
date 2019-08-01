?= include('job/_partial_jobs', $c->stash->{jobs}->all );
? if (scalar($c->stash->{jobs}) <= 0) {
	<div> No Jobs for search text: [<?= $c->req->parameters->{q}?>]
? } #endif