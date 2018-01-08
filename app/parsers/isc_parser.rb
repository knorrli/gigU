require 'watir'

class ISCParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'ISC'
    @browser = Watir::Browser.new
  end

  # must return a list of Nokogiri nodes where each node is a container
  # that contains all information about a single event
  def event_nodes(content)
    content.css('.event_preview')
  end

  def parse_event_node(node)
    url = parse_url node
    parse_event(url)
  end

  def parse_url(event_node)
    event_node['href'].squish
  end

  def parse_event(url)
    @browser.goto url
    @browser.div(class: ['detail_page', 'active']).wait_until_present
    page = Nokogiri::HTML(@browser.html)

    page = page.css '.detail_page.active'

    date = parse_date(page)
    title = parse_title(page)
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

  # event_node is a nokogiri node that contains all information about a single
  # event must return a Date object that matches the date of the given
  # event
  def parse_date(page)
    container = page.css '.event_title_date'
    day_month = container.text[/^.*(\d{2}\.\d{2}).*$/, 1]
    DateTime.strptime(day_month, "%d.%m")
  end

  # event_node is a nokogiri node that contains all information about a single
  # event must return the name of the given event as a string
  def parse_title(page)
    container = page.css '.event_title_title'
    container.text.squish
  end

  def parse_subtitle(page)
    container = page.css '.event_title_info'
    container.text.squish
  end

  # for some reason the content gets loaded in a way i can not capture with
  # watir
  def parse_description(page)
    html = @browser.h3(class: 'leadtext').html
    page.css('.text_media_box .text_column').each do |box|
      html += box.to_s
    end
    html_to_string(html).strip
  end

  def parse_doors(page)
    container = page.xpath("//*[(normalize-space(text()) = 'Türöffnung')]/following-sibling::*")
    if container.text.squish.present?
      DateTime.strptime container.text[/(\d{2}:\d{2})/, 1], '%H:%M'
    else
      nil
    end
  end

  def parse_starts_at(page)
    container = page.xpath("//*[(normalize-space(text()) = 'Beginn')]/following-sibling::*")
    if container.text.squish.present?
      DateTime.strptime container.text[/(\d{2}:\d{2})/, 1], '%H:%M'
    else
      nil
    end
  end

  def parse_ends_at(page)
    container = page.xpath("//*[(normalize-space(text()) = 'Ende')]/following-sibling::*")
    if container.text.squish.present?
      DateTime.strptime container.text[/(\d{2}:\d{2})/, 1], '%H:%M'
    else
      nil
    end
  end

  def parse_admission(page)
    container = page.xpath("//*[(normalize-space(text()) = 'Eintritt')]/following-sibling::*")
    container.text.squish
  end

  def parse_image_url(page)
    if page.css('img.event_bg').present?
      container = page.css('img.event_bg')
      container.first['src']
    else
      container = page.css '.fullscreen_event_bg'
      URI.extract(container.first['style'].split[1])[0][0..-2]
    end
  end
end
