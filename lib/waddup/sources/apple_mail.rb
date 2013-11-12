module Waddup

  class Source::AppleMail < Waddup::Source
    include Waddup::Extension::AppleScript
    extend Waddup::Extension::AppleScript

    ALIAS = 'mail'
    ICON  = "\xE2\x9C\x89\xEF\xB8\x8F "

    # Until OSX Mavericks handles Gmail's sent-mailbox correctly, resort to
    # iterating through all mail and identify sent messages by sender
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
            try
              set mbox to mailbox "[Gmail]/All Mail" of acct
            on error
              set mbox to mailbox "Sent" of acct
            end try

            set msgs to (messages whose sender contains username and date sent >= window_from and date sent <= window_to) in mbox
            repeat with msg in msgs
              set the end of results to {subject:subject of msg, datetime:date sent of msg as string}
            end
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
        :as_ruby => true,
        :args    => [from.strftime('%d/%m/%Y %H:%M'), to.strftime('%d/%m/%Y %H:%M')]

      results.map do |result|
        Waddup::Event.new do |e|
          e.label  = result[:subject]
          e.at     = DateTime.parse(result[:datetime])
          e.source = self
        end
      end
    end

    # Requires AppleScript to be available
    def self.usable?
      applescript?
    end

  end

end
