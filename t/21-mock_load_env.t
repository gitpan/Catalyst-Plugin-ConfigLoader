package MockApp;

use Test::More tests => 9;

use Cwd;
$ENV{ CATALYST_HOME }  = cwd . '/t/mockapp';
$ENV{ MOCKAPP_CONFIG } = $ENV{ CATALYST_HOME } . '/mockapp.pl';

use_ok( 'Catalyst', qw( ConfigLoader ) );

__PACKAGE__->config->{ 'Plugin::ConfigLoader' }->{ substitutions } = {
    foo => sub { shift; join( '-', @_ ); }
};

__PACKAGE__->setup;

ok( __PACKAGE__->config );
is( __PACKAGE__->config->{ 'Controller::Foo' }->{ foo }, 'bar' );
is( __PACKAGE__->config->{ 'Controller::Foo' }->{ new }, 'key' );
is( __PACKAGE__->config->{ 'Model::Baz' }->{ qux },      'xyzzy' );
is( __PACKAGE__->config->{ 'Model::Baz' }->{ another },  'new key' );
is( __PACKAGE__->config->{ 'view' },                     'View::TT::New' );
is( __PACKAGE__->config->{ 'foo_sub' },                  'x-y' );
is( __PACKAGE__->config->{ 'literal_macro' },            '__DATA__' );
