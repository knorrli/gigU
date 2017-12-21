require 'open-uri'

class TurnhalleParser

  EVENT_URL = 'https://www.turnhalle.ch/'

  def self.parse
    new.parse
  end

  def initialize
    @location = Location.find_by! name: 'Turnhalle'
  end

  def parse
    content = Nokogiri::HTML(open(EVENT_URL))
    event_containers = content.css('.event')

    event_containers.each do |event|
      parse_and_create event
    end
  end

  def parse_and_create(event)
    date = parse_date event
    name = parse_name event
    @location.events.find_or_create_by date: date do |event|
      event.name = name
    end
  end

  def parse_date(event_container)
    container = event_container.css('h4').children.first
    day, month, year = container.text.match(/^.*(\d{2}).*(\d{2}).*(\d{2}).*$/).captures.map(&:to_i)
    Date.new year+2000, month, day
  end

  def parse_name(event_container)
    container = event_container.css 'h2'
    container.text.squish
  end
end
