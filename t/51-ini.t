use Test::More tests => 2;

use Catalyst::Plugin::ConfigLoader::INI;

my $config = eval { Catalyst::Plugin::ConfigLoader::INI->load( 't/conf/conf.ini' ) };

SKIP: {
    skip "Couldn't Load INI plugin", 2 if $@;
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}