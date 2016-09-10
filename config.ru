require 'sinatra'
require 'rlocu'

InvalidTokenError = Class.new(Exception)
Rlocu.configure { |conf| conf.api_key = ENV['LOCU_API_KEY'] }

post '/' do
  raise(InvalidTokenError) unless params[:token] == ENV['SLACK_TOKEN']

  lat = ENV['LATITUDE'].to_f
  long = ENV['LONGITUDE'].to_f
  radius = ENV['RADIUS'].to_f

  user = params.fetch('user_name')
  text = params.fetch('text').strip

  case text
  when 'ping'
    "Guten tag, freund!"
  else
    response = Rlocu::VenueSearch.new
      .in_lat_long_radius(lat: lat, long: long, radius: radius)
      .name(text)
      .with_menus
      .search

    menu = response.first.menus.first
    menu.to_s
  end
end

run Sinatra::Application
