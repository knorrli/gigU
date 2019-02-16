class EventCollector

  def self.run
    new.run
  end

  def run
    BaseParser.descendants.each do |parser| 
      next if %w(ISCParser SchuurParser).include? parser.name
      parser.send :parse
    end
  end
end
