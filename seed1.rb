#use_bpm 107
#Vars for funtion
#inter = 
#measurePattern = [4,8,12]

s05 = 0.5 #+
s1 = 1 #+
B = 0.5 #push
#BB = push B x2
#BBB = push B x3

componentsSleep = [s05,s1]
componentsBass = ["B","BB","BBB"]


#Funtions 
define :randomPattern do 
  #measurePatternNow = measurePattern.choose
  sleepBassNow = []
  patternTime = 0
  
    componentsBassNow = componentsBass.choose
    if componentsBassNow == "B"
      sleepBassNow.push(B)
      
    elsif componentsBassNow == "BB"
      sleepBassNow.push(B)
      sleepBassNow.push(B)
      
    elsif componentsBassNow == "BBB"
      sleepBassNow.push(B)
      sleepBassNow.push(B)
      sleepBassNow.push(B)
    end
    
    patternTime = sleepBassNow.sum
    #since hire un a big while, 
    while patternTime != 4
      componentsSleepNow = componentsSleep.choose
      if componentsSleepNow == s05
        sleepBassNow[-1] = sleepBassNow[-1] + s05
        
      elsif componentsSleepNow == s1
        sleepBassNow[-1] = sleepBassNow[-1] + s1
      end
      patternTime = sleepBassNow.sum

    end
    #hire a while inside of big while
    while patternTime != 4
  
  return 
end

#Vars for song
introBass = [:as2, :cs3, :f2, :cs3, :gs2]
introSleepBass = [1, 0.5, 1, 0.5, 1]
introSleepkick = [2, 1, 1]

live_loop :bass do #This leads the move along the part. We can change note, amp and sleep but keeping a measure along a time.
  use_synth :fm
  play_pattern_timed introBass, introSleepBass, release: 0.3, amp: rrand(0.8,1.2)
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