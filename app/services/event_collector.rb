class EventCollector

  def self.run
    new.run
  end

  def run
    BaseParser.descendants.each { |parser| parser.send :parse }
  end
end
