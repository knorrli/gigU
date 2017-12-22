class TurnhalleParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'Turnhalle'
  end

  def event_nodes(content)
    content.css('.event')
  end

  def parse_event_node(node)
    date = parse_date(node)
    event =  @location.events.find_or_initialize(date: date)
    event.name = parse_name(node)
    event.description = parse_description(node)
    event
  end

  def parse_date(event_node)
    date_container = event_node.css('h4').children.first
    day, month, year = date_container.text.match(/^.*(\d{2}).*(\d{2}).*(\d{2}).*$/).captures.map(&:to_i)
    Date.new year+2000, month, day
  end

  def parse_name(event_node)
    name_container = event_node.css 'h2'
    name_container.text.squish
  end

  def parse_description(event_node)
    description_container = event_node.css 'h3'
    description_container.text.squish
  end
end
