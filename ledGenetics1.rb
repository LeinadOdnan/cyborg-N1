#FUNCTIONS
#COLORS
define :hsv_to_rgb do |h, s=1.0, v=1.0|

  h = h % 360

  c = v * s
  x = c * (1 - ((h / 60.0) % 2 - 1).abs)
  m = v - c

  if h < 60
    r,g,b = c,x,0
  elsif h < 120
    r,g,b = x,c,0
  elsif h < 180
    r,g,b = 0,c,x
  elsif h < 240
    r,g,b = 0,x,c
  elsif h < 300
    r,g,b = x,0,c
  else
    r,g,b = c,0,x
  end

  [
    ((r+m)*255).round,
    ((g+m)*255).round,
    ((b+m)*255).round
  ]
end

define :split_complementary_colors do

  main_hue = rrand_i(0,359)

  secondary1_hue = (main_hue + 150) % 360
  secondary2_hue = (main_hue + 210) % 360

  {
    primary: hsv_to_rgb(main_hue),
    secondary1: hsv_to_rgb(secondary1_hue),
    secondary2: hsv_to_rgb(secondary2_hue)
  }

end

#pattern_density and pattern_activity to bri and speed.
define :pattern_density do |pattern|
  pattern.length.to_f / pattern.sum
end

define :pattern_activity do |pattern|
  pattern.map { |x| 1.0 / x }.sum / pattern.length
end

#It scales a value from a given range to other range, useful for LED brightness , speed control and maybe others.
define :scale do |value, in_min, in_max, out_min, out_max|

  value = [[value, in_min].max, in_max].min

  (((value - in_min) / (in_max - in_min).to_f) * (out_max - out_min) + out_min).round

end

#range 
# Brightness, min, max by tests: 0.75,1.5
#Speed, min, max by tests: 0.778,1.667

# Effect configuration, it gives the effect id and the parameters.
define :effect_config do |instrumentName, patternName|

  effect = Instruments_fx[instrumentName]
  effect_id = Name_to_id_fx[effect]
  pattern = get(patternName)

  # If sentences for each effect, to set the parameters.
  if effect == :Scanner
    speed = scale(pattern_activity(pattern), 0.778, 1.667, 80, 220)
    fadeRate = 120

  elsif effect == :Plasma
    phase = 128
    intensity = scale(pattern_density(pattern), 0.75, 1.50, 70, 220)

  elsif effect == :FireworksStarburst
    chance = scale(pattern_activity(pattern), 0.778, 1.667, 30, 180)
    fragments = 120
    overlay = 0

  elsif effect == :Noise4
    speed = scale(pattern_activity(pattern), 0.778, 1.667, 60, 200)

  elsif effect == :Blink
    speed = scale(pattern_activity(pattern), 0.778, 1.667, 70, 220)
    dutyCycle = 128

  elsif effect == :Bpm
    speed = scale(pattern_activity(pattern), 0.778, 1.667, 100, 220)
    colorSpread = 140

  elsif effect == :Twinklecat
    speed = scale(pattern_activity(pattern), 0.778, 1.667, 80, 180)

    twinkleDensity =
      scale(pattern_density(pattern), 0.75, 1.50, 40, 220)

  elsif effect == :Fire2012
    cooling = 90
    sparkRate = scale(pattern_activity(pattern), 0.778, 1.667, 40, 220)
    boost = 140
  end

  # To later, good option to API or JSON.
  # {
  #   id: effect_id,
  #   bri: bri,
  #   speed: speed
  # }

end




#VARS
#COLORS
colors = split_complementary_colors
set :primaryColor, colors[:primary]
set :secondaryColor1, colors[:secondary1]
set :secondaryColor2, colors[:secondary2]
#puts colors[:primary]
#puts colors[:secondary1]
#puts colors[:secondary2]


#HASHES
#EFFECTS
#Live Loops and Samples
Instruments_fx = {
  bass: :Scanner,
  trumpet: :Plasma,
  voice: :Noise4,
  piano: :FireworksStarburst,
  blade: :Blink,
  kick: :Bpm,
  int_live: :Twinklecat,
  ext: :Fire2012
}

#Convertion of name effects to id effects, from v16.0
Name_to_id_fx = {
  Scanner: 40,
  Plasma: 97,
  FireworksStarburst: 89,
  Noise4: 73,
  Blink: 1,
  Bpm: 68,
  Twinklecat: 81,
  Fire2012: 66
}



