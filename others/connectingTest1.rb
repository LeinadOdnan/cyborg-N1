#1st test to connect to WLED device using Ruby. This code sends a POST request to the WLED device to turn it on and set the brightness and segment effects. 
require "net/http"
require "json"

ip = "192.168.100.37"
uri = URI("http://#{ip}/json/state")

data = {
  on: true,
  bri: 100,
  seg: [
    {
      fx: 40,
      sx: 150
    }
  ]
}

http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Post.new(uri.path)
request["Content-Type"] = "application/json"
request.body = data.to_json

response = http.request(request)

puts "WLED response:"
puts response.code
puts response.body

#This ran successfully and turned on the WLED device.

#2nd test to change speed of the segment effect. This code sends a POST request to the WLED device to change the speed of the segment effect.
require "net/http"
require "json"

ip = "192.168.100.37"
uri = URI("http://#{ip}/json/state")

# Scanner - speed 80
data = {
  on: true,
  bri: 100,
  seg: [
    {
      fx: 40,
      sx: 80
    }
  ]
}

http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Post.new(uri.path)
request["Content-Type"] = "application/json"
request.body = data.to_json

response = http.request(request)

puts "Scanner speed 80:"
puts response.code
puts response.body

sleep 3


# Scanner - speed 220
data = {
  on: true,
  bri: 100,
  seg: [
    {
      fx: 40,
      sx: 220
    }
  ]
}

request = Net::HTTP::Post.new(uri.path)
request["Content-Type"] = "application/json"
request.body = data.to_json

response = http.request(request)

puts "Scanner speed 220:"
puts response.code
puts response.body

sleep 3


# Scanner - speed 150
data = {
  on: true,
  bri: 100,
  seg: [
    {
      fx: 40,
      sx: 150
    }
  ]
}

request = Net::HTTP::Post.new(uri.path)
request["Content-Type"] = "application/json"
request.body = data.to_json

response = http.request(request)

puts "Scanner speed 150:"
puts response.code
puts response.body

#It worked! The speed of the segment effect changed successfully, but with delay problems. 

#3rd test delimiting the time of execution.
require "net/http"
require "json"

ip = "192.168.100.37"
uri = URI("http://#{ip}/json/state")

http = Net::HTTP.new(uri.host, uri.port)


# Scanner - speed 80
data = {
  on: true,
  bri: 100,
  seg: [
    {
      fx: 40,
      sx: 80
    }
  ]
}

request = Net::HTTP::Post.new(uri.path)
request["Content-Type"] = "application/json"
request.body = data.to_json

response = http.request(request)

puts "Scanner speed 80:"
puts response.code
puts response.body

sleep 3


# Scanner - speed 220
data = {
  on: true,
  bri: 100,
  seg: [
    {
      fx: 40,
      sx: 220
    }
  ]
}

request = Net::HTTP::Post.new(uri.path)
request["Content-Type"] = "application/json"
request.body = data.to_json

response = http.request(request)

puts "Scanner speed 220:"
puts response.code
puts response.body

sleep 3


# Turn WLED off
data = {
  on: false
}

request = Net::HTTP::Post.new(uri.path)
request["Content-Type"] = "application/json"
request.body = data.to_json

response = http.request(request)

puts "WLED OFF:"
puts response.code
puts response.body

#don't worked. It never runned the effect before it turn off.

