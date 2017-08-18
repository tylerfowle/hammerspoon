-- TEST FOR EXTERNAL MONITOR
---------------------------------------------------------------------------
function hasExternalMonitor()
  for _, screen in pairs(hs.screen.allScreens()) do
    if screen:name() == "Thunderbolt Display" then
      return true
    end
  end
  return false
end


