#Vars for song
#Bass
introBass = get(:introBass)
introSleepBass4 = get(:introSleepBass4)

#trumpet
introTrumpet = get(:introTrumpet)
verseSleepTrumpet = get(:verseSleepTrumpet)

#Kick
introSleepKick4B = get(:introSleepKick4B)
verseSleepKickT = get(:verseSleepKickT)
verseSleepKickV = get(:verseSleepKickV)

#Voice
verseVoice = get(:verseVoice)
verseSleepVoice = get(:verseSleepVoice)

live_loop :bassVerse do
  if get(:verse)
  else
    sync :verse
  end
  
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

live_loop :kickVerse do
  if get(:verse)
  else
    sync :verse
  end
  
  5.times do
    playKickPattern(introSleepKick4B, 0.8)
  end
  10.times do
    playKickPattern(introSleepKick4B, 0.6)
  end
  10.times do
    playKickPattern(introSleepKick4B, 0.8)
    playKickPattern(verseSleepKickT, 0.8)
    playKickPattern(verseSleepKickV, 0.8)
  end
  stop
end

live_loop :trumpetVerse do
  if get(:verse)
  else
    sync :verse
  end
  
  use_synth :prophet
  sleep introSleepBass4.sum*1
  sleep introSleepBass4.sum*2
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

live_loop :voiceVerse do
  if get(:verse)
  else
    sync :verse
  end
  
  use_synth :prophet
  sleep introSleepBass4.sum*1
  sleep introSleepBass4.sum*2
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
  sync :metro
  if get(:robot_on)
    sample :glitch_robot2, amp: 0.6
  end
  sleep [10,15,20].choose
end