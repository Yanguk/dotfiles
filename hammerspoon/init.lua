hs.loadSpoon("EmmyLua")

local inputEnCanary = "org.sil.ukelele.keyboardlayout.canary.canary"
local inputKrShinP2 = "org.youknowone.inputmethod.Gureum.han3shin-p2"

local inputEn = inputEnCanary
local inputKr = inputKrShinP2

local esc_bind

-- 입력 소스를 영어로 변경하는 공통 함수
local function changeInputSourceToEnglish()
  local inputSource = hs.keycodes.currentSourceID()

  if not (inputSource == inputEn) then
    hs.eventtap.keyStroke({}, "right")
    hs.keycodes.currentSourceID(inputEn)
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

-- 한영전환을 위한 입력 소스 토글 함수
local function toggleInputSource()
  local currentSource = hs.keycodes.currentSourceID()

  if currentSource == inputEn then
    -- 영어에서 한글로
    hs.keycodes.currentSourceID(inputKr)
  else
    -- 한글에서 영어로
    hs.keycodes.currentSourceID(inputEn)
  end
end

-- control + space를 한영전환으로 매핑
hs.hotkey.bind({ "control" }, "space", toggleInputSource)
