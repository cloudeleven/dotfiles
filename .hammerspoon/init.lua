local function bindWithRepeat(mods, key, func)
  hs.hotkey.bind(mods, key, func, nil, func)
end

-- どの app でも強制的に適用したい keystrokes

-- ctrl + h = backspace
bindWithRepeat("ctrl", "h", function() hs.eventtap.keyStroke({}, 51, 0) end)
-- ctrl + f = → (右矢印) ※ terminal で意図しない挙動になるので必要な app で必要に応じて設定する
-- bindWithRepeat("ctrl", "f", function() hs.eventtap.keyStroke({}, 'right', 0) end)
-- ctrl + b = ← (左矢印) ※ terminal で意図しない挙動になるので必要な app で必要に応じて設定する
-- bindWithRepeat("ctrl", "b", function() hs.eventtap.keyStroke({}, 'left', 0) end)
-- ctrl + n = ↓ (下矢印)
bindWithRepeat("ctrl", "n", function() hs.eventtap.keyStroke({}, 'down', 0) end)
-- ctrl + p = ↑ (上矢印)
bindWithRepeat("ctrl", "p", function() hs.eventtap.keyStroke({}, 'up', 0) end)

local function inputEvent(name, event, app)
  if event == hs.application.watcher.activated then
    if name == 'Terminal' or name == 'ターミナル' or name == 'iTerm2' then
      -- Terminal, iTerm の場合

      -- 他の app 用の定義を cancel
      hs.hotkey.disableAll("ctrl", "f")
      hs.hotkey.disableAll("ctrl", "b")
      hs.hotkey.disableAll(nil, "q")
      hs.hotkey.disableAll(nil, "l")
      hs.hotkey.disableAll("shift", "l")

      -- ctrl + j
      hs.hotkey.bind("ctrl", "j", function()
        hs.eventtap.keyStroke({}, 104, 0)
      end)
    elseif name == 'Microsoft Excel' then
      -- Excel の場合

      -- 他の app 用の定義を cancel
      hs.hotkey.disableAll("ctrl", "j")
      hs.hotkey.disableAll(nil, "q")
      hs.hotkey.disableAll(nil, "l")
      hs.hotkey.disableAll("shift", "l")

      -- ctrl + f = → (右矢印)
      bindWithRepeat("ctrl", "f", function() hs.eventtap.keyStroke({}, 'right', 0) end)
      -- ctrl + b = ← (左矢印)
      bindWithRepeat("ctrl", "b", function() hs.eventtap.keyStroke({}, 'left', 0) end)
    elseif string.find(name, 'Android Studio') ~= nil or name == 'LINE' then
      -- Java 製 app の場合

      -- 他の app 用の定義を cancel
      hs.hotkey.disableAll("ctrl", "j")
      hs.hotkey.disableAll("ctrl", "f")
      hs.hotkey.disableAll("ctrl", "b")

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
      -- Java Program で shift + l (AquaSKK 対応)
      hs.hotkey.bind("shift", "l", function()
        if hs.keycodes.currentMethod() == "ひらかな" or hs.keycodes.currentMethod() == "カタカナ" then
          hs.keycodes.setMethod("全角英数")
        elseif hs.keycodes.currentMethod() == "全角英数" then
          hs.eventtap.keyStrokes("Ｌ")
        else
          hs.eventtap.keyStrokes("L")
        end
      end)
    else
      -- Terminal でも Java 製 app でもない場合、それら用の定義を cancel
      hs.hotkey.disableAll("ctrl", "j")
      hs.hotkey.disableAll("ctrl", "f")
      hs.hotkey.disableAll("ctrl", "b")
      hs.hotkey.disableAll(nil, "q")
      hs.hotkey.disableAll(nil, "l")
      hs.hotkey.disableAll("shift", "l")
    end
  end
end

inputWatch = hs.application.watcher.new(inputEvent)
inputWatch:start()


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
-- bindWithRepeat(nil, 111, function()
--   hs.eventtap.keyStroke(nil, 'right', 0) 
-- end)
-- bindWithRepeat({'shift'}, 111, function()
--   hs.eventtap.keyStroke({'shift'}, 'right', 0)
-- end)
-- bindWithRepeat({'option'}, 111, function()
--   hs.eventtap.keyStroke({'option'}, 'right', 0)
-- end)
-- bindWithRepeat({'option', 'ctrl'}, 111, function()
--   hs.eventtap.keyStroke({'option', 'ctrl'}, 'right', 0)
-- end)
-- bindWithRepeat({'shift', 'ctrl', 'option'}, 111, function()
--   hs.eventtap.keyStroke({'shift', 'ctrl', 'option'},  'right', 0)
-- end)
-- hs.hotkey.bind(modsFor50, 111, function() hs.window.focusedWindow():move(units.right50, nil, true) end)
-- hs.hotkey.bind(modsFor70, 111, function() hs.window.focusedWindow():move(units.right70, nil, true) end)
-- hs.hotkey.bind(modsFor30, 111, function() hs.window.focusedWindow():move(units.right30, nil, true) end)
