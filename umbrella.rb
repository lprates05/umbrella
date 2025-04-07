# Write your soltuion here!

require "dotenv/load"
require "http"
require "json"
require "dotenv/load"

#Gmaps Key

gmaps_key = ENV.fetch("GMAPS_KEY")

#Getting User Location

pp "Where are you?"
#location = gets.chomp.capitalize
location = "Chicago Booth Harper Center"
pp location

#Gmaps API
gmaps_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=#{gmaps_key}"
raw_body = HTTP.get(gmaps_api_url).to_s

require "json"
pp parsed_body = JSON.parse(raw_body)
pp parsed_body.class
pp parsed_body.keys

results = parsed_body.fetch("results")
pp results.at(0)
