require 'open-uri'
class Crawler

  def self.parse
    new.parse
  end

  def parse
    content = Nokogiri::HTML(open(@location.link))
    event_nodes(content).each do |event_node|
      event = parse_event_node event_node
      event.save
    end
  end
end


