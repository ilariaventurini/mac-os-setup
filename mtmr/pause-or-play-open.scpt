if application "Spotify" is running then
  tell application "Spotify"
    if player state is playing then return "pause"
  end tell
end if

if application "iTunes" is running then
  tell application "iTunes"
    if player state is playing then return "pause"
  end tell
end if

return "play"