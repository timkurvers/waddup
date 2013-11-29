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
      end repeat
    end repeat

    results
  end tell
end run
