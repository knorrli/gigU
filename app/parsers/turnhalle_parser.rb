class TurnhalleParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'Turnhalle'
  end

  def event_nodes(content)
    content.css('.event')
  end

  def parse_event_node(node)
    date = parse_date node
    name = parse_name node
    event =  @location.events.find_or_initialize_by date: date, name: name
    event.description = parse_description node
    event.link = parse_link node
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

  def parse_link(event_node)
    link_container = event_node.css 'a'
    URI.join(@location.link, link_container.first['href'])
  end
end
