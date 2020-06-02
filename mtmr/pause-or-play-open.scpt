if application "Spotify" is running then
  tell application "Spotify"
    if player state is playing then return "pause"
  end tell
end if

return "play"