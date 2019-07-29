? my @jobs = @_;
<table class="jobs">
? my $i = 0;
? for my $job (@jobs) {
    <tr class="<?= $i++ % 2 ? 'even' : 'odd' ?>">
        <td class="location">
          <?= $job->location ?>
        </td>
        <td class="position">
          <?= $job->position ?>
        </td>
        <td class="company">
          <?= $job->company ?>
        </td>
        <td class="detail">
          <a href="<?= $c->uri_for('/job', $job->token)?>">Detail</a>
        </td>
    </tr>

? } #endfor $job
</table>