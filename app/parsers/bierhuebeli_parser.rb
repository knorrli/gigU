class BierhuebeliParser < BaseParser

  def initialize
    @location = Location.find_by! name: 'Bierhübeli'
  end

  def event_nodes(content)
    content.css('.bh-event-list.all-events > li')
  end

  def parse_event_node(node)
    url = parse_url node
    parse_event(url)
  end

  def parse_url(event_node)
    container = event_node.css '.eventlink a'
    container.first['href']
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
      ends_at: parse_ends_at(page),
      admission: parse_admission(page),
      extras: parse_extras(page)
    )
    event
  end

  def parse_date(page)
    container = page.css '.evendates'
    date = container.text[/^.*(\d{2}\.\d{2}\.\d{4}).*$/, 1]
    DateTime.parse(date)
  end

  def parse_title(page)
    container = page.css '.entry-title'
    container.text.squish
  end

  def parse_subtitle(page)
    container = page.css '.bh-event-actor'
    container.text.squish
  end

  def parse_description(page)
    container = page.css '.entry-content'
    html_to_string(container.to_s)
  end

  def parse_doors(page)
    container = page.css '.bh-tuer'
    time = container.text[/^.*(\d{2}[:|\.]\d{2}).*$/, 1].gsub(".", ":")
    DateTime.parse(time)
  end

  def parse_starts_at(page)
    container = page.css '.bh-beginn'
    time = container.text[/^.*(\d{2}[:|\.]\d{2}).*$/, 1].gsub(".", ":")
    DateTime.parse(time)
  end

  def parse_ends_at(page)
    nil
  end

  def parse_admission(page)
    container = page.css '.bh-abendkasse'
    price = container.text[/(CHF.*)/, 1].squish
  end

  def parse_extras(page)
    ['.bh-vorverkauf', '.bh-alter', '.bh_free_text_1', '.bh_free_text_2'].map do |selector|
      container = page.css selector
      container.text.squish
    end.reject(&:empty?).join("\n").strip
  end
end
