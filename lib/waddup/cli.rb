require 'chronic'

require 'waddup'

module Waddup

  class CLI
    require 'commander/import'

    program :name, Waddup::NAME
    program :version, Waddup::VERSION
    program :description, Waddup::SUMMARY

    KEYWORDS = {
      sources: %w[with],
      from:    %w[from since],
      to:      %w[to until uptil upto through]
    }

    KEYWORD_BOUNDARY = "(?:\\s#{KEYWORDS.values.flatten.join('|\\s')}|\\Z)"

    class << self

      attr_accessor :sources, :from, :to

      def parse!(arguments)
        @arguments = arguments.join ' '

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

    end

    default_command :timesheet

    command :timesheet do |c|
      c.syntax = 'waddup with git and mail since last monday 9:00 until yesterday morning'
      c.description = 'Aggregates events and generates timesheet between from and to range'
      c.option '--format visual | json', String, 'Provides timesheet in specified format'
      c.action do |args, options|
        options.default format: 'visual'

        parse! args

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

        # Generate timesheet in requested format
        case options.format
        when 'json'
          require 'json'
          puts JSON.generate days
        when 'visual'
          days.each_pair do |day, events|
            puts
            puts day.strftime('%A, %-d %B %Y')
            puts

            events.each do |event|
              puts "  #{event.at.strftime('%H:%M')}  #{event.source.class::ICON}  #{event.label}"
            end
          end

          puts
        else
          raise 'Format needs to be either visual or json'
        end

      end
    end

  end

end
