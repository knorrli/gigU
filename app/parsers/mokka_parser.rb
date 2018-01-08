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
    url = parse_url(event_node)
    parse_event url
  end

  def parse_url(event_node)
    event_node['href'].squish
  end

  def parse_event(url)
    page = Nokogiri::HTML(open(url))

    date = parse_date(page)
    title = parse_title(page)
    event = @location.events.find_or_initialize_by date: date, title: title

    event.assign_attributes(
      url: url,
      subtitle: parse_subtitle(page),
      description: parse_description(page),
      doors: parse_doors(page),
      starts_at: parse_starts_at(page),
      admission: parse_admission(page),
      image_url: parse_image_url(page),
    )
    event
  end

  def parse_date(page)
    date_str = page.css('.date').text[/.*(\d{2}\..*\d{4})/, 1]
    DateTime.parse with_english_month(date_str)
  end

  def parse_title(page)
    page.css('.title-section h1').text.squish
  end

  def parse_subtitle(page)
    page.css('.title_section .subtitle').text.squish
  end

  def parse_description(page)
    html_to_string(page.css('.the-content').to_s)
  end

  def parse_doors(page)
    container = page.xpath("//*[(normalize-space(text()) = 'Türöffnung')]/following-sibling::*")
    if container.text.squish.present?
      DateTime.strptime container.text[/(\d{2}.\d{2})/, 1], '%H.%M'
    else
      nil
    end
  end

  def parse_starts_at(page)
    container = page.xpath("//*[(normalize-space(text()) = 'Show')]/following-sibling::*")
    if container.text.squish.present?
      DateTime.strptime container.text[/(\d{2}.\d{2})/, 1], '%H.%M'
    else
      nil
    end
  end

  def parse_admission(page)
    container = page.xpath("//*[(normalize-space(text()) = 'Show')]/following-sibling::*")
    if container.text.squish.present?
      container.text.squish
    else
      nil
    end
  end

  def parse_image_url(page)
    container = page.css('.main-col img')
    container.first['src']
  end

  private

  def with_english_month(string)
    month_ger = string.split[1].upcase
    string.sub(month_ger, month_translation(month_ger))
  end

  def month_translation(month_ger)
    @month_translations ||= {
    "JANUAR" => "JANUAR",
    "FEBRUAR" => "FEBRUAR",
    "MÄRZ" => "MARCH",
    "APRIL" => "APRIL",
    "MAI" => "MAI",
    "JUNI" => "JUNE",
    "JULI" => "JULY",
    "AUGUST" => "AUGUST",
    "SEPTEMBER" => "SEPTEMBER",
    "OKTOBER" => "OCTOBER",
    "NOVEMBER" => "NOVEMBER",
    "DEZEMBER" => "DECEMBER"
  }
    @month_translations[month_ger]
  end

end
