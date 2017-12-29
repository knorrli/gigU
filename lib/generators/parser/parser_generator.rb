class ParserGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_parser_file
    create_file "app/parsers/#{file_name}_parser.rb", <<-FILE
class #{file_name.camelize}Parser < BaseParser

  def name
    '#{file_name}'
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
    raise "IMPLEMENT"
  end

  def parse_event_node(event_node)
    date = parse_date event_node
    name = parse_name event_node
    event = @location.events.find_or_initialize_by date: date, name: name
    # event.description =
    # event.url =
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
    raise "IMPLEMENT"
  end
end
    FILE
  end
end
