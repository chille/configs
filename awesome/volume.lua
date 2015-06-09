local awful = require("awful")
local wibox = require("wibox")

volumecfg = {}
volumecfg.cardid  = 1 -- 1 on MacBook
volumecfg.channel = "Master"
volumecfg.widget = wibox.widget.textbox()
volumecfg.widget:set_align("right")

volumecfg.mixercommand = function (command)
	-- Run the command
	os.execute("amixer -c " .. volumecfg.cardid .. " " .. command);

	-- Get status of channel
	local fd = io.popen("amixer -c " .. volumecfg.cardid .. " sget " .. volumecfg.channel)
	local status = fd:read("*all")
	fd:close()

	local volume = string.match(status, "(%d?%d?%d)%%")
--	volume = string.format("%3d", volume)
--	status = string.match(status, "%[(o[^%]]*)%]")
	status = "on"
	if string.find(status, "on", 1, true) then
		volume = volume .. "%"
	else   
		volume = volume .. "M"
	end
	volumecfg.widget:set_text(volume)
end

volumecfg.update = function ()
	volumecfg.mixercommand("sget " .. volumecfg.channel)
end

volumecfg.up = function ()
	volumecfg.mixercommand("sset " .. volumecfg.channel .. " 5%+")
end

volumecfg.down = function ()
	volumecfg.mixercommand("sset " .. volumecfg.channel .. " 5%-")
end

volumecfg.toggle = function ()
--	volumecfg.mixercommand("sset " .. volumecfg.channel .. " toggle")
	volumecfg.mixercommand("sset " .. volumecfg.channel .. " 0%")
end

volumecfg.widget:buttons(awful.util.table.join(
	awful.button({ }, 4, function () volumecfg.up() end),
	awful.button({ }, 5, function () volumecfg.down() end),
	awful.button({ }, 1, function () volumecfg.toggle() end)
))

volumecfg.update()

awesome.connect_signal("timer", function (timeout)
	volumecfg.update()
end)
