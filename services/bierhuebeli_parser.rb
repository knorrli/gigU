require 'open-uri'

class BierhuebeliParser

  EVENT_URL = 'http://www.bierhuebeli.ch/veranstaltungen/'

  def self.parse
    new.parse
  end

  def initialize
    @location = Location.find_by! name: 'Bierhübeli'
  end

  def parse
    content = Nokogiri::HTML(open(EVENT_URL))
    event_containers = content.css('.bh-event-list.all-events > li')

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
    container = event_container.css('.evendates')
    day, month, year = container.text.match(/^.*(\d{2}).*(\d{2}).*(\d{2}).*$/).captures.map(&:to_i)
    Date.new year+2000, month, day
  end

  def parse_name(event_container)
    container = event_container.css '.eventlink'
    container.text.squish
  end
end
