#Vars for song
#Bass
introBass = get(:introBass)
introSleepBass4 = get(:introSleepBass4)

#trumpet
introTrumpet = get(:introTrumpet)
verseSleepTrumpet = get(:verseSleepTrumpet)

#Kick
introSleepKick4 = get(:introSleepKick4)
verseSleepKickT = get(:verseSleepKickT)

live_loop :bass do 
  use_synth :fm
  5.times do
    introSleepBass4.each do |s|
      play introBass.tick(:introBass), release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
  end
  
  10.times do
    introSleepBass4.each do |s|
      play introBass.tick(:introBass), release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
  end
  
  10.times do
    introSleepBass4.each do |s|
      play introBass.tick(:introBass), release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
    sleep verseSleepTrumpet.sum
  end
  stop
end

live_loop :kick do 
  5.times do
    introSleepKick4[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 0.8
    end
    sleep introSleepKick4[-1]
  end
  10.times do
    introSleepKick4[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 0.8
    end
    sleep introSleepKick4[-1]
  end
  10.times do
    introSleepKick4[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 0.8
    end
    sleep introSleepKick4[-1]

    verseSleepKickT[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 0.8
    end
    sleep verseSleepKickT[-1]
  end
  stop
end

live_loop :trumpet do
  use_synth :prophet
  sleep introSleepBass4.sum*5
  sleep introSleepBass4.sum*10
  10.times do
    use_synth_defaults release: 0.25, amp: rrand(1, 1.4), cutoff: rrand(100,105), res: 0.9
    sleep introSleepBass4.sum
    verseSleepTrumpet.each do |s|
      play introTrumpet.tick(:introTrumpet)
      sleep s
    end
  end
  stop
end

#To lack another instrument more such as trumpet



#To add in live
live_loop :clap do 
  sleep 1
  if get(:clap_on)
    sample :perc_snap, amp: 0.6
  end
  sleep 1
end

live_loop :tom do
  if get(:tom_on)
    sample :drum_tom_mid_soft, amp: 1
  end
  sleep 0.5
end