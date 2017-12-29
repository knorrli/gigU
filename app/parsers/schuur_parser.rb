class SchuurParser < BaseParser

  def name
    'Schüür'
  end

  def event_nodes(content)
    content.css('.event-box')
  end

  def parse_event_node(event_node)
    date = parse_date event_node
    name = parse_name event_node
    event = @location.events.find_or_initialize_by date: date, name: name
    event.description = event_node.css('.event-facts-summary').text.squish
    event.url = event_node.css('.event-sharing-link').first['data']
    event
  end

  def parse_date(event_node)
    date_time = event_node.css('.date').text.squish
    Date.parse date_time.match(/.*(\d{2}.\d{2}.\d{4}).*/).captures.first
  end

  def parse_name(event_node)
    event_node.css('.event').text.squish
  end
end
