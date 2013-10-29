module Waddup

  class Source::AppleMail < Waddup::Source
    include Waddup::Extension::AppleScript
    extend Waddup::Extension::AppleScript

    ALIAS = 'mail'

    # Until OSX Mavericks handles Gmail's sent-mailbox correctly, resort to
    # iterating through all mailboxes and identify sent messages by sender
    #
    # See: http://tidbits.com/article/14219
    SENT_MAIL_SCRIPT = %Q{
      on run argv
        set window_from to date (item 1 of argv)
        set window_to   to date (item 2 of argv)

        tell application "Mail"
          set results to {}

          repeat with acct in every account
            set username to user name of acct
            set mboxes to (messages whose sender contains username and date sent >= window_from and date sent <= window_to) in every mailbox in acct
            repeat with mbox in mboxes
              repeat with msg in mbox
                set the end of results to {datetime:date sent of msg as string, subject:subject of msg}
              end
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
        args: [from.strftime('%d/%m/%Y %H:%M'), to.strftime('%d/%m/%Y %H:%M')]

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
