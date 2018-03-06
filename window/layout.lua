-- WORK LAYOUT
---------------------------------------------------------------------------
function applyWorkLayout()

  -- local laptopScreen = hs.screen.allScreens()[1]:name()
  -- local thunder1 =    hs.screen.allScreens()[2]:name()
  -- local thunder2 =    hs.screen.allScreens()[3]:name()

  local primaryScreen = hs.screen.primaryScreen() -- primary screen
  local mainScreen = hs.screen.mainScreen() -- currently focused window screen

  local middleScreen = hs.screen.primaryScreen()
  local leftScreen = hs.screen.primaryScreen():toWest()
  local rightScreen = hs.screen.primaryScreen():toEast()



  print("----------------------")
  print(rightScreen)
  print(middleScreen)
  print(leftScreen)
  print("----------------------")

  print(hs.window.frontmostWindow():application())




  local workLayout = {
    {"Google Chrome", nil, leftScreen,   hs.layout.right50,   nil, nil},
    {"Photoshop CC",  nil, leftScreen,   hs.layout.maximized,    nil, nil},
    {"Adobe Illustrator CC 2018",  nil, middleScreen,   hs.layout.maximized,    nil, nil},
    {"iTerm2",        nil, rightScreen, hs.layout.right70,   nil, nil},
    {"Finder",        nil, middleScreen, hs.layout.left30,    nil, nil},
    {"Mail",          nil, middleScreen,  hs.layout.left50,    nil, nil},
    {"Calendar",      nil, middleScreen,  hs.layout.right50,   nil, nil},
    {"Spotify",       nil, middleScreen,  hs.layout.right50, nil, nil},
    {"Slack",         nil, middleScreen,  hs.layout.left50, nil, nil},
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



