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
