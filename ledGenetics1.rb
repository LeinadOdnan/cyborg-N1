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

#It scales a value from a given range to a 0-255 range, useful for LED brightness and speed control.
define :scale do |value,min,max|

  value = [[value,min].max,max].min

  (((value-min)/(max-min).to_f)*255).round

end

#Example
#bri = scale(density,0.75,1.5) , min, max by tests: 0.75,1.5
#speed = scale(activity,0.778,1.667) , min, max by tests: 0.778,1.667

#VARS
#COLORS
colors = split_complementary_colors
set :primaryColor, colors[:primary]
set :secondaryColor1, colors[:secondary1]
set :secondaryColor2, colors[:secondary2]
puts colors[:primary]
puts colors[:secondary1]
puts colors[:secondary2]


