-- local u = require("utils")
-- 
-- local cmd2 = { "command", "ctrl" }
-- 
-- -- for more apps, run
-- -- $ ls /Applications
-- hs.hotkey.bind({}, "f12", u.toggleApp("Kitty"))
-- hs.hotkey.bind(cmd2, "9", u.focusApp("Spotify"))
-- hs.hotkey.bind(cmd2, "h", u.hideAllApps)

local spaces = require("hs.spaces") -- https://github.com/asmagill/hs._asm.spaces

-- Switch kitty
-- hs.hotkey.bind({'command'}, 'escape', function ()  -- hotkey config
hs.hotkey.bind({}, 'f12', function () --hotkey config
  local BUNDLE_ID = 'net.kovidgoyal.kitty' -- more accurate to avoid mismatching on browser titles

  function getMainWindow(app)
    -- get main window from app
  	local mw = app:mainWindow()

  	if mw == nil then
    	hs.application.open(app:name())
    	return app:mainWindow()
  	end

  	return mw
	end

  function moveWindow(kitty, space, mainScreen)
    -- move to main space
    local win = getMainWindow(kitty)
    if win:isFullScreen() then
      hs.eventtap.keyStroke('fn', 'f', 0, kitty)
    end
    winFrame = win:frame()
    scrFrame = mainScreen:fullFrame()
    winFrame.w = scrFrame.w
    winFrame.y = scrFrame.y
    winFrame.x = scrFrame.x
    win:setFrame(winFrame, 0)
    spaces.moveWindowToSpace(win, space)
    if win:isFullScreen() then
      hs.eventtap.keyStroke('fn', 'f', 0, kitty)
    end
    win:focus()
  end

  local kitty = hs.application.get(BUNDLE_ID)
  if kitty ~= nil and kitty:isFrontmost() then
    kitty:hide()
  else
    local space = spaces.activeSpaceOnScreen("Primary")
    local mainScreen = hs.screen.primaryScreen()
    if kitty == nil and hs.application.launchOrFocusByBundleID(BUNDLE_ID) then
      local appWatcher = nil
      appWatcher = hs.application.watcher.new(function(name, event, app)
        if event == hs.application.watcher.launched and app:bundleID() == BUNDLE_ID then
          getMainWindow(app):move(hs.geometry({x=0,y=0,w=1,h=0.4}))
          app:hide()
          moveWindow(app, space, mainScreen)
          appWatcher:stop()
        end
      end)
      appWatcher:start()
    end
    if kitty ~= nil then
      moveWindow(kitty, space, mainScreen)
    end
  end
end)
