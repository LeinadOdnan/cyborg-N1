#use_bpm 107

#Vars for funtions
bassPossibilities = [[1],[1.5],[0.5,1],[0.5,1.5],[0.5,0.5,1],[0.5,0.5,1.5]]

#Funtions
# Bass Pattern Generator
define :randomPattern do
  adder = (3..8).to_a.choose
  
  while true
    pattern = []
    
    adder.times do
      pattern += bassPossibilities.choose
    end
  
    total = (pattern.sum * 2).to_i
  
    if total % 8 == 0 && total <= 24
      return pattern
    end
  end
end


#Kick Pattern Generator
define :kickBeats do |hits, beats|
  grid = (0...(beats*2)).map{|i| i*0.5}
  introGridKick = grid.shuffle.take(hits).sort
  
  sleeps = []
  last = 0
  
  introGridKick.each do |p|
    sleeps.push(p - last)
    last = p
  end
  
  sleeps.push(beats - last)
  
  return sleeps
end

#Vars for song
#Bass
introBass = (ring :as2, :cs3, :f2, :cs3, :gs2)
introSleepBass1 = randomPattern
introSleepBass2 = randomPattern
introSleepBass3 = randomPattern

#Kick
introSleepKick1 = kickBeats(introSleepBass1.length - 2, (introSleepBass1.sum).to_i)
introSleepKick2 = kickBeats(introSleepBass2.length - 2, (introSleepBass2.sum).to_i)
introSleepKick3 = kickBeats(introSleepBass3.length - 2, (introSleepBass3.sum).to_i)

live_loop :bass do #This leads the move along the part. We can change note, amp and sleep but keeping a measure along a time.
  use_synth :fm
  10.times do
    introSleepBass1.each do |s|
      play introBass.tick, release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
  end
  
  10.times do
    introSleepBass2.each do |s|
      play introBass.tick, release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
  end
  
  10.times do
    introSleepBass3.each do |s|
      play introBass.tick, release: 0.3, amp: rrand(0.8,1.2)
      sleep s
    end
  end
  stop
end

live_loop :kick do # This one accentuates the bass ... sometimes.
  10.times do
    introSleepKick1[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 1.5
    end
    sleep introSleepKick1[-1]
  end
  10.times do
    introSleepKick2[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 1.5
    end
    sleep introSleepKick2[-1]
  end
  10.times do
    introSleepKick3[0...-1].each do |s|
      sleep s
      sample :bd_sone, amp: 1.5
    end
    sleep introSleepKick3[-1]
  end
  stop
end

live_loop :clap do
  sleep 1
  sample :perc_snap, amp: 0.6
  sleep 1
end

live_loop :trumpet do
  use_synth :prophet
  sleep 2
  play :cs4, sustain: 0.6, release: 0.3, amp: 0.8
  sleep 2
end

live_loop :tom do
  sleep 3
  sample :drum_tom_mid_soft, amp: 2
  sleep 1
end