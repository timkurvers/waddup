module Waddup

  class Source::AppleMail < Waddup::Source
    include Waddup::Extension::AppleScript
    extend Waddup::Extension::AppleScript

    ALIAS = 'mail'

    SENT_MAIL_SCRIPT = %Q{
      on run argv
        set window_from to date (item 1 of argv)
        set window_to   to date (item 2 of argv)

        tell application "Mail"
          set results to {}

          repeat with acct in every account
            set msgs to (messages whose (date sent is greater than or equal to window_from) and (date sent is less than or equal to window_to)) in mailbox "Sent" in acct
            repeat with msg in msgs
              set the end of results to {datetime:date sent of msg as string, subject:subject of msg}
            end repeat
          end repeat

          results
        end tell
      end run
    }

    # Aggregates sent mail events
    #
    # Arguments:
    #
    #   :from (datetime)
    #   :to   (datetime)
    #
    def events(from, to)
      results = applescript SENT_MAIL_SCRIPT,
        as_ruby: true,
        args: [from.strftime('%m-%d-%Y %H:%M'), to.strftime('%m-%d-%Y %H:%M')]

      results.map do |result|
        Waddup::Event.new do |e|
          e.at = DateTime.parse(result[:datetime])
          e.source = self
          e.subject = "Sent mail: #{result[:subject]}"
        end
      end
    end

    # Requires AppleScript to be available
    def self.usable?
      applescript?
    end

  end

end
