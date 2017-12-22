class BadBonnParser

  def initialize
    @location = Location.find_by! name: 'Bad Bonn'
  end

  def event_nodes(content)
    content.xpath('//*[@class="subnav"]//li[@itemtype="http://schema.org/MusicEvent"]')
  end

  def parse_event_node(node)
    date = parse_date node
    event = @location.events.find_or_initialize_by date: date
    event.name = parse_name node
  end

  def parse_date(event_node)
    Date.parse event_node.xpath('.//time').first['datetime']
  end

  def parse_name(event_node)
    event_node.xpath('.//*[attribute::itemprop="name"]').text
  end
end
