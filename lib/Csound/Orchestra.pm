#_{ Encoding and name
=encoding utf8
=head1 NAME

Csound::Orchestra

=cut
#_}
package Csound::Orchestra;

use warnings;
use strict;

use Carp;

our $VERSION = $Csound::VERSION;
#_{ Synopsis

=head1 SYNOPSIS

    use Csound::Orchestra;

    my $orchestra=Csound::Orchestra->new();

=cut
#_}
#_{ Methods
=head1 METHODS
=cut
sub new { #_{
#_{ POD
=head2 new
=cut
#_}

  my $class = shift;
  my $self  = {};

  bless $self, $class;
  return $self;

} #_}
#_}
sub write { #_{
#_{ POD
=head2 write

    $orc->write('filename.orc');

=cut
#_}

  my $self = shift;
  croak "$self is a " . ref($self) unless $self->isa('Csound::Orchestra');

  my $orc_filename = shift;
  croak "No filename specified" unless $orc_filename;

  open (my $orc_fh, '>', $orc_filename) or croak "Could not open $orc_filename";

  $self->_write_header($orc_fh);

  close $orc_fh;
  
} #_}
sub _write_header {
#_{ POD
=head2 _write_header

An internal function.

L<http://www.csounds.com/manual/html/OrchTop.html#OrchHeader>

=cut
#_}

  my $self   = shift;
  croak unless $self->isa('Csound::Orchestra');

  my $fh_orc = shift;

  print $fh_orc <<HEADER;
sr     = 44100
kr     =  4410
ksmps  =    10
nchnls =     2
0dbfs  =     1
HEADER

}
#_{ POD: Copyright

=head1 Copyright
Copyright © 2017 René Nyffenegger, Switzerland. All rights reserved.
This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at: L<http://www.perlfoundation.org/artistic_license_2_0>
=cut

#_}

'tq84';
