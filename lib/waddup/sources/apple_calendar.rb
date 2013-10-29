module Waddup

  class Source::AppleCalendar < Waddup::Source
    include Waddup::Extension::AppleScript
    extend Waddup::Extension::AppleScript

    ALIAS = 'ical'

    EVENT_SCRIPT = %Q{
      on run argv
        set window_from to date (item 1 of argv)
        set window_to   to date (item 2 of argv)

        tell application "Calendar"
          set results to {}

          set cdars to (events whose start date <= window_to and end date > window_from) in every calendar
          repeat with cdar in cdars
            repeat with evt in cdar
              set end of results to {summary:summary of evt, start_date:start date of evt as string, end_date:end date of evt as string}
            end repeat
          end repeat

          results
        end tell
      end run
    }

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
        args: [from.strftime('%d/%m/%Y %H:%M'), to.strftime('%d/%m/%Y %H:%M')]

      results.map do |result|
        Waddup::Event.new do |e|
          e.subject = result[:summary]
          e.at      = DateTime.parse(result[:start_date])
          e.until   = DateTime.parse(result[:end_date])
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
