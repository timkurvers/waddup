module Waddup

  class Source::AppleMail < Waddup::Source
    include Waddup::Extension::AppleScript
    extend Waddup::Extension::AppleScript
    extend Waddup::Extension::FileSystem

    ALIAS = 'mail'
    ICON  = "\xE2\x9C\x89\xEF\xB8\x8F "

    SENT_MAIL_SCRIPT = folder_of(__FILE__) + 'apple_mail/sent_mail.applescript'

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
        args:    [from.strftime('%d/%m/%Y %H:%M'), to.strftime('%d/%m/%Y %H:%M')]

      results.map do |result|
        Waddup::Event.new do |e|
          e.label  = result[:subject]
          e.at     = Time.parse(result[:datetime])
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
