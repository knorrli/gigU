class MokkaParser < BaseParser

  def name
    'Mokka'
  end

  # event_nodes must extract each 'event' (a container for all event data) from
  # the given content, and then return these events as a list.
  # The given content is a Nokogiri::HTML::Document.
  # In most cases, the individual events can be found with an xpath/css
  # selector, which will automatically create a list of Nokogiri::XML::Element
  # objects when applied.
  #
  # example:
  #   content.css('.event_preview')
  def event_nodes(content)
    content.css('.events .event-month a')
  end

  def parse_event_node(event_node)
    date = parse_date event_node
    name = parse_name event_node
    event = @location.events.find_or_initialize_by date: date, name: name
    event.description = parse_description event_node
    event.url = parse_url event_node
    event
  end

  # parse_date must return the date of the event contained in the given
  # event_node.
  # In most cases, the date information can be extracted with an xpath/css
  # selector and then parsed as a Date object.
  #
  # example:
  #   Date.parse event_node.xpath('.//time').first['datetime']
  def parse_date(event_node)
    date_str = event_node.css('.date').text.squish
    Date.parse english_month(date_str)
  end

  def parse_name(event_node)
    event_node.css('.title-section h2').text.squish
  end

  def parse_description(event_node)
    event_node.css('.title_section .subtitle').text.squish
  end

  def parse_url(event_node)
    event_node['href'].squish
  end

  def english_month(string)
    month_ger = string.match(/.*\.(\D*)\./).captures.first.squish
    string.sub(month_ger, month_translation(month_ger))
  end

  def month_translation(month_ger)
    @month_translations ||= {
    "Jan" => "Jan",
    "Feb" => "Feb",
    "Mär" => "Mar",
    "Apr" => "Apr",
    "Mai" => "Mai",
    "Jun" => "Jun",
    "Jul" => "Jul",
    "Aug" => "Aug",
    "Sep" => "Sep",
    "Okt" => "Oct",
    "Nov" => "Nov",
    "Dez" => "Dec"
  }
    @month_translations[month_ger]
  end

end
