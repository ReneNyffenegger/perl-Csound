#_{ Encoding and name
=encoding utf8
=head1 NAME

Csound::Composition

=cut
#_}
package Csound::Composition;

use warnings;
use strict;

use Carp;

use Csound::Score;

our $VERSION = $Csound::VERSION;
#_{ Synopsis

=head1 SYNOPSIS

    use Csound::Composition;

    my $composition=Csound::Composition->new();

=cut
#_}
#_{ Description
=head1 DESCRIPTION

A Csound composition. Used to create
a L<Csound::Orchestra> and a L<Csound::Score>.

=over

=cut
#_}
#_{ Methods
=head1 METHODS
=cut
sub new { #_{
#_{ POD
=head2 new


    my $composition = Csound::Composition->new();

=cut
#_}

  my $class = shift;

  my $self  = {};

  bless $self, $class;

  die unless $self->isa('Csound::Composition');

  $self->{score} = Csound::Score->new();

  return $self;

} #_}
sub play { #_{
#_{ POD
=head2 play

    my $composition = Csound::Composition->new();

    $composition->play($instr, $t_start, $t_duration, @params);

=cut
#_}

  my $self = shift;

  die unless $self->isa('Csound::Composition');

  my $instr = shift;
  carp "play requires an instrument" unless $instr->isa('Csound::Instrument');

  $self->{score}->play($instr, @_);

} #_}
sub write { #_{
#_{ POD
=head2 play


    $composition->write('filename');

Writes C<filename.orc> and C<filename.sco>.
 

=cut
#_}

  my $self = shift;

  die unless $self->isa('Csound::Composition');

  my $filename_without_suffix = shift;

  $self->{score}->write($filename_without_suffix);

} #_}
#_}
#_{ POD: Copyright

=head1 Copyright
Copyright © 2017 René Nyffenegger, Switzerland. All rights reserved.
This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at: L<http://www.perlfoundation.org/artistic_license_2_0>
=cut

#_}

'tq84';
