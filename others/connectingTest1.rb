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
