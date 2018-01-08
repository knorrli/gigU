class TurnhalleParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'Turnhalle'
  end

  def event_nodes(content)
    content.css('.event')
  end

  def parse_event_node(node)
    date = parse_date node
    title = parse_title node
    event =  @location.events.find_or_initialize_by date: date, title: title
    event.assign_attributes(
      url: parse_url(node),
      subtitle: parse_subtitle(node),
      description: parse_description(node),
      doors: parse_doors(node),
      starts_at: parse_starts_at(node),
      ends_at: parse_ends_at(node),
      admission: parse_admission(node),
      image_url: parse_image_url(node),
      extras: parse_extras(node)
    )
    event
  end

  def parse_date(node)
    container = node.css('h4').children.first
    day, month, year = container.text.match(/^.*(\d{2}).*(\d{2}).*(\d{2}).*$/).captures.map(&:to_i)
    Date.new year+2000, month, day
  end

  def parse_title(node)
    container = node.css 'h2'
    container.text.squish
  end

  def parse_url(node)
    container = node.css 'a'
    URI.join(@location.events_url, container.first['href'])
  end

  def parse_subtitle(node)
    description_container = node.css 'h3'
    description_container.first.text.squish
  end

  def parse_description(node)
    container = node.css('.boxcontent')
    html_to_string container.css('p').to_s
  end

  def parse_doors(node)
    container = node.css 'h4'
    if doors = container.text[/Tür (\d{2}:\d{2})h/, 1]
      DateTime.parse doors
    else
      nil
    end
  end

  def parse_starts_at(node)
    container = node.css 'h4'
    if from = container.text[/(\d{2}:\d{2}) bis \d{2}:\d{2}/, 1]
      DateTime.parse from
    else
      nil
    end
  end

  def parse_ends_at(node)
    container = node.css 'h4'
    if till = container.text[/\d{2}:\d{2} bis (\d{2}:\d{2})/, 1]
      DateTime.parse till
    else
      nil
    end
  end

  def parse_admission(node)
    container = node.css '.boxcontent h3'
    container.text.squish
  end

  def parse_image_url(node)
    URI.join(@location.events_url, node.css('img').first['src'])
  end

  def parse_extras(node)
  end
end
