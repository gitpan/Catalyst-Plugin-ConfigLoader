use inc::Module::Install;

name 'Catalyst-Plugin-ConfigLoader';
all_from 'lib/Catalyst/Plugin/ConfigLoader.pm';

requires 'Catalyst';
requires 'Data::Visitor' => '0.02';
requires 'Config::Any'   => '0.04';

requires 'Test::More';

auto_install;
WriteAll;
