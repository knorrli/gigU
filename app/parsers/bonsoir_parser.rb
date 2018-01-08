require 'watir'

class BonsoirParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'Bonsoir'
    @browser = Watir::Browser.new
  end

  def event_nodes(content)
    content.css('#postlist_agenda > li')
  end

  def parse_event_node(node)
    url = parse_url node
    parse_event(url)
  end

  def parse_url(event_node)
    container = event_node.css 'a'
    container.first['href']
  end

  def parse_event(url)
    @browser.goto url

    @browser.span(class: 'date').wait_until_present
    @browser.img(class: 'agenda-thumbnail').wait_until_present

    page = Nokogiri::HTML(@browser.html)

    date = parse_date(page)
    title = parse_title(page)
    event = @location.events.find_or_initialize_by date: date, title: title

    event.assign_attributes(
      url: url,
      subtitle: parse_subtitle(page),
      description: parse_description(page),
      starts_at: parse_starts_at(page),
      image_url: parse_image_url(page),
      extras: parse_extras(page)
    )

    pp event

    event
  end

  def parse_date(page)
    container = page.css '.date'
    day_month = container.text[/^.*(\d{2}\.\d{2}).*$/, 1]
    DateTime.strptime(day_month, "%d.%m")
  end

  def parse_title(page)
    container = page.css '.title'
    container.text.squish
  end

  def parse_subtitle(page)
    container = page.css '.agenda-page-stil'
    container.text.squish
  end

  def parse_description(page)
    container = page.css '.maincontent'
    html_to_string(container.to_s).strip
  end

  def parse_starts_at(page)
    container = page.css '.time'
    DateTime.strptime(container.text.squish, '%H:%M')
  end

  def parse_image_url(page)
    container = page.css('.agenda-thumbnail')
    container.first['srcset'].split.first
  end

  def parse_extras(page)
    ['.agenda-page-label', '.agenda-page-presentedBy'].map do |selector|
      container = page.css selector
      container.text.squish
    end.reject(&:empty?).join("\n").strip
  end

end
