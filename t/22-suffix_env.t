use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More tests => 3;

BEGIN {
    $ENV{ TESTAPP_CONFIG_LOCAL_SUFFIX } = 'test';
    use_ok 'Catalyst::Test', 'TestApp';
}

ok my ( $res, $c ) = ctx_request( '/' ), 'context object';

is $c->get_config_local_suffix, 'test', 'suffix is "test"';
