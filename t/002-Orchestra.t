use strict;
use warnings;

use Test::More   tests => 2;
use Test::Files;

use Csound::Orchestra;

my $orc = Csound::Orchestra->new();

$orc->write('t/002-gotten.orc');

isa_ok($orc, 'Csound::Orchestra');
compare_ok('t/002-gotten.orc', 't/002-expected.orc', '002.orc should be equal');
