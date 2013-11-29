module Waddup

  class Source::AppleCalendar < Waddup::Source
    include Waddup::Extension::AppleScript
    extend Waddup::Extension::AppleScript
    extend Waddup::Extension::FileSystem

    ALIAS = 'ical'
    ICON  = "\xF0\x9F\x93\x85 "

    EVENT_SCRIPT = folder_of(__FILE__) + 'apple_calender/events.applescript'

    # Aggregates calendar events
    #
    # Arguments:
    #
    #   :from (datetime)
    #   :to   (datetime)
    #
    def events(from, to)
      results = applescript EVENT_SCRIPT,
        as_ruby: true,
        args:    [from.strftime('%d/%m/%Y %H:%M'), to.strftime('%d/%m/%Y %H:%M')]

      results.map do |result|
        Waddup::Event.new do |e|
          e.label   = result[:summary]
          e.at      = Time.parse(result[:start_date])
          e.until   = Time.parse(result[:end_date])
          e.source  = self
        end
      end
    end

    # Requires AppleScript to be available
    def self.usable?
      applescript?
    end

  end

end
