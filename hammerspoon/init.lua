hs.loadSpoon("EmmyLua")

-- 1. Configuration: Input Source IDs
local INPUT_SOURCE = {
    ENGLISH = "org.sil.ukelele.keyboardlayout.canary.canary",
    KOREAN  = "org.youknowone.inputmethod.Gureum.han3shin-p2"
}

-- 2. State Management
local escBind = nil

-- 3. Core Logic
local function switchToEnglish()
    local current = hs.keycodes.currentSourceID()
    if current ~= INPUT_SOURCE.ENGLISH then
        -- Optional: Send a 'right' stroke if needed (kept from original logic)
        hs.eventtap.keyStroke({}, "right")
        hs.keycodes.currentSourceID(INPUT_SOURCE.ENGLISH)
    end
end

local function handleEscapeAndSwitch()
    -- First, switch input source to English
    switchToEnglish()

    -- Then, send the actual Escape key stroke
    -- We disable the binding temporarily to avoid recursion
    if escBind then escBind:disable() end
    hs.eventtap.keyStroke({}, "escape")
    if escBind then escBind:enable() end
end

-- 4. Key Bindings
-- Global Escape key binding
escBind = hs.hotkey.new({}, "escape", handleEscapeAndSwitch):enable()

-- Control + [ (Specific mapping from original config)
hs.hotkey.bind({ "control" }, 33, handleEscapeAndSwitch)
