hs.loadSpoon("EmmyLua")

local inputEnglishColemakDh = "io.github.colemakmods.keyboardlayout.colemakdh.colemakdhansi"

-- 입력 소스를 영어로 변경하는 공통 함수
local function changeInputSourceToEnglish()
  local inputSource = hs.keycodes.currentSourceID()

  if not (inputSource == inputEnglishColemakDh) then
    hs.eventtap.keyStroke({}, "right")
    hs.keycodes.currentSourceID(inputEnglishColemakDh)
  end
end

local function changeInputSourceKrToEnWhenEscapeVim()
  changeInputSourceToEnglish()
  hs.eventtap.keyStroke({}, "escape")
end

hs.hotkey.bind({ "control" }, 33, changeInputSourceKrToEnWhenEscapeVim)

local esc_bind

local function convert_to_eng_with_esc()
  changeInputSourceToEnglish()

  esc_bind:disable()
  hs.eventtap.keyStroke({}, "escape")
  esc_bind:enable()
end

esc_bind = hs.hotkey.new({}, "escape", convert_to_eng_with_esc):enable()
