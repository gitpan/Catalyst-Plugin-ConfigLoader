use Test::More tests => 2;

use Catalyst::Plugin::ConfigLoader::JSON;

my $config = eval { Catalyst::Plugin::ConfigLoader::JSON->load( 't/conf/conf.json' ) };

SKIP: {
    skip "Couldn't Load JSON plugin", 2 if $@;
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}
