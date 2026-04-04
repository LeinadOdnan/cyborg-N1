#Piano

#Vars for seed
#Piano
pianoPiano = get(:pianoPiano)
pianoSleepPiano = get(:pianoSleepPiano)

#Blade
pianoBlade = get(:pianoBlade)
pianoSleepBlade = get(:pianoSleepBlade)

#Kick
pianoSleepKickP = get(:pianoSleepKickP)

live_loop :pianoPianoSection do
  sync :piano

  use_synth :piano 
  20.times do
    pianoSleepPiano.each do |s|
      play pianoPiano.tick(:pianoPiano), release: 0.3, amp: rrand(1,1.2)
      sleep s
    end
  end
  sleep pianoSleepBlade.sum
  sync :metro
  sleep 5
  cue :finalBass
  stop
end

live_loop :kickPiano do
  sync :piano

  20.times do
    playKickPattern(pianoSleepKickP, 0.8)
  end
  sleep pianoSleepBlade.sum
  stop
end

live_loop :bladePiano do
  sync :piano
  
  use_synth :blade
  sleep pianoSleepPiano.sum*10
  use_synth_defaults release: 1.5, amp: 1.5
  with_fx :reverb, mix: 0.5, room: 0.8 do
    11.times do
      pianoSleepBlade.each do |s|
        play pianoBlade.tick(:pianoBlade)
        sleep s
      end
    end
  end
  stop
end

#To add in live
live_loop :call do
  sync :metro
  if get(:choir_on)
    sample :ambi_choir, finish: 0.65, release: 0.1, amp: 1.5
  end
  sleep [8,13,18].choose
end
