package Catalyst::Plugin::ConfigLoader;

use strict;
use warnings;

use NEXT;
use Module::Pluggable::Fast
    name    => '_config_loaders',
    search  => [ __PACKAGE__ ],
    require => 1;

our $VERSION = '0.01';

=head1 NAME

Catalyst::Plugin::ConfigLoader - Load config files of various types

=head1 SYNOPSIS

	package MyApp;
	
	use Catalyst( ConfigLoader );
	
    # by default myapp.* will be loaded
    # you can specify a file if you'd like
    __PACKAGE__->config( file = > 'config.yaml' );
    

=head1 DESCRIPTION

This mdoule will attempt to load find and load a configuration
file of various types. Currently it supports YAML, JSON, XML,
INI and Perl formats.

=head1 METHODS

=head2 setup( )

This method is automatically called by Catalyst's setup routine. It will
attempt to use each plugin and set the C<config()> section once a file has been
successfully loaded.

=cut

sub setup {
    my $c        = shift;
    my $confpath = $c->config->{ file } || $c->path_to( Catalyst::Utils::appprefix( ref $c || $c ) );
    
    for my $loader ( $c->_config_loaders ) {
        my $config = $loader->load( $confpath );
        if( $config ) {
            $c->config( $config );
            last;
        }
    }

    $c->NEXT::setup( @_ );
}

=head1 AUTHOR

=over 4 

=item * Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=back

=head1 COPYRIGHT AND LICENSE

Copyright 2006 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=head1 SEE ALSO

=over 4 

=item * L<Catalyst>

=back

=cut

1;