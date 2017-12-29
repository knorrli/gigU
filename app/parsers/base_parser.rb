require 'open-uri'
class BaseParser

  def self.parse
    new.parse
  end

  def content
    Nokogiri::HTML(open(@location.link))
  end

  def parse
    event_nodes(content).each do |event_node|
      event = parse_event_node event_node
      event.save
    end
  end

  def event_nodes(content)
    raise "Must be implemented in non-abstract classes"
  end

  def parse_event_node(node)
    raise "Must be implemented in non-abstract classes"
  end
end


