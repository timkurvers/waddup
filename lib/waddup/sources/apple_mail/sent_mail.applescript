on run argv
  set window_from to date (item 1 of argv)
  set window_to   to date (item 2 of argv)

  tell application "Mail"
    set results to {}

    set msgs to (messages of sent mailbox whose date sent >= window_from and date sent <= window_to)
    repeat with msg in msgs
      set the end of results to {subject:subject of msg, datetime:date sent of msg as string}
    end repeat

    results
  end tell
end run
