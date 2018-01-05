class Date
  def self.parse_international(string)
    parse(month_to_english(string))
  end

  private

  def self.make_hash(names)
    names.inject({}) {|result, name| result[name] = MONTHNAMES[result.count+1] ; result }      
  end

  MONTH_TRANSLATIONS = {}
  MONTH_TRANSLATIONS.merge! make_hash(%w/Januar    Februar    März    April    Mai    Juni    Juli    August    September    Oktober    November    Dezember/)  # German
  MONTH_TRANSLATIONS.merge! make_hash(%w/Jan    Feb    Mär    Apr    Mai    Jun    Jul    Aug    Sep    Okt    Nov    Dez/)  # German

  def self.month_to_english(string)
    month_from = string[/[^\s\d,]+/i]      # Search for a month name
    if month_from
      month_to = MONTH_TRANSLATIONS[month_from.downcase]      # Look up the translation
      return string.sub(month_from, month_to.to_s) if month_to
    end
    return string
  end
end

class DateTime
  def self.parse_international(string)
    parse(Date::month_to_english(string))
  end
end

class String
  def to_international_date
    Date::month_to_english(self).to_date
  end
end
