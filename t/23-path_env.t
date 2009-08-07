use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More tests => 3;

BEGIN {
    $ENV{ TESTAPP_CONFIG } = 'test.perl';
    use_ok 'Catalyst::Test', 'TestApp';
}

ok my ( $res, $c ) = ctx_request( '/' ), 'context object';

is_deeply [ $c->get_config_path ], [ qw( test.perl perl ) ], 'path is "test.perl"';
