require 'open-uri'

class BadBonnParser

  EVENT_URL = 'http://club.badbonn.ch/konzerte'

  def self.parse
    new.parse
  end

  def initialize
    @location = Location.find_by! name: 'Bad Bonn'
  end

  def parse
    content = Nokogiri::HTML(open(EVENT_URL))
    event_containers = content.xpath('//*[@class="subnav"]//li[@itemtype="http://schema.org/MusicEvent"]')

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
    Date.parse event_container.xpath('.//time').first['datetime']
  end

  def parse_name(event_container)
    event_container.xpath('.//*[attribute::itemprop="name"]').text
  end
end
