hs.loadSpoon("EmmyLua")

local inputEnglishColemakDh = "io.github.colemakmods.keyboardlayout.colemakdh.colemakdhansi"

local function changeInputSourceKrToEnWhenEscapeVim()
  local inputSource = hs.keycodes.currentSourceID()

  if not (inputSource == inputEnglishColemakDh) then
    hs.keycodes.currentSourceID(inputEnglishColemakDh)
  end

  hs.eventtap.keyStroke({}, "escape")
end

hs.hotkey.bind({ "control" }, 33, changeInputSourceKrToEnWhenEscapeVim)
