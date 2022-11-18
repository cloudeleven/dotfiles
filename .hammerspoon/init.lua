-- ShiftIt もどき
hs.window.animationDuration = 0
units = {
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bottom50      = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  left75        = { x = 0.00, y = 0.00, w = 0.75, h = 1.00 },
  right75       = { x = 0.25, y = 0.00, w = 0.75, h = 1.00 },
  top75         = { x = 0.00, y = 0.00, w = 1.00, h = 0.75 },
  bottom75      = { x = 0.00, y = 0.25, w = 1.00, h = 0.75 },
  left15        = { x = 0.00, y = 0.00, w = 0.25, h = 1.00 },
  right15       = { x = 0.75, y = 0.00, w = 0.25, h = 1.00 },
  top15         = { x = 0.00, y = 0.00, w = 1.00, h = 0.25 },
  bottom15      = { x = 0.00, y = 0.75, w = 1.00, h = 0.25 }
}
modsFor50 = { 'ctrl', 'command' }
modsFor75 = { 'ctrl', 'shift' }
modsFor15 = { 'ctrl', 'shift', 'command' }
hs.hotkey.bind(modsFor50, 'left', function() hs.window.focusedWindow():move(units.left50, nil, true) end)
hs.hotkey.bind(modsFor50, 'right', function() hs.window.focusedWindow():move(units.right50, nil, true) end)
hs.hotkey.bind(modsFor50, 'up', function() hs.window.focusedWindow():move(units.top50, nil, true) end)
hs.hotkey.bind(modsFor50, 'down', function() hs.window.focusedWindow():move(units.bottom50, nil, true) end)
hs.hotkey.bind(modsFor75, 'left', function() hs.window.focusedWindow():move(units.left75, nil, true) end)
hs.hotkey.bind(modsFor75, 'right', function() hs.window.focusedWindow():move(units.right75, nil, true) end)
hs.hotkey.bind(modsFor75, 'up', function() hs.window.focusedWindow():move(units.top75, nil, true) end)
hs.hotkey.bind(modsFor75, 'down', function() hs.window.focusedWindow():move(units.bottom75, nil, true) end)
hs.hotkey.bind(modsFor15, 'left', function() hs.window.focusedWindow():move(units.left15, nil, true) end)
hs.hotkey.bind(modsFor15, 'right', function() hs.window.focusedWindow():move(units.right15, nil, true) end)
hs.hotkey.bind(modsFor15, 'up', function() hs.window.focusedWindow():move(units.top15, nil, true) end)
hs.hotkey.bind(modsFor15, 'down', function() hs.window.focusedWindow():move(units.bottom15, nil, true) end)


-- 壊れた → を F12 で代用
hs.hotkey.bind(nil, 111, function()
  hs.eventtap.keyStroke({}, 'right', 0)
end)
hs.hotkey.bind({'shift'}, 111, function()
  hs.eventtap.keyStroke({'shift'}, 'right', 0)
end)
hs.hotkey.bind({'option'}, 111, function()
  hs.eventtap.keyStroke({'option'}, 'right', 0)
end)
hs.hotkey.bind({'option', 'ctrl'}, 111, function()
  hs.eventtap.keyStroke({'option', 'ctrl'}, 'right', 0)
end)
hs.hotkey.bind({'shift', 'ctrl', 'option'}, 111, function()
  hs.eventtap.keyStroke({'shift', 'ctrl', 'option'},  'right', 0)
end)
hs.hotkey.bind({'ctrl', 'option'}, 111, function()
  hs.eventtap.keyStroke({'ctrl', 'option'},  'right', 0)
end)

hs.hotkey.bind(modsFor50, 111, function() hs.window.focusedWindow():move(units.right50, nil, true) end)
hs.hotkey.bind(modsFor75, 111, function() hs.window.focusedWindow():move(units.right75, nil, true) end)
hs.hotkey.bind(modsFor15, 111, function() hs.window.focusedWindow():move(units.right15, nil, true) end)


local function terminalEvent(name, event, app)
  if event == hs.application.watcher.activated then
    if name == 'Terminal' or name == 'ターミナル' then
      -- ターミナルでctrl + j
      hs.hotkey.bind({"ctrl"}, "j", function()
        hs.eventtap.keyStroke({}, 104, 0)
      end)
      hs.hotkey.disableAll(nil, "l")
      hs.hotkey.disableAll(nil, "q")
    else
      hs.hotkey.disableAll("ctrl", "j")
      if name == 'Microsoft Excel' then
        -- Excelでctrl + h
        hs.hotkey.bind({"ctrl"}, "h", function()
          hs.eventtap.keyStroke({}, 51, 0)
        end)
      elseif string.find(name, 'Android Studio') ~= nil or name == 'LINE' then
        -- Java Program で q (AquaSKK 対応)
        hs.hotkey.bind({}, "q", function()
          if hs.keycodes.currentMethod() == "ひらかな" then
            hs.keycodes.setMethod("カタカナ")
          elseif hs.keycodes.currentMethod() == "カタカナ" then
            hs.keycodes.setMethod("ひらかな")
          elseif hs.keycodes.currentMethod() == "全角英数" then
            hs.eventtap.keyStrokes("ｑ")
          else
            hs.eventtap.keyStrokes("q")
          end
        end)
        -- Java Program で l (AquaSKK 対応)
        hs.hotkey.bind({}, "l", function()
          if hs.keycodes.currentMethod() == "ひらかな" or hs.keycodes.currentMethod() == "カタカナ" then
            hs.keycodes.setMethod("ASCII")
          elseif hs.keycodes.currentMethod() == "全角英数" then
            hs.eventtap.keyStrokes("ｌ")
          elseif hs.keycodes.currentMethod() == "ASCII" then
            hs.eventtap.keyStrokes("l")
          else
            hs.eventtap.keyStrokes("l")
          end
        end)
      else
        hs.hotkey.disableAll(nil, "l")
        hs.hotkey.disableAll(nil, "q")
      end
    end
  end
end

terminalWatch = hs.application.watcher.new(terminalEvent)
terminalWatch:start()
