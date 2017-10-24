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
    -- {"Google Chrome", hs.appfinder.windowFromWindowTitlePattern('wunderlist'), leftScreen,   hs.layout.left25,   nil, nil},
    {"Photoshop CC",  nil, leftScreen,   hs.layout.left70,    nil, nil},
    {"iTerm2",        nil, middleScreen, hs.layout.right70,   nil, nil},
    {"Finder",        nil, middleScreen, hs.layout.left30,    nil, nil},
    {"Mail",          nil, rightScreen,  hs.layout.left50,    nil, nil},
    {"Calendar",      nil, rightScreen,  hs.layout.right50,   nil, nil},
    {"Spotify",       nil, rightScreen,  hs.layout.right50, nil, nil},
    {"Slack",         nil, rightScreen,  hs.layout.left50, nil, nil},
  }

  hs.layout.apply(workLayout)

end


-- MOBILE LAYOUT
---------------------------------------------------------------------------
function applyMobileLayout()

  local primaryScreen = hs.screen.primaryScreen() -- primary screen
  local mainScreen = hs.screen.mainScreen() -- currently focused window screen

  local allWindows = hs.window.allWindows()


  for k,v in pairs(allWindows) do
    print(k,v:application())

    local mobileLayout = {
      {v:application(), nil, primaryScreen, hs.layout.maximized, nil, nil},
    }

    hs.layout.apply(mobileLayout)
  end


end


-- APPLY LAYOUT FUNCTION
---------------------------------------------------------------------------
function applyWindowLayout()
  print(hs.application.allWindows)

  local numberOfScreens = #hs.screen.allScreens()

  if numberOfScreens>1 then
    applyWorkLayout()
  else
    applyMobileLayout()
  end

end



