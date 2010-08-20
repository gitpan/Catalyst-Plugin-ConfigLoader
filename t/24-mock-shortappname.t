use strict;
use warnings;
use Test::More;

{
    package QX;
    use strict;
    use warnings;
    use Path::Class ();

    use base 'Catalyst::Plugin::ConfigLoader';

    sub config { {} }
    sub path_to { shift; Path::Class::dir('/home/foo/QX-0.9.5/' . shift); }
}

my $app = bless {}, 'QX';
my ($path, $extension) = $app->get_config_path;
is $path, '/home/foo/QX-0.9.5/qx';
is $extension, undef;

done_testing;

