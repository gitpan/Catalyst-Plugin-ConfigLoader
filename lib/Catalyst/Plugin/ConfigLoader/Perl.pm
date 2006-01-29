package Catalyst::Plugin::ConfigLoader::Perl;

use strict;
use warnings;

=head1 NAME

Catalyst::Plugin::ConfigLoader::Perl - Load Perl config files

=head1 DESCRIPTION

Loads Perl files. Example:

    {
        name               => 'TestApp',
        Controller::Config => {
            foo => 'bar'
        }
    }

=head1 METHODS

=head2 load( $file )

Attempts to load C<$file> as a Perl file.

=cut

sub load {
	my $class    = shift;
	my $confpath = shift;

	my @files;
    if( $confpath =~ /\.(.{2,4})$/ ) {
        return unless $1 =~ /^p(er)?l$/;
        @files = $confpath;
    }
    else {
        @files = map { "$confpath.$_" } qw( pl perl );
    }
    
    for my $file ( @files ) {
        next unless -f $file;
        return eval { require $file };
    }
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