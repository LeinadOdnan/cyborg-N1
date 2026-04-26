#use_bpm 107

#Vars for funtions
bassPossibilities = [[1],[1.5],[0.5,1],[0.5,1.5],[0.5,0.5,1],[0.5,0.5,1.5]]
use_random_seed Time.now.to_i #Always different pattern

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
    hits = [hits, 1].max
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

#Play kick pattern
define :playKickPattern do |pattern, amp|
  pattern[0...-1].each do |s|
    sleep s
    sample :bd_sone, amp: amp
  end
  sleep pattern[-1]
end

#Play external samples
define :playExternalSample do |externalSample, pattern|
  pattern[0...-1].each do |s|
    sleep s
    sample externalSample, rate: [1.1, 1.15, 1.20].choose, amp: [0.5, 0.6, 0.7].choose
  end
  sleep pattern[-1]
end

# external sample effects
define :fx_externalSample do |&block|
  with_fx :lpf, cutoff: [100, 105, 110, 115, 120].choose, res: 0.7 do
    with_fx :echo, phase: 0.25, mix: 0.1 do
      block.call
    end
  end
end
  
#Vars for song
#Bass
set :introBass, (ring :as2, :cs3, :f2, :cs3, :gs2)
introSleepBass1Var = randomPattern
set :introSleepBass1, introSleepBass1Var
introSleepBass2Var = randomPattern
set :introSleepBass2, introSleepBass2Var
introSleepBass3Var = randomPattern
set :introSleepBass3, introSleepBass3Var
introSleepBass4Var = randomPattern
set :introSleepBass4, introSleepBass4Var
danceBrakeSleepBassVar = randomPattern
set :danceBrakeSleepBass, danceBrakeSleepBassVar

#trumpet
set :introTrumpet, (ring :cs4, :ds4, :f4)
introSleepTrumpet3Var = randomPattern
set :introSleepTrumpet3, introSleepTrumpet3Var
verseSleepTrumpetVar = randomPattern
set :verseSleepTrumpet, verseSleepTrumpetVar
danceBrakeSleepTrumpetVar = danceBrakeSleepBassVar
set :danceBrakeSleepTrumpet, danceBrakeSleepTrumpetVar

#fake voice
#find the notes seemed to bass and trumpet
set :verseVoice, (ring :c4, :d4, :g3, :a3)
verseSleepVoiceVar = randomPattern
set :verseSleepVoice, verseSleepVoiceVar
danceBrakeSleepVoiceVar = danceBrakeSleepBassVar
set :danceBrakeSleepVoice, danceBrakeSleepVoiceVar

#Piano
set :pianoPiano, (ring :as4, :cs5, :f4, :cs5, :gs4)
pianoSleepPianoVar = randomPattern
set :pianoSleepPiano, pianoSleepPianoVar

#Blade
set :pianoBlade, (ring :as4, :cs5, :f4, :cs5, :gs4)
pianoSleepBladeVar = pianoSleepPianoVar
set :pianoSleepBlade, pianoSleepBladeVar

#Kick
introSleepKick2Var = kickBeats(introSleepBass2Var.length - 2, (introSleepBass2Var.sum).to_i)
set :introSleepKick2, introSleepKick2Var

introSleepKick3BVar = kickBeats(introSleepBass3Var.length - 2, (introSleepBass3Var.sum).to_i)
set :introSleepKick3B, introSleepKick3BVar

introSleepKick3TVar = kickBeats(introSleepTrumpet3Var.length - 2, (introSleepTrumpet3Var.sum).to_i)
set :introSleepKick3T, introSleepKick3TVar

introSleepKick4BVar = kickBeats(introSleepBass4Var.length - 2, (introSleepBass4Var.sum).to_i)
set :introSleepKick4B, introSleepKick4BVar

verseSleepKickTVar = kickBeats(verseSleepTrumpetVar.length - 2, (verseSleepTrumpetVar.sum).to_i)
set :verseSleepKickT, verseSleepKickTVar

verseSleepKickVVar = kickBeats(verseSleepVoiceVar.length - 2, (verseSleepVoiceVar.sum).to_i)
set :verseSleepKickV, verseSleepKickVVar

danceBrakeSleepKickBVar = kickBeats(danceBrakeSleepBassVar.length - 2, (danceBrakeSleepBassVar.sum).to_i)
set :danceBrakeSleepKickB, danceBrakeSleepKickBVar

pianoSleepKickPVar = kickBeats(pianoSleepPianoVar.length - 2, (pianoSleepPianoVar.sum).to_i)
set :pianoSleepKickP, pianoSleepKickPVar

#External Samples
#Check the adress
baseAddress = "D:/ARTISTA/Composición de canciones/COMPOSICIONES/Beats Relajantes 1/cyborg N1/cyborg-N1-1/samplesElectro/"
set :electroSamples, [baseAddress + "get.wav", baseAddress + "come.wav", baseAddress + "feel.wav", baseAddress + "hey.wav", baseAddress + "right.wav", baseAddress + "uh.wav"]

live_loop :metro do
  sleep 0.5
end

