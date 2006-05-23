use Test::More tests => 6;

BEGIN { 
    use_ok( 'Catalyst::Plugin::ConfigLoader' );
    use_ok( 'Catalyst::Plugin::ConfigLoader::INI' );
    use_ok( 'Catalyst::Plugin::ConfigLoader::JSON' );
    use_ok( 'Catalyst::Plugin::ConfigLoader::Perl' );
    use_ok( 'Catalyst::Plugin::ConfigLoader::XML' );
    use_ok( 'Catalyst::Plugin::ConfigLoader::YAML' );
}
