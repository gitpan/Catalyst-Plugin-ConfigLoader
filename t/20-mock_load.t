use Test::More tests => 6;

my $app = MockApp->new;
$app->setup;

ok( $app->config );
is( $app->config->{ 'Controller::Foo' }->{ foo }, 'bar' );
is( $app->config->{ 'Controller::Foo' }->{ new }, 'key' );
is( $app->config->{ 'Model::Baz' }->{ qux }, 'xyzzy' );
is( $app->config->{ 'Model::Baz' }->{ another }, 'new key' );
is( $app->config->{ 'view' }, 'View::TT::New' );

package MockApp;

use base qw( Catalyst::Plugin::ConfigLoader );
use NEXT;
use Catalyst::Utils;

sub new {
    return bless { }, shift;
}

sub path_to {
    return 't/mockapp';
}

sub debug {
    0;
}

sub config {
    my $self = shift;
    $self->{ _config } = {} unless $self->{ _config };
    if (@_) {
        my $config = @_ > 1 ? {@_} : $_[0];
        while ( my ( $key, $val ) = each %$config ) {
            $self->{ _config }->{$key} = $val;
        }
    }
    return $self->{ _config };
}

1;