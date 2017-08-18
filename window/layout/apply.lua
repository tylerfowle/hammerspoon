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



