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
verseSleepKickV = get(:verseSleepKickV)

#Voice
verseVoice = get(:verseVoice)
verseSleepVoice = get(:verseSleepVoice)

live_loop :bass do 
  use_synth :fm
  5.times do
    introSleepBass4.each do |s|
      play introBass.tick(:introBass2), release: 0.3, amp: rrand(1,1.2)
      sleep s
    end
  end
  
  10.times do
    introSleepBass4.each do |s|
      play introBass.tick(:introBass2), release: 0.3, amp: rrand(0.8,1)
      sleep s
    end
  end
  
  10.times do
    introSleepBass4.each do |s|
      play introBass.tick(:introBass2), release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
    sleep verseSleepTrumpet.sum
    sleep verseSleepVoice.sum
  end
  stop
end

live_loop :kick do 
  5.times do
    introSleepKick4[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 1
    end
    sleep introSleepKick4[-1]
  end
  10.times do
    introSleepKick4[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 0.6
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

    verseSleepKickV[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 0.8
    end
    sleep verseSleepKickV[-1]
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
      play introTrumpet.tick(:introTrumpet2)
      sleep s
    end
    sleep verseSleepVoice.sum
  end
  stop
end

live_loop :voice do
  use_synth :prophet
  sleep introSleepBass4.sum*5
  sleep introSleepBass4.sum*10
  10.times do
    use_synth_defaults attack: 0.1, sustain: 0.4, release: 0.6, cutoff: 90, res: 0.7, amp: rrand(0.8, 1.1)
    sleep introSleepBass4.sum
    sleep verseSleepTrumpet.sum
    verseSleepVoice.each do |s|
      play verseVoice.tick(:verseVoice2)
      sleep s
    end
  end
  stop
end


#To add in live
live_loop :fx_break do 
  if get(:robot_on)
    sample :glitch_robot2, amp: 0.6
  end
  sleep [10,15,20].choose
end
