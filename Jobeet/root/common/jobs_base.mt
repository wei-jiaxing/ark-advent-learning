? extends 'common/base';
? block javascripts => sub {
    <script type="text/javascript" src="<?= $c->uri_for('/js/jquery-3.4.1.min.js') ?>"></script>
    <script type="text/javascript" src="<?= $c->uri_for('/js/search.js') ?>"></script>
? } # endblock javascripts

? block stylesheets => sub {
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/main.css') ?>" />
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/jobs.css') ?>" />
? }