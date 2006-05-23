use Test::More tests => 2;

use Catalyst::Plugin::ConfigLoader::YAML;

my $config = eval { Catalyst::Plugin::ConfigLoader::YAML->load( 't/conf/conf.yml' ) };

SKIP: {
    skip "Couldn't Load YAML plugin", 2 if $@;
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}
