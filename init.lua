-- CONFIG

hs.application.enableSpotlightForNameSearches(true)

hs.window.animationDuration = 0
hs.window.setShadows = "false"

-- hs.hints.fontName           = "Hack"
-- hs.hints.fontSize           = 1.0 
-- hs.hints.iconAlpha = 0.5
-- hs.hints.showTitleThresh    = 0
-- hs.hints.hintChars          = { 'A', 'S', 'D', 'F', 'G', 'Q', 'W', 'E', 'R', 'T', 'Z', 'X', 'C', 'V', 'B' }

hs.console.clearConsole()


-- REQUIRES
---------------------------------------------------------------------------
-- spaces = require("hs._asm.undocumented.spaces")

require("bindings.init")
require("reload")

require("helpers.monitor-test")

-- audio
require("audio.mute_jack")

-- window
require("window.layout")
require("window.mission-control")
require("window.management")

-- -- spaces
require("window.spaces.focus-space")
require("window.spaces.move-window")
require("window.screens.move-window")
require("window.screens.move-cursor")

-- apps
require("apps.crosshair")
require("apps.chrome-tab-chooser")

-- watchers
require("watchers")



hs.loadSpoon("SpoonInstall")
Install=spoon.SpoonInstall
Install.use_syncinstall = true

Install:andUse("ClipboardTool",
{
    hotkeys = { toggle_clipboard = { hypershift, "p" } },
    start = true,
})

Install:andUse("Seal",
{
  hotkeys = { show = { hypershift, "m" } },
  fn = function(s)
    s:loadPlugins({"apps", "calc", "safari_bookmarks", "screencapture", "useractions"})
    s.plugins.safari_bookmarks.always_open_with_safari = false
    s.plugins.useractions.actions =
    {
      ["Hammerspoon docs webpage"] = {
        url = "http://hammerspoon.org/docs/",
        icon = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
      },

       -- github pull requests
      ["github"] = {
        url = "https://github.com/CompanyCam/CraftMarketing",
        icon = 'favicon',
      },

      -- github pull requests
      ["pulls"] = {
        url = "https://github.com/CompanyCam/CraftMarketing/pulls",
        icon = 'favicon',
      },

      -- dev site
      ["dev"] = {
        url = "https://cc.nitro",
        icon = 'favicon',
      },

      -- staging site
      ["stage"] = {
        url = "https://stage.companycam.com",
        icon = 'favicon',
      },

      -- live site
      ["live"] = {
        url = "https://companycam.com",
        icon = 'favicon',
      },

    }
    s:refreshAllCommands()
  end,
  start = true,
}
)

local LOGLEVEL = 'debug'

-- List of modules to load (found in apps/ dir)
local modules = {
}

-- global modules namespace (short for easy console use)
hsm = {}

-- load module configuration
local cfg = require('config')
hsm.cfg = cfg.global

-- global log
hsm.log = hs.logger.new(hs.host.localizedName(), LOGLEVEL)

-- load a module from modules/ dir, and set up a logger for it
local function loadModuleByName(modName)
  hsm[modName] = require('apps.' .. modName)
  hsm[modName].name = modName
  hsm[modName].log = hs.logger.new(modName, LOGLEVEL)
  hsm.log.i(hsm[modName].name .. ': module loaded')
end

-- save the configuration of a module in the module object
local function configModule(mod)
  mod.cfg = mod.cfg or {}
  if (cfg[mod.name]) then
    for k,v in pairs(cfg[mod.name]) do mod.cfg[k] = v end
    hsm.log.i(mod.name .. ': module configured')
  end
end

-- start a module
local function startModule(mod)
  if mod.start == nil then return end
  mod.start()
  hsm.log.i(mod.name .. ': module started')
end

-- stop a module
local function stopModule(mod)
  if mod.stop == nil then return end
  mod.stop()
  hsm.log.i(mod.name .. ': module stopped')
end

-- load, configure, and start each module
hs.fnutils.each(modules, loadModuleByName)
hs.fnutils.each(hsm, configModule)
hs.fnutils.each(hsm, startModule)

-- global function to stop modules and reload hammerspoon config
function hs_reload()
  hs.fnutils.each(hsm, stopModule)
  hs.reload()
end

-- default alert styles
hs.alert.defaultStyle.strokeColor =  {white = 1, alpha = 0}
hs.alert.defaultStyle.fillColor =  {white = 0.05, alpha = 0.75}
hs.alert.defaultStyle.radius =  0
hs.alert.defaultStyle.textSize =  10

-- spotify info
hs.hotkey.bind(hypershift, "\\", function()
  hs.spotify.displayCurrentTrack()
end)
