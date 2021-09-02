-- WATCHERS
---------------------------------------------------------------------------

-- watch for monitor changes and update layout
-- change window layout on monitor configuration change
-- local monitorWatcher = hs.screen.watcher.new(applyWindowLayout)
-- monitorWatcher:start()



function sleepCallback( eventType )

	local appDLM = hs.application.find("xScope")
	if(appDLM ~= nil) then
		appDLM:kill()
	end

	local appDLM = hs.application.find("DisplayLinkUserAgent")
	if(appDLM ~= nil) then
		appDLM:kill()
	end
end
sleepWatcher = hs.caffeinate.watcher.new(sleepCallback):start()


function wakeCallback( eventType )
	hs.application.launchOrFocus("DisplayLink Manager")
end
wakeWatcher = hs.caffeinate.watcher.new(wakeCallback):start()