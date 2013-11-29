require 'chronic'

module Waddup

  class CLI

    attr_accessor :sources, :from, :to

    KEYWORDS = {
      sources: %w[with],
      from:    %w[from since],
      to:      %w[to until uptil upto through]
    }

    KEYWORD_BOUNDARY = "(?:\\s#{KEYWORDS.values.flatten.join('|\\s')}|\\Z)"

    def parse!
      parse_keyword :sources do |match|
        sources = match[1]
        @sources = Waddup::Source.usable.select do |source|
          sources.include? source::ALIAS
        end
      end

      parse_keyword :from do |match|
        @from = Chronic.parse match[1], context: :past
      end

      parse_keyword :to do |match|
        @to = Chronic.parse match[1], context: :past
      end
    end

    def parse_keyword(keyword, &block)
      @arguments.match /(?:#{KEYWORDS[keyword].join('|')})\s(.+?)#{KEYWORD_BOUNDARY}/i, &block
    end

    # Parses given arguments, aggregates events and renders timesheet
    def run!(arguments)
      @arguments = arguments.join ' '

      parse!

      # Sanity checking
      @sources ||= Waddup::Source.usable
      @from    ||= Time.now
      @to      ||= Time.now

      # Aggregate events from all sources
      events = sources.map do |source|
        source.new.events from, to
      end

      # Sort events
      events.flatten!
      events.sort_by! &:at

      # Group daily
      days = events.group_by { |event| event.at.to_date }

      # Generate timesheet
      days.each_pair do |day, events|
        puts
        puts day.strftime('%A, %-d %B %Y')
        puts
        events.each do |event|
          puts "  #{event.at.strftime('%H:%M')}  #{event.source.class::ICON}  #{event.label}"
        end
      end

      puts
    end

  end

end
