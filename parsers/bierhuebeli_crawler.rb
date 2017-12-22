class BierhuebeliCrawler

  LOCATION_NAME = 'Bierhübeli'
  EVENT_URL = 'http://www.bierhuebeli.ch/veranstaltungen/'

  def initialize
    @location = Location.find_by! name: LOCATION_NAME
    @event_url = EVENT_URL
  end

  def event_nodes(content)
    content.css('.bh-event-list.all-events > li')
  end

  def parse_date(event_node)
    date_container = event_node.css('.evendates')
    day, month, year = date_container.text.match(/^.*(\d{2}).*(\d{2}).*(\d{2}).*$/).captures.map(&:to_i)
    Date.new year+2000, month, day
  end

  def parse_name(event_node)
    container = event_node.css '.eventlink'
    container.text.squish
  end
end
