-- Move  the focused window to the left or right screen
function moveWindowToScreen(direction)
  if hs.window.focusedWindow() then
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()

    local nextScreen = screen:next()
    local prevScreen = screen:previous()

    if direction == "left" then
      win:moveToScreen(prevScreen)
    else
      win:moveToScreen(nextScreen)
    end
  end
end
