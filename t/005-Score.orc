sr     = 44100
kr     =  4410
ksmps  =    10
nchnls =     2
0dbfs  =     1

instr 1

  i_freq init cpspch(p4)

endin

instr 2



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
    

endin
