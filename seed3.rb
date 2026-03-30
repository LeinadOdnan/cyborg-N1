#Vars for song
#Bass
introBass = get(:introBass)
danceBrakeSleepBass = get(:danceBrakeSleepBass)

#trumpet
introTrumpet = get(:introTrumpet)
danceBrakeSleepTrumpet = get(:danceBrakeSleepTrumpet)

#Kick
danceBrakeSleepKickB = get(:danceBrakeSleepKickB)

#Voice
verseVoice = get(:verseVoice)
danceBrakeSleepVoice = get(:danceBrakeSleepVoice)

live_loop :bassDanceBrake do
  if get(:danceBrake)
  else
    sync :danceBrake
  end

  20.times do
    danceBrakeSleepBass.each do |s|
      play introBass.tick(:danceBrakeBass), release: 0.3, amp: rrand(1,1.5)
      sleep s
    end
  end
  stop
end

live_loop :kickDanceBrake do
  if get(:danceBrake)
  else
    sync :danceBrake
  end

  20.times do
    playKickPattern(danceBrakeSleepKickB, 1)
  end
  stop
end

live_loop :trumpetDanceBrake do
  if get(:danceBrake)
  else
    sync :danceBrake
  end
  
  use_synth :prophet
  sleep danceBrakeSleepBass.sum*10
  10.times do
    use_synth_defaults release: 0.25, amp: rrand(1.2, 1.8), cutoff: rrand(100,105), res: 0.9
    danceBrakeSleepTrumpet.each do |s|
      play introTrumpet.tick(:danceBrakeTrumpet)
      sleep s
    end
  end
  stop
end

live_loop :voiceDanceBrake do
  if get(:danceBrake)
  else
    sync :danceBrake
  end
  
  use_synth :prophet
  sleep danceBrakeSleepBass.sum*10
  10.times do
    use_synth_defaults attack: 0.1, sustain: 0.4, release: 0.6, cutoff: 90, res: 0.7, amp: rrand(1, 1.5)
    danceBrakeSleepVoice.each do |s|
      play verseVoice.tick(:danceBrakeVoice)
      sleep s
    end
  end
  stop
end


#To add in live
