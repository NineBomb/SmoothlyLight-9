local lvgl = require("lvgl")
local img_index = 255
scr = lvgl.Object(nil, {
        w = lvgl.HOR_RES(),
        h = lvgl.VER_RES(),
        bg_color = 0,
        bg_opa = 0,
        border_width = 0,
        pad_all = 0
    })
    orderedTimer = lvgl.Timer({
        period = 17,
        cb = function(t)
            scr:set({ bg_opa = img_index })
            img_index = img_index - 10
            if img_index < 6 then
                orderedTimer:pause()
                scr:add_flag(lvgl.FLAG.HIDDEN)
            end
        end,
    })
    function ScreenStateChangedCB(pre, now, reason)
        if pre ~= "ON" and now == "ON" then
            img_index = 255
            scr:clear_flag(lvgl.FLAG.HIDDEN)
            orderedTimer:resume()
            
        end
    end
    return
