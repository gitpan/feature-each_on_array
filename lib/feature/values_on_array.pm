package feature::values_on_array; # so as not to confuse dzil?
our $VERSION = '0.01'; # VERSION
use strict;
use warnings;
use feature::each_on_array ();
use Carp;
use Scalar::Util qw(reftype);

package Tie::ArrayAsHash;

sub avalues (\[@%]) {
    my $thing = shift;
    return values %$thing
        if reftype $thing eq 'HASH';
    confess "should be passed a HASH or ARRAY"
        unless reftype $thing eq 'ARRAY';

    my $thing_h = $Tie::ArrayAsHash::cache{$thing} ||= do {
        tie my %h, __PACKAGE__, $thing;
        \%h
    };

    values %$thing_h;
}

package feature::values_on_array;

sub import {
    return unless $^V lt 5.12.0;
    no strict 'refs';
    my @caller = caller;
    *{"$caller[0]::values"} = \&avalues;
}

# XXX on unimport, delete symbol

1;
# ABSTRACT: Emulate values(@array) on Perl < 5.12


__END__
=pod

=head1 NAME

feature::values_on_array - Emulate values(@array) on Perl < 5.12

=head1 VERSION

version 0.01

=head1 SYNOPSIS

 # This can run on Perls older than 5.12 and have no effect on 5.12+
 use feature::values_on_array;

 my @a = (qw/a b c/);
 my @values = values @a;

=head1 DESCRIPTION

Beginning with 5.12, Perl supports values() on array. This module emulates the
support on older Perls.

=head1 CAVEATS

Works on a per-package level, but does not work lexically yet.

=head1 SEE ALSO

L<feature::each_on_array>

L<feature::keys_on_array>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

