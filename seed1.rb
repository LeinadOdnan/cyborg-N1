#Vars for song
#Bass
introBass = get(:introBass)
introSleepBass1 = get(:introSleepBass1)
introSleepBass2 = get(:introSleepBass2)
introSleepBass3 = get(:introSleepBass3)
introSleepBass4 = get(:introSleepBass4)

#trumpet
introTrumpet = get(:introTrumpet)
introSleepTrumpet3 = get(:introSleepTrumpet3)

#Kick
introSleepKick2 = get(:introSleepKick2)
introSleepKick3B = get(:introSleepKick3B)
introSleepKick3T = get(:introSleepKick3T)
introSleepKick4B = get(:introSleepKick4B)

live_loop :bassIntro do #This leads the move along the part. We can change note, amp and sleep but keeping a measure along a time.
  sync :metro
  use_synth :fm
  5.times do
    introSleepBass1.each do |s|
      play introBass.tick(:introBass), release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
  end
  
  10.times do
    introSleepBass2.each do |s|
      play introBass.tick(:introBass), release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
  end
  
  10.times do
    introSleepBass3.each do |s|
      play introBass.tick(:introBass), release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
    sleep introSleepTrumpet3.sum
  end
  
  5.times do
    introSleepBass4.each do |s|
      play introBass.tick(:introBass), release: 0.3, amp: rrand(1,1.2)
      sleep s
    end
  end
  sync :metro
  sleep 0.5
  cue :verse
  set :verse, true
  stop
end

live_loop :kickIntro do # This one accentuates the bass ... sometimes.
  sync :metro
  sleep introSleepBass1.sum*5
  10.times do
    playKickPattern(introSleepKick2, 0.8)
  end
  10.times do
    playKickPattern(introSleepKick3B, 0.8)
    playKickPattern(introSleepKick3T, 0.8)
  end
  5.times do
    playKickPattern(introSleepKick4B, 0.8)
  end
  stop
end

live_loop :trumpetIntro do
  sync :metro
  use_synth :prophet
  sleep introSleepBass1.sum*5
  sleep introSleepBass2.sum*10
  10.times do
    use_synth_defaults release: 0.25, amp: rrand(1, 1.4), cutoff: rrand(100,105), res: 0.9
    sleep introSleepBass3.sum
    introSleepTrumpet3.each do |s|
      play introTrumpet.tick(:introTrumpet)
      sleep s
    end
  end
  stop
end



#To add in live
live_loop :clap do
  sync :metro
  sleep 1
  if get(:clap_on)
    sample :perc_snap, amp: 0.6
  end
  sleep 1
end

live_loop :tom do
  sync :metro
  if get(:tom_on)
    sample :drum_tom_mid_soft, amp: 1.5
  end
  sleep 0.5
end
