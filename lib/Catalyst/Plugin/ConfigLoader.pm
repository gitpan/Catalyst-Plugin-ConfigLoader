package Catalyst::Plugin::ConfigLoader;

use strict;
use warnings;

use NEXT;
use Module::Pluggable::Fast
    name    => '_config_loaders',
    search  => [ __PACKAGE__ ],
    require => 1;
use Data::Visitor::Callback;

our $VERSION = '0.06';

=head1 NAME

Catalyst::Plugin::ConfigLoader - Load config files of various types

=head1 SYNOPSIS

    package MyApp;
    
    # ConfigLoader should be first in your list so
    # other plugins can get the config information
    use Catalyst qw( ConfigLoader ... );
	
    # by default myapp.* will be loaded
    # you can specify a file if you'd like
    __PACKAGE__->config( file = > 'config.yaml' );    

=head1 DESCRIPTION

This module will attempt to load find and load a configuration
file of various types. Currently it supports YAML, JSON, XML,
INI and Perl formats.

To support the distinction between development and production environments,
this module will also attemp to load a local config (e.g. myapp_local.yaml)
which will override any duplicate settings.

=head1 METHODS

=head2 setup( )

This method is automatically called by Catalyst's setup routine. It will
attempt to use each plugin and, once a file has been successfully
loaded, set the C<config()> section. 

=cut

sub setup {
    my $c    = shift;
    my $path = $c->config->{ file } || $c->path_to( Catalyst::Utils::appprefix( ref $c || $c ) );

    my( $extension ) = ( $path =~ /\.(.{1,4})$/ );
    
    for my $loader ( $c->_config_loaders ) {
        my @files;
        my @extensions = $loader->extensions;
        if( $extension ) {
            next unless grep { $_ eq $extension } @extensions;
            push @files, $path;
        }
        else {
            @files = map { ( "$path.$_", "${path}_local.$_" ) } @extensions;
        }

        for( @files ) {
            next unless -f $_;
            my $config = $loader->load( $_ );
            $c->config( $config ) if $config;
        }
    }

    $c->finalize_config;

    $c->NEXT::setup( @_ );
}

=head2 finalize_config

This method is called after the config file is loaded. It can be
used to implement tuning of config values that can only be done
at runtime. If you need to do this to properly configure any
plugins, it's important to load ConfigLoader before them.
ConfigLoader provides a default finalize_config method which
walks through the loaded config hash and replaces any strings
beginning containing C<__HOME__> with the full path to
app's home directory (i.e. C<$c-E<gt>path_to('')> ).
You can also use C<__path_to('foo/bar')__> which translates to
C<$c-E<gt>path_to('foo', 'bar')> 

=cut

sub finalize_config {
    my $c = shift;
    my $v = Data::Visitor::Callback->new(
        plain_value => sub {
            return unless defined $_;
            s[__HOME__][ $c->path_to( '' ) ]e;
            s[__path_to\((.+)\)__][ $c->path_to( split( '/', $1 ) ) ]e;
        }
    );
    $v->visit( $c->config );
}

=head1 AUTHOR

=over 4 

=item * Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=back

=head1 CONTRIBUTORS

The following people have generously donated their time to the
development of this module:

=over 4

=item * David Kamholz E<lt>dkamholz@cpan.orgE<gt>

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
