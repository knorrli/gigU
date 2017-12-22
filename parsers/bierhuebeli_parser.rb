class BierhuebeliParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'Bierhübeli'
  end

  def event_nodes(content)
    content.css('.bh-event-list.all-events > li')
  end

  def parse_event_node(node)
    date = parse_date node
    event = @location.events.find_or_initialize_by date: date
    event.name = parse_name node
    event.description = parse_description node
    event.link = parse_link node
    event
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

  def parse_description(event_node)
    container = event_node.css '.bh-event-actor'
    container.text.squish
  end

  def parse_link(event_node)
    container = event_node.css '.eventlink a'
    container.first['href']
  end
end
