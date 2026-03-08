#use_bpm 107

#xxxxxxxxxxxxxxxxxxxxxx
#s05 = 0.5 #+
#s1 = 1 #+
#B = 0.5 #push
#BB = push B x2
#BBB = push B x3

#componentsSleep = [s05,s1]
#componentsBass = ["B","BB","BBB"]

#Funtions 
=begin
define :randomPattern do 
    sleepBassNow = []
    patternTime = 0
    multiplier = 1

    #To choose the syncopated bass
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
    #since here un a big while, 
    while patternTime != 4*multiplier
      #to updating multiplier
      if patternTime > 4*multiplier
        multiplier = multiplier + 1
      end

      #To choose the sleep
      componentsSleepNow = componentsSleep.choose
      if componentsSleepNow == s05
        sleepBassNow[-1] = sleepBassNow[-1] + s05
        
      elsif componentsSleepNow == s1
        sleepBassNow[-1] = sleepBassNow[-1] + s1
      end
      patternTime = sleepBassNow.sum

      #here a while inside of big while
      while patternTime != 4*multiplier
        #to updating multiplier
        if patternTime > 4*multiplier
          multiplier = multiplier + 1
        end

        #To choose the syncopated bass
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
      end
    end
    
    return sleepBassNow
end
=end
#xxxxxxxxxxxxxxxxxxxxxx
#Vars for funtions
bassPossibilities = [[1],[1.5],[0.5,1],[0.5,1.5],[0.5,0.5,1],[0.5,0.5,1.5]]

#Funtions 
# Bass Pattern Generator
define :randomPattern do
    pattern = []
    total = 0
    adder = (5..20).to_a.choose #Times to add bass and sleep
    # generate candidate pattern
    for i in 1..adder
      bassPossibilityNow = bassPossibilities.choose
      pattern += bassPossibilityNow
    end
    total = (pattern.sum*2).to_i
    # comprobar condición
    while total % 8 != 0 || total > 24
      pattern = []
      total = 0
      adder = (5..20).to_a.choose #Times to add bass and sleep
      # generate candidate pattern
      for i in 1..adder
        bassPossibilityNow = bassPossibilities.choose
        pattern += bassPossibilityNow
      end
      total = (pattern.sum*2).to_i
    end
    return pattern
end

#Vars for song
introBass = (ring :as2, :cs3, :f2, :cs3, :gs2)
introSleepBass = randomPattern
#introSleepkick = [2, 1, 1]

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