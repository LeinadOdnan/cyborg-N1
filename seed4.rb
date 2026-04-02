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
  if get(:piano)
  else
    sync :piano
  end

  use_synth :piano 
  20.times do
    pianoSleepPiano.each do |s|
      play pianoPiano.tick(:pianoPiano), release: 0.3, amp: rrand(1,1.2)
      sleep s
    end
  end
  sleep pianoSleepBlade.sum
  stop
end

live_loop :kickPiano do
  if get(:piano)
  else
    sync :piano
  end

  20.times do
    playKickPattern(pianoSleepKickP, 0.8)
  end
  sleep pianoSleepBlade.sum
  stop
end

live_loop :bladePiano do
  if get(:piano)
  else
    sync :piano
  end
  
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
#calls or seemed
