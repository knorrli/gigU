class SchuurParser < BaseParser

  def initialize
    @location = Location.find_by name: 'Schüür'
    @browser = Watir::Browser.new
  end

  def event_nodes(content)
    content.css('.event-box')
  end

  def parse_event_node(node)
    url = parse_url node
    parse_event url
  end

  def parse_url(event_node)
    event_node.css('.event-sharing-link').first['data']
  end

  def parse_event(url)
    @browser.goto url
    event_node = @browser.div(class: 'event-sharing-link', data: url).parent
    event_node.div(class: 'detail-description', data_detailsloaded: 'true').wait_until_present
    page = Nokogiri::HTML(event_node.html)

    date = parse_date page
    title = parse_title page

    event = @location.events.find_or_initialize_by date: date, title: title

    event.assign_attributes(
      url: url,
      subtitle: parse_subtitle(page),
      description: parse_description(page),
      doors: parse_doors(page),
      starts_at: parse_starts_at(page),
      ends_at: parse_ends_at(page),
      admission: parse_admission(page),
      image_url: parse_image_url(page),
    )
    event
  end

  def parse_title(page)
    page.css('.event').text.squish
  end

  def parse_date(page)
    date_time = page.css('.date').text.squish
    Date.strptime date_time[/.*(\d{2}.\d{2}.\d{4}).*/, 1], '%d.%m.%Y'
  end

  def parse_subtitle(page)
    if subtitle = page.css('.eventorg-event-headline')
      subtitle.text.squish
    else
      nil
    end
  end

  def parse_description(page)
    html_to_string page.css('.eventorg-event-detail-text').to_s
  end

  def parse_doors(page)
    event_summary(page)[/Türöffnung: (\d{2}:\d{2})/, 1]
  end

  def parse_starts_at(page)
    event_summary(page)[/Beginn: (\d{2}:\d{2})/, 1]
  end

  def parse_ends_at(page)
    event_summary(page)[/Ende: (\d{2}:\d{2})/, 1]
  end

  def parse_admission(page)
    event_summary(page)[/Eintritt: (.*)/, 1].gsub(/Veranstalter:.*/, '').strip
  end

  def parse_image_url(page)
    URI.extract(page.css('.event-box').first['style'])[1]
  end

  private

  def event_summary(page)
    page.css('.event-facts-summary').text.squish
  end

end
