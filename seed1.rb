#use_bpm 107

live_loop :kick do #It can be played at the beginning and then discussed, but the other instruments are synchronized with it. This one is static.
  sample :bd_sone, amp: 1.1
  sleep 1
end

live_loop :clap do
  sleep 1
  sample :perc_snap, amp: 0.6
  sleep 1
end

live_loop :bass do #This leads the move along the part. We can change note, amp and sleep but keeping a measure along a time.
  use_synth :fm
  play :as2, release: 0.4, amp: 0.9
  sleep 1
end

live_loop :trumpet do
  use_synth :prophet
  sleep 2
  play :cs4, sustain: 0.6, release: 0.3, amp: 0.8
  sleep 2
end

live_loop :tom do
  sleep 3
  sample :drum_tom_mid_soft, amp: 2
  sleep 1
end