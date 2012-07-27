
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Emulate each(\@array) on Perl < 5.12",
  "dist_author" => [
    "Steven Haryanto <stevenharyanto\@gmail.com>"
  ],
  "dist_name" => "feature-each_on_array",
  "dist_version" => "0.01",
  "license" => "perl",
  "module_name" => "feature::each_on_array",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Hash::FieldHash" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
