require 'open-uri'

class BonsoirParser

  EVENT_URL = 'https://bonsoir.ch/agenda/'

  def self.parse
    new.parse
  end

  def initialize
    @location = Location.find_by! name: 'Bonsoir'
  end

  def parse
    content = Nokogiri::HTML(open(EVENT_URL))
    event_containers = content.css('#postlist_agenda > li')

    event_containers.each do |event_container|
      parse_and_create event_container
    end
  end

  def parse_and_create(event_container)
    date = parse_date event_container
    name = parse_name event_container
    @location.events.find_or_create_by date: date do |event|
      event.name = name
    end
  end

  def parse_date(event_container)
    container = event_container.css('.firstcol')
    day, month = container.text.match(/^.*(\d{2}).*(\d{2}).*$/).captures.map(&:to_i)
    Date.new Date.today.year, month, day
  end

  def parse_name(event_container)
    container = event_container.css '.heading'
    container.text.squish
  end
end
