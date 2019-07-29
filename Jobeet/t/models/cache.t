use strict;
use warnings;
use Test::More;

use Jobeet::Test;
use Jobeet::Models;

my $cache = models('cache');

ok $cache, 'cache modle return OK';

my $test_key = '_____test_key_____';

ok !$cache->get($test_key), 'cache is not set yet';

$cache->set($test_key => 'Hello');

is $cache->get($test_key), 'Hello', 'cache set ok';

$cache->remove($test_key);

ok !$cache->get($test_key), 'cache remove ok';

done_testing;