hs.loadSpoon("EmmyLua")

local inputEnglishColemakDh = "io.github.colemakmods.keyboardlayout.colemakdh.colemakdhansi"

local esc_bind

-- 입력 소스를 영어로 변경하는 공통 함수
local function changeInputSourceToEnglish()
  local inputSource = hs.keycodes.currentSourceID()

  if not (inputSource == inputEnglishColemakDh) then
    hs.eventtap.keyStroke({}, "right")
    hs.keycodes.currentSourceID(inputEnglishColemakDh)
  end
end

-- Escape 키 입력을 처리하는 공통 함수
local function pressEscapeKey()
  esc_bind:disable()
  hs.eventtap.keyStroke({}, "escape")
  esc_bind:enable()
end

local function changeInputSourceKrToEnWhenEscapeVim()
  changeInputSourceToEnglish()
  pressEscapeKey()
end

hs.hotkey.bind({ "control" }, 33, changeInputSourceKrToEnWhenEscapeVim)

esc_bind = hs.hotkey.new({}, "escape", changeInputSourceKrToEnWhenEscapeVim):enable()
