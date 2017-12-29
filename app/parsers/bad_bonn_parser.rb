class BadBonnParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'Bad Bonn'
  end

  def event_nodes(content)
    content.xpath('//*[@class="subnav"]//li[@itemtype="http://schema.org/MusicEvent"]')
  end

  def parse_event_node(node)
    date = parse_date node
    name = parse_name node
    event = @location.events.find_or_initialize_by date: date, name: name
    event.link = parse_link node
    event
  end

  def parse_date(event_node)
    Date.parse event_node.xpath('.//time').first['datetime']
  end

  def parse_name(event_node)
    event_node.xpath('.//*[attribute::itemprop="name"]').text
  end

  def parse_link(event_node)
    event_node.xpath('.//a[attribute::itemprop="url"]/@href').text.squish
  end
end
