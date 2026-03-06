#use_bpm 107

live_loop :kick do
    sample :bd_sone, amp: 2
    sleep 1
  end
  
  live_loop :clap do
    sleep 1
    sample :perc_snap, amp: 1
    sleep 1
  end
  
  live_loop :bass do
    use_synth :fm
    play_pattern_timed [:as2,:as2,:cs3,:as2], [0.5,0.5,0.5,0.5], amp: 1.2
  end
  
  live_loop :trumpet do
    use_synth :prophet
    play_pattern_timed [:cs4,:ds4,:f4,:ds4],[1,0.5,0.5,2], amp: 0.9
  end
  
  live_loop :tom do
    sleep 2
    sample :drum_tom_mid_soft, amp: 3
    sleep 2
  end