class BadBonnParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'Bad Bonn'
  end

  def event_nodes(content)
    content.xpath('//*[@class="subnav"]//li[@itemtype="http://schema.org/MusicEvent"]')
  end

  def parse_event_node(node)
    url = parse_url(node)
    parse_event url
  end

  def parse_url(event_node)
    event_node.xpath('.//a[attribute::itemprop="url"]/@href').text.squish
  end

  def parse_event(url)
    page = Nokogiri::HTML(open(url))

    page = page.css('.detail')

    date = parse_date(page)
    title = parse_title(page)
    event = @location.events.find_or_initialize_by date: date, title: title

    event.assign_attributes(
      url: url,
      subtitle: parse_subtitle(page),
      description: parse_description(page),
      starts_at: parse_starts_at(page),
      admission: parse_admission(page),
      image_url: parse_image_url(page),
    )
    event
  end

  def parse_date(page)
    DateTime.parse page.xpath('.//time').first['datetime']
  end

  def parse_title(page)
    page.css('.konzert-titel').text.squish
  end

  def parse_subtitle(page)
    page.xpath('.//header/following-sibling::div')[0].xpath('p')[0].text
  end

  def parse_description(page)
    page.xpath('.//header/following-sibling::div')[0].xpath('p')[1..-1].text
  end

  def parse_starts_at(page)
    time = page.xpath('.//time').text[/.*(\d{2}h\d{2})/, 1]
    DateTime.strptime time.sub('h', ':'), '%H:%M'
  end

  def parse_admission(page)
    if admission = page.xpath('.//header/p')[0].text[/(CHF \w+)/, 1]
      admission.squish
    else
      page.xpath('.//header/p')[0].text[/(Eintritt .*)/, 1].squish
    end
  end

  def parse_image_url(page)
    if page.css('img').present?
      base = URI.join(@location.events_url, '/').to_s[0..-2]
      "#{base}#{page.css('img').first['src']}"
    else
      ""
    end
  end
end
