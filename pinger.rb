require 'clockwork'
require 'httparty'

include Clockwork

@sites = File.read("./sites.csv").split("\n")

every(15.minutes, 'ping single dyno apps to prevent idling') { 
  @sites.each {|url| 
    Thread.new{
      puts "URL: #{url}, STATUS: #{HTTParty.get(url).response.inspect}"
    }.run
  }
}
puts "PINGER STARTED"