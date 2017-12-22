class BonsoirCrawler

  def initialize
    @location = Location.find_by! name: 'Bonsoir'
  end

  def event_nodes(content)
    content.css('#postlist_agenda > li')
  end

  def parse_event_node(node)
    date = parse_date node
    event = @location.find_or_initialize_by date: date
    event.name = parse_name node
    event
  end

  def parse_date(event_node)
    date_container = event_node.css('.firstcol')
    day, month = date_container.text.match(/^.*(\d{2}).*(\d{2}).*$/).captures.map(&:to_i)
    Date.new Date.today.year, month, day
  end

  def parse_name(event_node)
    name_container = event_node.css '.heading'
    name_container.text.squish
  end
end
