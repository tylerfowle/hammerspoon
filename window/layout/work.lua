-- WORK LAYOUT
---------------------------------------------------------------------------
function applyWorkLayout()

  local laptopScreen = hs.screen.allScreens()[1]:name()
  local thunder1 =    hs.screen.allScreens()[2]:name()
  local thunder2 =    hs.screen.allScreens()[3]:name()

  local workLayout = {
    {"Chrome",  nil, thunder2, hs.layout.right50,    nil, nil},
    {"Mail", nil, thunder1, hs.layout.right50, nil, nil},

    {"iTerm2", nil, thunder1, hs.layout.top50, nil, nil},
    {"Spotify", nil, thunder1, hs.layout.right50, nil, nil},
  }

  hs.layout.apply(workLayout)

end


