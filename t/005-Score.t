use strict;
use warnings;
use utf8;

use Test::More   tests => 12;
use Test::Exception;

use Csound::Score;
use Csound::Instrument;

my $score = Csound::Score->new();

isa_ok($score, 'Csound::Score', 'score is a score');

my $instr_1 = Csound::Instrument -> new();
my $instr_2 = Csound::Instrument -> new({no_note=>1, definition=>'

  asig vco2 .01, 110	; sawtooth waveform at low volume
  ;filter a channel
  kcut1 line 60, p3, 300	; Vary cutoff frequency
  kresonance1 = 3
  inumlayer1 = 3
  asig1 lowresx asig, kcut1, kresonance1, inumlayer1
  ;filter the other channel
  kcut2 line 300, p3, 60	; Vary cutoff frequency
  kresonance2 = 3
  inumlayer2 = 3
  asig2 lowresx asig, kcut2, kresonance2, inumlayer2

  outs asig1, asig2	; output both channels 1 & 2
    
'});

isa_ok($instr_1, 'Csound::Instrument', 'isntr_1 is a Csound::Instrument');
isa_ok($instr_2, 'Csound::Instrument', 'isntr_1 is a Csound::Instrument');

is(scalar keys %{$score->{orchestra}->{instruments}}, 0, "No instruments in orchestra");

my $t = 0;                                        is(scalar @{$score->{i_stmts}}, 0, "nof i_stmts: 0");
$score->play($instr_1, $t++ * 0.25, 0.25, 'c4' ); is(scalar @{$score->{i_stmts}}, 1, "nof i_stmts: 1"); is(scalar keys %{$score->{orchestra}->{instruments}}, 1, "One instrument in orchestra");
$score->play($instr_1, $t++ * 0.25, 0.25, 'c♯4');                                                       is(scalar keys %{$score->{orchestra}->{instruments}}, 1, "One instrument in orchestra");
$score->play($instr_1, $t++ * 0.25, 0.25, 'd4' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'e♭4');
$score->play($instr_1, $t++ * 0.25, 0.25, 'e4' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'f4' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'g♭4');
$score->play($instr_1, $t++ * 0.25, 0.25, 'g4' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'g♯4');
$score->play($instr_1, $t++ * 0.25, 0.25, 'a4' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'b4' );
$score->play($instr_1, $t++ * 0.25, 0.25, 'c5' ); is(scalar @{$score->{i_stmts}}, 12, "nof i_stmts: 12");


throws_ok
   { $score->play($instr_1, 999, 999, 'NoNote') } 
   qr /instrument plays a note, but NoNote is none/,
   '$instrument must play a note';

throws_ok
   { $score->play($instr_1, 999, 999) } 
   qr /instrument plays a note, but none was given/,
   '$instrument must play a note';

$score->play($instr_2, 0, 1);
is(scalar keys %{$score->{orchestra}->{instruments}}, 2, "Two instruments in orchestra");


$score->write('t/005-Score');
