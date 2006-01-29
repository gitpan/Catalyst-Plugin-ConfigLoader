use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More tests => 2;

use Catalyst::Test 'TestApp';

{
    ok( my $response = request('http://localhost/config/'), 'request ok' );
    is( $response->content, 'foo', 'config ok' );
}
