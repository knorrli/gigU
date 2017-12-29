class ISCParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'ISC'
  end

  # must return a list of Nokogiri nodes where each node is a container
  # that contains all information about a single event
  def event_nodes(content)
    content.css('.event_preview')
  end

  def parse_event_node(node)
    date = parse_date node
    event = @location.events.find_or_initialize_by date: date
    event.name = parse_name node
    event.description = parse_description node
    event.link = parse_link node
    event
  end

  # event_node is a nokogiri node that contains all information about a single
  # event must return a Date object that matches the date of the given
  # event
  def parse_date(event_node)
    date_container = event_node.css('.event_title_date')
    day, month = date_container.text.match(/^.*(\d{2}).*(\d{2}).*$/).captures.map(&:to_i)
    Date.new Date.today.year, month, day
  end

  # event_node is a nokogiri node that contains all information about a single
  # event must return the name of the given event as a string
  def parse_name(event_node)
    name_container = event_node.css('.event_title_title')
    name_container.text.squish
  end

  def parse_description(event_node)
    description_container = event_node.css('.event_title_info')
    description_container.text.squish
  end

  def parse_link(event_node)
    event_node['href'].squish
  end
end
