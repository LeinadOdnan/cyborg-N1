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
#First I will do a experiment to see min and max values to both functions, the I could transform to 0 to 255.

#VARS
#COLORS
colors = split_complementary_colors
set :primaryColor, colors[:primary]
set :secondaryColor1, colors[:secondary1]
set :secondaryColor2, colors[:secondary2]
puts colors[:primary]
puts colors[:secondary1]
puts colors[:secondary2]


