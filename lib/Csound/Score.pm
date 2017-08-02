#_{ Encoding and name
=encoding utf8
=head1 NAME

Csound::ScoreStatement

=cut
#_}

package Csound::Score;

use warnings;
use strict;

use Carp;

use Csound;
use Csound::Orchestra;
use Csound::ScoreStatement::f;

our $VERSION = $Csound::VERSION;
#_{ Synopsis

=head1 SYNOPSIS

    use Csound::Score;

    ...

=cut
#_}
#_{ Description
=head DESCRIPTION

Scores

=cut
#_}
#_{ Methods
#_{
=head1 METHODS
=cut
#_}
sub new { #_{
#_{ POD
=head2 new

    my $score = Csound::Score->new();


=cut
#_}

  my $class  = shift;
# my $params = shift // {};

  my $self   = {};

  bless $self, $class;

  $self->{orchestra} = Csound::Orchestra->new();
  $self->{i_stmts}   = [];
  $self->{f_stmts}   = {};

  return $self;

} #_}
sub play { #_{
#_{ POD
=head2 play

    my $instr = Csound::Instrument->new(…)
    …

    $orchestra->play($instr, $t_start, $t_len, "c♯3");



=cut
#_}

  my $self    = shift;
  my $instr   = shift;

  my $t_start = shift;
  my $t_len   = shift;

  if ($instr->plays_note()) { #_{
    my $note = $_[0];

    croak 'instrument plays a note, but none was given' unless defined $note;

    croak "instrument plays a note, but $note is none" unless Csound::is_note($note);
  } #_}


  die unless $self->isa('Csound::Score');

  croak "First argument is not an instrument" unless $instr->isa('Csound::Instrument');

  $self->{orchestra}->use_instrument($instr);

  my $i = $instr->i($t_start, $t_len, @_);

  die "i is not an Csound::ScoreStatement::i" unless $i->isa('Csound::ScoreStatement::i');

  push @{$self->{i_stmts}}, $i;

  return $self;

} #_}
sub f { #_{
#_{ POD
=head2 f

Create a L<< Csound::ScoreStatement::f >>.

Probably called from L<< Csound::Instrument/orchestra_text >>

=cut
#_}

  my $self = shift;

  my @f_parameters = @_;

  croak unless $self->isa('Csound::Score');

  my $f_key =join '/', @f_parameters;
  if (exists $self->{f_stmts}{$f_key}) {
    return $self->{f_stmts}{$f_key};
  }

  $self->{f_stmts}{$f_key} = Csound::ScoreStatement::f->new(@f_parameters);

  return $self->{f_stmts}{$f_key};

} #_}
sub write { #_{
#_{ POD
=head2 play

    $score->write('filename');


Writes C<filename.sco> and C<filename.orc>.

C<filename.orc> is written by calling C<< $self->{orchestra}->write("$filename.orc") >>


=cut
#_}

  my $self     = shift;
  my $filename = shift;

  $self->{orchestra}->write("$filename.orc");

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
