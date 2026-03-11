#use_bpm 107

#Vars for funtions
bassPossibilities = [[1],[1.5],[0.5,1],[0.5,1.5],[0.5,0.5,1],[0.5,0.5,1.5]]

#Funtions
# Bass Pattern Generator
define :randomPattern do
  pattern = []
  total = 0
  adder = (3..8).to_a.choose #Times to add bass and sleep
  while true
    pattern = []
    # generate candidate pattern
    adder.times do
    pattern += bassPossibilities.choose
  end
  total = (pattern.sum*2).to_i #Total time
  if total % 8 == 0 && total <= 24 #checking the time
    return pattern
  end
end
end

#Vars for song
introBass = (ring :as2, :cs3, :f2, :cs3, :gs2)
introSleepBass1 = randomPattern
introSleepBass2 = randomPattern
introSleepBass3 = randomPattern
#introSleepkick = [2, 1, 1]

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
end

live_loop :kick do # This one accentuates the bass.
  sample :bd_sone, amp: 1.5
  sleep introSleepkick.tick
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