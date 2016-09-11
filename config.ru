require 'active_support'
require 'active_support/core_ext'
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

    venue = response.first
    return "Sorry, I couldn't find '#{text}'" if (venue.nil?)

    result = "Menus for #{venue.name}"
    venue.menus.each do |menu|
      result = "#{menu.menu_name} menu\n"
      menu.sections.each do |section|
        result << "\t-----#{section.section_name}-----\n" if section.section_name.present?
        section.subsections.each do |subsection|
          result << "\t\t---#{subsection.subsection_name}---\n" if subsection.subsection_name.present?
          subsection.contents.each do |content|
            case content
            when Rlocu::Menu::SectionText
              result << "\t\t#{content.to_s}\n"
            when Rlocu::Menu::MenuItem
              result << "\t\t\t#{content.name} #{content.description} #{content.price}\n"
            end
          end
        end
      end
    end
    result
  end
end

run Sinatra::Application
