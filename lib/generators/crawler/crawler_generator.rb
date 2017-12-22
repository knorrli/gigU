class CrawlerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_helper_file
    create_file "app/services/#{file_name}_crawler.rb", <<-FILE
class #{file_name.camelize}Crawler < Crawler

  def initialize
    @location = Location.find_by! name: #{file_name.camelize}
    @event_url = '<URL>'
  end

  # must return a list of Nokogiri nodes where each node is a container
  # that contains all information about a single event
  def event_nodes(content)
    raise
  end

  # event_node is a nokogiri node that contains all information about a single
  # event must return a Date object that matches the date of the given
  # event
  def parse_date(event_node)
    raise
  end

  # event_node is a nokogiri node that contains all information about a single
  # event must return the name of the given event as a string
  def parse_name(event_node)
    raise
  end

end
    FILE
  end
end
