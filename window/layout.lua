-- WORK LAYOUT
---------------------------------------------------------------------------
function applyWorkLayout()

  -- local laptopScreen = hs.screen.allScreens()[1]:name()
  -- local thunder1 =    hs.screen.allScreens()[2]:name()
  -- local thunder2 =    hs.screen.allScreens()[3]:name()

  local rightScreen = hs.screen.primaryScreen()
  local middleScreen = hs.screen.primaryScreen():toWest()
  local leftScreen = hs.screen.primaryScreen():toWest():toWest()




  print(laptopScreen)
  print(thunder1)
  print(thunder2)

  print(rightScreen)
  print(middleScreen)
  print(leftScreen)

  print(hs.window.frontmostWindow():application())


  local workLayout = {
    {"Google Chrome",  nil, leftScreen, hs.layout.right50,    nil, nil},
    {"Photoshop CC", nil, leftScreen, hs.layout.left50, nil, nil},

    {"iTerm2", nil, middleScreen, hs.layout.right70, nil, nil},

    {"Mail", nil, rightScreen, hs.layout.left50, nil, nil},
    {"Calendar", nil, rightScreen, hs.layout.right50, nil, nil},

    {"Spotify", nil, rightScreen, hs.layout.maximized, nil, nil},
    {"Slack", nil, rightScreen, hs.layout.maximized, nil, nil},
  }

  hs.layout.apply(workLayout)

end


-- MOBILE LAYOUT
---------------------------------------------------------------------------
function applyMobileLayout()

  local laptopScreen = hs.screen.allScreens()[1]:name()

  local mobileLayout = {
    {"Google Chrome",  nil, laptopScreen, hs.layout.left50,    nil, nil},
    {"Mail", nil, laptopScreen, hs.layout.left50, nil, nil},

    {"iTerm2", nil, laptopScreen, hs.layout.left50, nil, nil},
    {"Spotify", nil, laptopScreen, hs.layout.left50, nil, nil},
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



