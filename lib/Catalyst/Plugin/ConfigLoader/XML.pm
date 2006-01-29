package Catalyst::Plugin::ConfigLoader::XML;

use strict;
use warnings;

=head1 NAME

Catalyst::Plugin::ConfigLoader::XML - Load XML config files

=head1 DESCRIPTION

Loads XML files. Example:

    <config>
        <name>TestApp</name>
        <component name="Controller::Config">
            <foo>bar</foo>
        </component>
    </config>

=head1 METHODS

=head2 load( $file )

Attempts to load C<$file> as an XML file.

=cut

sub load {
	my $class    = shift;
	my $confpath = shift;

	my $file;
    if( $confpath =~ /\.(.{3})$/ ) {
        return unless $1 eq 'xml';
        $file = $confpath;
    }
    else {
        $file = "$confpath.xml";
    }
    
    return unless -f $file;

    require XML::Simple;
    XML::Simple->import;
    my $config      = XMLin( $file, ForceArray => [ 'component' ] );

    my $components = delete $config->{ component };
	foreach my $element ( keys %$components ) {
            $config->{ $element } = $components->{ $element };
    }

    return $config;
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