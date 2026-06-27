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
  
define :pattern_density do |pattern|
  pattern.length.to_f / pattern.sum
end

define :pattern_activity do |pattern|
  pattern.map { |x| 1.0 / x }.sum / pattern.length
end

define :analyze_density do |times=1000|

  values = []

  times.times do

    pattern = randomPattern
    value = pattern_density(pattern)

    values.push(value)

    puts({
      pattern: pattern,
      density: value.round(3)
    })

  end

  puts "MIN: #{values.min.round(3)}"
  puts "MAX: #{values.max.round(3)}"
  puts "AVG: #{(values.sum / values.length).round(3)}"

end

define :analyze_activity do |times=1000|

  values = []

  times.times do

    pattern = randomPattern
    value = pattern_activity(pattern)

    values.push(value)

    puts({
      pattern: pattern,
      activity: value.round(3)
    })

  end

  puts "MIN: #{values.min.round(3)}"
  puts "MAX: #{values.max.round(3)}"
  puts "AVG: #{(values.sum / values.length).round(3)}"

end

analyze_density
analyze_activity
