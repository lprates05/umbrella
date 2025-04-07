# Write your soltuion here!

require "dotenv/load"
require "http"
require "json"
require "dotenv/load"

#Gmaps Key

gmaps_key = ENV.fetch("GMAPS_KEY")

#Getting User Location

pp "Where are you?"
user_loc = gets.chomp.capitalize
#pp user_loc 

#Gmaps API
gmaps_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=#{gmaps_key}"
raw_body = HTTP.get(gmaps_api_url).to_s

require "json"
parsed_body = JSON.parse(raw_body)
#pp parsed_body.class
#pp parsed_body.keys

results = parsed_body.fetch("results")
#pp results.class
#pp results.keys

new_results = results.at(0)

geometry = new_results.fetch("geometry")
#pp geometry.class
#pp geometry.keys

location = geometry.fetch("location")
#pp location.class
#pp location.keys

lat = location.fetch("lat")
#pp lat

lng = location.fetch("lng")
#pp lng

# Hidden variables
pirate_weather_api_key = ENV.fetch("PW_KEY")

# Assemble URL string
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/#{lat},#{lng}"

# Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

require "json"
parsed_body_pw = JSON.parse(raw_response)
#pp parsed_body.class
#pp parsed_body.keys

current_time = Time.now

currently_pw = parsed_body_pw.fetch("currently")
current_temp = currently_pw.fetch("temperature")
#pp current_temp
#pp currently_pw.keys

precipitation_prob = currently_pw.fetch("precipProbability")
#pp precipitation_prob

#pp "The temperature is now #{current_temp}, and there is #{precipitation_prob}% probability of rain in your location in the next hour"

#Forecast for the next 12 hours

high_rain_prob = false
hourly_forecast = parsed_body_pw.fetch("hourly")
hourly_data = hourly_forecast.fetch("data")
hourly_hash = hourly_data.at(0)
hourly_prec_prob = hourly_hash.fetch("precipProbability")

12.times do
  if hourly_prec_prob > 10
    high_rain_prob = true
  else
    high_rain_prob = false
  end 
end


if high_rain_prob == false
  pp "You probably don't need an umbrella today!"
else 
  pp "You might want to carry an umbrella with you!"
end
