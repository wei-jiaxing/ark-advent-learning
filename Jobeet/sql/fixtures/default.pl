my $category_model = models('Schema::Category');
for my $category (qw/Design Programming Manager Administrator/){
	$category_model->create({name => $category});
}

my $pg_category = $category_model->find({name => "Programming"});
#has_many時のキーはjobsだから、add_to_{key}かな
$pg_category->add_to_jobs({
	type         => 'full-time',
    company      => 'Sensio Labs',
    logo         => 'sensio-labs.png',
    url          => 'http://www.sensiolabs.com/',
    position     => 'Web Developer',
    location     => 'Paris, France',
    description  => q[You've already developed websites with symfony and you want to work with Open-Source technologies. You have a minimum of 3 years experience in web development with PHP or Java and you wish to participate to development of Web 2.0 sites using the best frameworks available.],
    how_to_apply => 'Send your resume to fabien.potencier [at] sensio.com',
    is_public    => 1,
    is_activated => 1,
    token        => 'job_sensio_labs1',
    email        => 'job@example.com',
    expires_at   => '2019-10-10',
});

my $design_category = models('Schema::Category')->find({ name => 'Design' });
$design_category->add_to_jobs({
    type         => 'part-time',
    company      => 'Extreme Sensio',
    logo         => 'extreme-sensio.jpg',
    url          => 'http://www.extreme-sensio.com/',
    position     => 'Web Designer',
    location     => 'Paris, France',
    description  => q[Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Utenim ad minim veniam, quis nostrud exercitation ullamco laborisnisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in. Voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpaqui officia deserunt mollit anim id est laborum.],
  how_to_apply   => 'Send your resume to fabien.potencier [at] sensio.com',
    is_public    => 1,
    is_activated => 1,
    token        => 'job_extreme_sensio2',
    email        => 'job@example.com',
    expires_at   => '2019-10-10',
});

my $job_rs = models('Schema::Job');
my $cat_rs = models('Schema::Category');

my $cat_programming = $cat_rs->find({ name => 'Programming' });

for my $i (100 .. 130) {
    my $job = $job_rs->create({
        category_id  => $cat_programming->id,
        company      => "Company $i",
        position     => 'Web Developer',
        location     => 'Paris, France',
        description  => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
        how_to_apply => "Send your resume to lorem.ipsum [at] company_${i}.sit",
        is_public    => 1,
        is_activated => 1,
        token        => "job_$i",
        email        => 'job@example.com',
    });
}

{
    my $affiliate = models('Schema::Affiliate')->create({
        url       => 'http://www.sensio-labs.com/',
        email     => 'fabien.potencier@example.com',
        is_active => 1,
    });
    $affiliate->add_to_category_affiliate({
        category_id => models('Schema::Category')->find({ name => 'Programming' })->id,
    });
}

{
    my $affiliate = models('Schema::Affiliate')->create({
        url       => 'http://www.symfony-project.org/',
        email     => 'fabien.potencier@example.org',
        is_active => 1,
    });
    $affiliate->add_to_category_affiliate({
        category_id => models('Schema::Category')->find({ name => 'Design' })->id,
    });
    $affiliate->add_to_category_affiliate({
        category_id => models('Schema::Category')->find({ name => 'Programming' })->id,
    });
}

1;