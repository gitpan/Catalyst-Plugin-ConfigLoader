use Test::More tests => 2;

use Catalyst::Plugin::ConfigLoader::Perl;

my $config = eval { Catalyst::Plugin::ConfigLoader::Perl->load( 't/conf/conf.pl' ) };

SKIP: {
    skip "Couldn't Load Perl plugin", 2 if $@;
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}
