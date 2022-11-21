-- ShiftIt もどき
hs.window.animationDuration = 0
units = {
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bottom50      = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  left70        = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 },
  right70       = { x = 0.30, y = 0.00, w = 0.70, h = 1.00 },
  top70         = { x = 0.00, y = 0.00, w = 1.00, h = 0.70 },
  bottom70      = { x = 0.00, y = 0.30, w = 1.00, h = 0.70 },
  left30        = { x = 0.00, y = 0.00, w = 0.30, h = 1.00 },
  right30       = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 },
  top30         = { x = 0.00, y = 0.00, w = 1.00, h = 0.30 },
  bottom30      = { x = 0.00, y = 0.70, w = 1.00, h = 0.30 }
}
modsFor50 = { 'ctrl', 'shift' }
modsFor70 = { 'ctrl', 'shift', 'option' }
modsFor30 = { 'ctrl', 'shift', 'option', 'command' }
hs.hotkey.bind(modsFor50, 'left', function() hs.window.focusedWindow():move(units.left50, nil, true) end)
hs.hotkey.bind(modsFor50, 'right', function() hs.window.focusedWindow():move(units.right50, nil, true) end)
hs.hotkey.bind(modsFor50, 'up', function() hs.window.focusedWindow():move(units.top50, nil, true) end)
hs.hotkey.bind(modsFor50, 'down', function() hs.window.focusedWindow():move(units.bottom50, nil, true) end)
hs.hotkey.bind(modsFor70, 'left', function() hs.window.focusedWindow():move(units.left70, nil, true) end)
hs.hotkey.bind(modsFor70, 'right', function() hs.window.focusedWindow():move(units.right70, nil, true) end)
hs.hotkey.bind(modsFor70, 'up', function() hs.window.focusedWindow():move(units.top70, nil, true) end)
hs.hotkey.bind(modsFor70, 'down', function() hs.window.focusedWindow():move(units.bottom70, nil, true) end)
hs.hotkey.bind(modsFor30, 'left', function() hs.window.focusedWindow():move(units.left30, nil, true) end)
hs.hotkey.bind(modsFor30, 'right', function() hs.window.focusedWindow():move(units.right30, nil, true) end)
hs.hotkey.bind(modsFor30, 'up', function() hs.window.focusedWindow():move(units.top30, nil, true) end)
hs.hotkey.bind(modsFor30, 'down', function() hs.window.focusedWindow():move(units.bottom30, nil, true) end)


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
hs.hotkey.bind(modsFor70, 111, function() hs.window.focusedWindow():move(units.right70, nil, true) end)
hs.hotkey.bind(modsFor30, 111, function() hs.window.focusedWindow():move(units.right30, nil, true) end)


local function terminalEvent(name, event, app)
  if event == hs.application.watcher.activated then
    if name == 'Terminal' or name == 'ターミナル' or name == 'iTerm2' then
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
