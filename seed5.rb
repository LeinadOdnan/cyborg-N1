#Final Bass

#Vars for seed
#Bass
introBass = get(:introBass)
introSleepBass4 = get(:introSleepBass4)
danceBrakeSleepBass = get(:danceBrakeSleepBass)

#trumpet
introTrumpet = get(:introTrumpet)
verseSleepTrumpet = get(:verseSleepTrumpet)
danceBrakeSleepTrumpet = get(:danceBrakeSleepTrumpet)

#Kick
introSleepKick4B = get(:introSleepKick4B)
verseSleepKickT = get(:verseSleepKickT)
verseSleepKickV = get(:verseSleepKickV)
danceBrakeSleepKickB = get(:danceBrakeSleepKickB)

#Voice
verseVoice = get(:verseVoice)
verseSleepVoice = get(:verseSleepVoice)
danceBrakeSleepVoice = get(:danceBrakeSleepVoice)

live_loop :bassFinalBass do
    sync :finalBass

  use_synth :fm
  5.times do
    introSleepBass4.each do |s|
      play introBass.tick(:finalBassBass), release: 0.3, amp: rrand(1,1.2)
      sleep s
    end
  end
  
  5.times do
    introSleepBass4.each do |s|
      play introBass.tick(:finalBassBass), release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
    sleep verseSleepTrumpet.sum
    sleep verseSleepVoice.sum
  end

  20.times do
    danceBrakeSleepBass.each do |s|
      play introBass.tick(:finalBassBass), release: 0.3, amp: rrand(1,1.5)
      sleep s
    end
  end
  stop
end

live_loop :kickFinalBass do
    sync :finalBass

  5.times do
    playKickPattern(introSleepKick4B, 0.8)
  end

  5.times do
    playKickPattern(introSleepKick4B, 0.8)
    playKickPattern(verseSleepKickT, 0.8)
    playKickPattern(verseSleepKickV, 0.8)
  end

  20.times do
    playKickPattern(danceBrakeSleepKickB, 1)
  end
  stop
end

live_loop :trumpetFinalBass do
    sync :finalBass
    
    use_synth :prophet
    sleep introSleepBass4.sum*5
    5.times do
      use_synth_defaults release: 0.25, amp: rrand(1, 1.4), cutoff: rrand(100,105), res: 0.9
      sleep introSleepBass4.sum
      verseSleepTrumpet.each do |s|
        play introTrumpet.tick(:finalBassTrumpet)
        sleep s
      end
      sleep verseSleepVoice.sum
    end

    20.times do
        use_synth_defaults release: 0.25, amp: rrand(1.2, 1.8), cutoff: rrand(100,105), res: 0.9
        danceBrakeSleepTrumpet.each do |s|
          play introTrumpet.tick(:finalBassTrumpet)
          sleep s
        end
    end
    stop
end

live_loop :voiceFinalBass do
    sync :finalBass
    
    use_synth :prophet
    sleep introSleepBass4.sum*5
    5.times do
      use_synth_defaults attack: 0.1, sustain: 0.4, release: 0.6, cutoff: 90, res: 0.7, amp: rrand(0.8, 1.1)
      sleep introSleepBass4.sum
      sleep verseSleepTrumpet.sum
      verseSleepVoice.each do |s|
        play verseVoice.tick(:finalBassVoice)
        sleep s
      end
    end

    20.times do
        use_synth_defaults attack: 0.1, sustain: 0.4, release: 0.6, cutoff: 90, res: 0.7, amp: rrand(1, 1.5)
        danceBrakeSleepVoice.each do |s|
          play verseVoice.tick(:finalBassVoice)
          sleep s
        end
    end
    stop
end
