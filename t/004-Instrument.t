use strict;
use warnings;

use Test::More   tests => 23;
use Test::Exception;
# use Test::Files;

use Csound::Instrument;

my $instr_1 = Csound::Instrument->new({parameters=>['param_foo', 'param_bar']});
my $instr_2 = Csound::Instrument->new();
my $instr_3 = Csound::Instrument->new({});
my $instr_4 = Csound::Instrument->new({no_note=>1});
my $instr_5 = Csound::Instrument->new({no_note=>1, parameters=>['x', 'y']});
my $instr_6 = Csound::Instrument->new({definition=>'

  asig vco2 .01, 110
  kcut1 line 60, p3, 300
  kresonance1 = 3
  inumlayer1 = 3
  asig1 lowresx asig, kcut1, kresonance1, inumlayer1
  kcut2 line 300, p3, 60
  kresonance2 = 3
  inumlayer2 = 3
  asig2 lowresx asig, kcut2, kresonance2, inumlayer2
  outs asig1, asig2

'});

# $orc->write('t/002-gotten.orc');

isa_ok($instr_1, 'Csound::Instrument');
isa_ok($instr_2, 'Csound::Instrument');
isa_ok($instr_3, 'Csound::Instrument');

is($instr_1->{nr}, 1, 'Instrument number == 1');
is($instr_2->{nr}, 2, 'Instrument number == 2');

my $note = '4.00';
my $i1_a = $instr_1->i(2.2, 0.3, $note, 4.4, 5.5);
my $i1_b = $instr_1->i(2.5, 0.5, $note, 1  , 2  );

throws_ok { $instr_1->i(2.5, 0.5, $note, 1  , 2  ,  666) }
        qr/expected 3 parameters but was given 4/,
          'Check count of parameters';

my $i2_a = $instr_2->i(3.2, 0.2, $note);
my $i2_b = $instr_2->i(3.5, 0.6, $note);

isa_ok($i1_a, 'Csound::ScoreStatement::i');
isa_ok($i1_b, 'Csound::ScoreStatement::i');
isa_ok($i2_a, 'Csound::ScoreStatement::i');
isa_ok($i2_b, 'Csound::ScoreStatement::i');

isa_ok($i1_a->{params}, 'ARRAY');
isa_ok($i2_a->{params}, 'ARRAY');

is($i1_a->instrument_nr(), 1,   'Instrument number == 1');
is($i1_b->instrument_nr(), 1,   'Instrument number == 1');
is($i2_a->instrument_nr(), 2,   'Instrument number == 2');
is($i2_b->instrument_nr(), 2,   'Instrument number == 2');

is($i1_a->score_text()   , "i1 2.2 0.3 $note 4.4 5.5");

is($instr_1->orchestra_text(), <<ST, 'Check orchestra text instrument 1');
instr 1

  i_freq init cpspch(p4)
  i_param_foo init p5
  i_param_bar init p6

endin
ST

is($instr_2->orchestra_text(), <<ST, 'Check orchestra text instrument 2');
instr 2

  i_freq init cpspch(p4)

endin
ST

is($instr_3->orchestra_text(), <<ST, 'Check orchestra text instrument 3');
instr 3

  i_freq init cpspch(p4)

endin
ST

is($instr_4->orchestra_text(), <<ST, 'Check orchestra text instrument 4');
instr 4


endin
ST

is($instr_5->orchestra_text(), <<ST, 'Check orchestra text instrument 5');
instr 5

  i_x init p4
  i_y init p5

endin
ST

is($instr_6->orchestra_text(), <<ST, 'Check orchestra text for instrument 6');
instr 6

  i_freq init cpspch(p4)


  asig vco2 .01, 110
  kcut1 line 60, p3, 300
  kresonance1 = 3
  inumlayer1 = 3
  asig1 lowresx asig, kcut1, kresonance1, inumlayer1
  kcut2 line 300, p3, 60
  kresonance2 = 3
  inumlayer2 = 3
  asig2 lowresx asig, kcut2, kresonance2, inumlayer2
  outs asig1, asig2


endin
ST
