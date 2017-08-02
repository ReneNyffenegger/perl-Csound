use strict;
use warnings;
use utf8;

use Test::More   tests => 12;
use Test::Exception;

use Csound::Score;
use Csound::Instrument;

my $score = Csound::Score->new();

isa_ok($score, 'Csound::Score', 'score is a score');

my $instr_1 = Csound::Instrument -> new({definition =>'
  asig oscili 5000, i_freq, @FUNCTABLE(10, 8192, 1, 0.8, 0.6, 0.4)
  outs asig, asig
'});
my $instr_2 = Csound::Instrument -> new({no_note=>1, definition=>'

  asig oscili 2000, 440, @FUNCTABLE(10, 4096, 1)
  outs asig, asig
    
'});

isa_ok($instr_1, 'Csound::Instrument', 'isntr_1 is a Csound::Instrument');
isa_ok($instr_2, 'Csound::Instrument', 'isntr_1 is a Csound::Instrument');

is(scalar keys %{$score->{orchestra}->{instruments}}, 0, "No instruments in orchestra");

my $t = 0;                                        is(scalar @{$score->{i_stmts}}, 0, "nof i_stmts: 0");
$score->play($instr_1, $t++ * 0.25, 0.25, 'c6' ); is(scalar @{$score->{i_stmts}}, 1, "nof i_stmts: 1"); is(scalar keys %{$score->{orchestra}->{instruments}}, 1, "One instrument in orchestra");
$score->play($instr_1, $t++ * 0.25, 0.25, 'c♯6');                                                       is(scalar keys %{$score->{orchestra}->{instruments}}, 1, "One instrument in orchestra");
$score->play($instr_1, $t++ * 0.25, 0.25, 'd6' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'e♭6');
$score->play($instr_1, $t++ * 0.25, 0.25, 'e6' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'f6' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'g♭6');
$score->play($instr_1, $t++ * 0.25, 0.25, 'g6' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'g♯6');
$score->play($instr_1, $t++ * 0.25, 0.25, 'a6' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'b6' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'c7' ); is(scalar @{$score->{i_stmts}}, 12, "nof i_stmts: 12");


throws_ok
   { $score->play($instr_1, 999, 999, 'NoNote') } 
   qr /instrument plays a note, but NoNote is none/,
   '$instrument must play a note';

throws_ok
   { $score->play($instr_1, 999, 999) } 
   qr /instrument plays a note, but none was given/,
   '$instrument must play a note';

$score->play($instr_2, 0, 1);
$score->play($instr_2, 2, 1);
is(scalar keys %{$score->{orchestra}->{instruments}}, 2, "Two instruments in orchestra");


$score->write('t/005-Score-gotten');
