local lvgl = require("lvgl")
local dataman = require("dataman")
local DEBUG_ENABLE = false
local STATE_POSITION_UP = 1
local STATE_POSITION_MID = 2
local STATE_POSITION_BOTTOM = 3
local img_index = 255
local function createWatchface()
	local t = {}
	t.M = lvgl.Object(
		n,
		{ outline_width = 0, border_width = 0, pad_all = 0, bg_opa = 255, bg_color = 0, w = 192, h = 490 }
	)
	return t
end
local function uiCreate()
	local W = createWatchface()
	local function screenONCb()
		W.M:clear_flag(lvgl.FLAG.HIDDEN)
		if orderedTimer then
			orderedTimer:resume()
			img_index = 255
		else
			orderedTimer = lvgl.Timer({
				period = 17,
				cb = function(t)
					W.M:set({ bg_opa = img_index })
					img_index = img_index - 10
					if img_index < 6 then
						orderedTimer:pause()
						W.M:add_flag(lvgl.FLAG.HIDDEN)
					end
				end,
			})
		end
	end
	local function screenOFFCb() end
	screenONCb()
	return screenONCb, screenOFFCb
end
local on, off = uiCreate()
function ScreenStateChangedCB(pre, now, reason)
	if pre ~= "ON" and now == "ON" then
		on()
	elseif pre == "ON" and now ~= "ON" then
		off()
	end
end
