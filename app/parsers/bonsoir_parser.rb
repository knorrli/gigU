class BonsoirParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'Bonsoir'
  end

  def event_nodes(content)
    content.css('#postlist_agenda > li')
  end

  def parse_event_node(node)
    date = parse_date node
    name = parse_name node
    event = @location.events.find_or_initialize_by date: date, name: name
    event.url = parse_link node
    event
  end

  def parse_date(event_node)
    date_container = event_node.css('.firstcol')
    day, month = date_container.text.match(/^.*(\d{2}).*(\d{2}).*$/).captures.map(&:to_i)
    Date.new year_for(month), month, day
  end

  def year_for(month)
    today = Date.today
    month < today.month ? (today.year + 1) : (today.year)
  end

  def parse_name(event_node)
    name_container = event_node.css '.heading'
    name_container.text.squish
  end

  def parse_link(event_node)
    link_node = event_node.css 'a'
    link_node.first['href']
  end
end
