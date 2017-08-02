#_{ Encoding and name
=encoding utf8
=head1 NAME

Csound::ScoreStatement

L<http://www.csounds.com/manual/html/ScoregensTop.html>

=cut
#_}

package Csound::ScoreStatement::f;

use warnings;
use strict;
use 5.10.0; # state

use Carp;

use Csound::ScoreStatement;

our $VERSION = $Csound::VERSION;
our @ISA     = qw(Csound::ScoreStatement);

#_{ Synopsis

=head1 SYNOPSIS

    use Csound::ScoreStatement::f;

    ...

=cut
#_}
#_{ Description
=head DESCRIPTION

The C<f> statement causes a so called GEN subroutine to place values in a stored function table.

The syntax is

    f tableNumber actionTime size genRoutine …

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
=cut
#_}

  state $_table_nr = 0;

  my $class    = shift;
  my $gen_nr   = shift;
  my $size     = shift;
  my @params   = @_;

  my $self  = {};

  bless $self, $class;
  die unless $self->isa('Csound::ScoreStatement::f');

  $self->{table_nr} = ++$_table_nr;
  $self->{gen_nr  } = $gen_nr;
  $self->{size    } = $size;
  $self->{params  } =\@params;

  return $self;

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
