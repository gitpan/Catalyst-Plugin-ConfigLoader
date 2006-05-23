use Test::More tests => 2;

use Catalyst::Plugin::ConfigLoader::General;

my $config = eval { Catalyst::Plugin::ConfigLoader::General->load( 't/conf/conf.general' ) };

SKIP: {
    skip "Couldn't Load Config::General plugin", 2 if $@;
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}
