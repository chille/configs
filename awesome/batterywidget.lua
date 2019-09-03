local awful = require("awful")
local wibox = require("wibox")

batterywidget = wibox.widget.textbox()
batterywidget:set_align("right")
batterywidget:set_text("right")

local timer1 = timer({}) --( {timeout = 1} )
timer1.timeout = 1

timer1:connect_signal("timeout", function()
	local f = io.open('/sys/class/power_supply/BAT0/charge_full')
	local charge_full = f:read('*all')
	f:close()

	local f = io.open('/sys/class/power_supply/BAT0/charge_now')
	local charge_now = f:read('*all')
	f:close()

	local time = 1.5

	local time_hour = math.floor(time)
	local time_minute = math.floor((time - time_hour) * 60)
	
	local percent = math.floor(charge_now / charge_full * 100)

	local percent_string = percent .. "%"

	if percent < 25 then
		percent_string = percent .. "%" --fg("red", percent .. "%")
	elseif percent < 50 then
		percent_string = percent .. "%" --fg("orange", percent .. "%")
	else
		percent_string = percent .. "%" --fg("green", percent .. "%")
	end

	local str = percent_string --.. " " .. string.format("(%02d:%02d)", time_hour, time_minute)
	batterywidget:set_text(str)
end)

timer1:start()