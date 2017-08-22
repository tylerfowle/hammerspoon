-- WORK LAYOUT
---------------------------------------------------------------------------
function applyWorkLayout()

  -- local laptopScreen = hs.screen.allScreens()[1]:name()
  -- local thunder1 =    hs.screen.allScreens()[2]:name()
  -- local thunder2 =    hs.screen.allScreens()[3]:name()

  local primaryScreen = hs.screen.primaryScreen() -- primary screen
  local mainScreen = hs.screen.mainScreen() -- currently focused window screen

  local rightScreen = hs.screen.primaryScreen()
  local middleScreen = hs.screen.primaryScreen():toWest()
  local leftScreen = hs.screen.primaryScreen():toWest():toWest()



  print(rightScreen)
  print(middleScreen)
  print(leftScreen)

  print(hs.window.frontmostWindow():application())


  local workLayout = {
    {"Google Chrome", nil, leftScreen,   hs.layout.right50,   nil, nil},
    {"Photoshop CC",  nil, leftScreen,   hs.layout.left50,    nil, nil},
    {"iTerm2",        nil, middleScreen, hs.layout.right70,   nil, nil},
    {"Mail",          nil, rightScreen,  hs.layout.left50,    nil, nil},
    {"Calendar",      nil, rightScreen,  hs.layout.right50,   nil, nil},
    {"Spotify",       nil, rightScreen,  hs.layout.maximized, nil, nil},
    {"Slack",         nil, rightScreen,  hs.layout.maximized, nil, nil},
  }

  hs.layout.apply(workLayout)

end


-- MOBILE LAYOUT
---------------------------------------------------------------------------
function applyMobileLayout()

  local primaryScreen = hs.screen.primaryScreen() -- primary screen
  local mainScreen = hs.screen.mainScreen() -- currently focused window screen

  local rightScreen = hs.screen.primaryScreen()
  local middleScreen = hs.screen.primaryScreen():toWest()
  local leftScreen = hs.screen.primaryScreen():toWest():toWest()


  local mobileLayout = {
    {"Google Chrome", nil, primaryScreen, hs.layout.maximized, nil, nil},
    {"Photoshop CC",  nil, primaryScreen, hs.layout.maximized, nil, nil},
    {"iTerm2",        nil, primaryScreen, hs.layout.maximized, nil, nil},
    {"Mail",          nil, primaryScreen, hs.layout.maximized, nil, nil},
    {"Calendar",      nil, primaryScreen, hs.layout.maximized, nil, nil},
    {"Spotify",       nil, primaryScreen, hs.layout.maximized, nil, nil},
    {"Slack",         nil, primaryScreen, hs.layout.maximized, nil, nil},
  }

  hs.layout.apply(mobileLayout)
end


-- APPLY LAYOUT FUNCTION
---------------------------------------------------------------------------
function applyWindowLayout()

  local numberOfScreens = #hs.screen.allScreens()

  if numberOfScreens>1 then
    applyWorkLayout()
  else
    applyMobileLayout()
  end

end



