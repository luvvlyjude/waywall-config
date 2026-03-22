local waywall = require("waywall")

local O = {}

O.AUTO_REENABLE_REMAPS = true
O.DYNAMIC_SCROLL_LOCK = true
O.DYNAMIC_SWAY_BINDS = true
O.JOIN_WORLD_EVENTS = true
O.LEAVE_WORLD_EVENTS = true

O.SCREEN_WIDTH = 3840
O.SCREEN_HEIGHT = 2160

-- SeedQueue main group grid dimensions
O.ROWS = 1
O.COLS = 3
O.X = 0.075
O.Y = 0.55
O.WIDTH = 0.85
O.HEIGHT = 0.0075

O.NORMAL_SENS = 16
O.MEASURE_SENS = 1

O.TEST = "*-R"

O.WIDE = "*-H"
O.THIN = "*-X"
O.TALL = "Shift-Tab"
O.MEASURE = "Tab"

O.RESET_1 = "S"
O.RESET_2 = "D"
O.RESET_3 = "F"

O.FULLSCREEN = "*-F11"

O.F3_T = "*-T"
O.F3_N = "*-N"

O.F3_C = "*-C"

O.TOGGLE_NBB = "GRAVE"
O.SUSPEND = "*-Alt_R"

-- waywall rebinds affect keys sent by ydotool
O.NORMAL_JOIN = "ydotool key -d 0 59:1 59:0 61:1 34:1 34:0 48:1 48:0 20:1 20:0 61:0"
O.NORMAL_LEAVE = "ydotool key -d 0 66:1 66:0"
-- O.NORMAL_LEAVE = "ydotool key -d 0"

O.REMAPS = {
    ["Q"] = "D",
    ["D"] = "N",
    ["N"] = "S",
    ["S"] = "E",
    ["E"] = "O",
    ["O"] = "Q",

    ["Z"] = "P",
    ["P"] = "Z",

    ["LEFTMETA"] = "LEFTCTRL",
}

return O
