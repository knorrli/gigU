require 'open-uri'
require 'html2text'

class BaseParser

  def self.parse
    new.parse
  end

  def initialize
    @location = Location.find_by name: name
  end

  def content
    Nokogiri::HTML(open(@location.events_url))
  end

  def parse
    event_nodes(content).each do |event_node|
      event = parse_event_node event_node
      event.save
    end
  end

  def html_to_string(html)
    Html2Text.convert(html).strip
  end

  def name
    raise "Must be implemented in non-abstract classes"
  end

  def event_nodes(content)
    raise "Must be implemented in non-abstract classes"
  end

  def parse_event_node(node)
    raise "Must be implemented in non-abstract classes"
  end
end


