require 'clockwork'
require 'httparty'

include Clockwork

@sites = File.read("./sites.csv").split("\n")

every(15.minutes, 'ping single dyno apps to prevent idling') { 
  @sites.split(",").each {|url| 
    Thread.new{
      puts "URL: #{url}, STATUS: #{HTTParty.get(url).headers["status"]}"
    }.run
  }
}
puts "PINGER STARTED"