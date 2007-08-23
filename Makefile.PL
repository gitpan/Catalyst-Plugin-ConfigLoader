use inc::Module::Install 0.65;

name 'Catalyst-Plugin-ConfigLoader';
all_from 'lib/Catalyst/Plugin/ConfigLoader.pm';

requires 'Catalyst::Runtime';
requires 'Data::Visitor' => '0.02';
requires 'Config::Any'   => '0.08';

requires 'Test::More';

auto_install;
WriteAll;
