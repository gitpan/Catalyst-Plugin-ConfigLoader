use inc::Module::Install 0.67;

if( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Catalyst/Plugin/ConfigLoader.pm > README' );
}

name 'Catalyst-Plugin-ConfigLoader';
all_from 'lib/Catalyst/Plugin/ConfigLoader.pm';

requires 'Catalyst::Runtime' => '5.7008'; # needed for env_value()
requires 'Data::Visitor'     => '0.02';
requires 'Config::Any'       => '0.08';

requires 'Test::More';

auto_install;
WriteAll;
