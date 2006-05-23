use Test::More tests => 2;

use Catalyst::Plugin::ConfigLoader::XML;

my $config = eval { Catalyst::Plugin::ConfigLoader::XML->load( 't/conf/conf.xml' ) };

SKIP: {
    skip "Couldn't Load XML plugin", 2 if $@;
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}
