#Dance Brake

#Vars for seed
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
  sync :danceBrake

  use_synth :fm
  20.times do
    danceBrakeSleepBass.each do |s|
      play introBass.tick(:danceBrakeBass), release: 0.3, amp: rrand(1,1.5)
      sleep s
    end
  end
  sync :metro
  sleep 0.5
  cue :piano
  stop
end

live_loop :kickDanceBrake do
  sync :danceBrake

  20.times do
    playKickPattern(danceBrakeSleepKickB, 1)
  end
  stop
end

live_loop :trumpetDanceBrake do
  sync :danceBrake
  
  use_synth :prophet
  20.times do
    use_synth_defaults release: 0.25, amp: rrand(1.2, 1.8), cutoff: rrand(100,105), res: 0.9
    danceBrakeSleepTrumpet.each do |s|
      play introTrumpet.tick(:danceBrakeTrumpet)
      sleep s
    end
  end
  stop
end

live_loop :voiceDanceBrake do
  sync :danceBrake
  
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
live_loop :tom do
  sync :metro
  if get(:tom_on)
    sample :drum_tom_mid_soft, amp: 1.5
  end
  sleep 0.5
end
