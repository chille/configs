local wibox = require("wibox")
local vicious = require("vicious")

-- Music player widget
mpdwidget = wibox.widget.textbox()
mpdwidget:set_text("Music!")
vicious.register(mpdwidget, vicious.widgets.mpd,
	function (widget, args)
		if args["{state}"] == "Stop" then
			return " - "
		else
			return args["{Artist}"]..' - '.. args["{Title}"]
		end
	end, 10)


-- CPU usage widget
widget_cpu = "/home/chille/.config/awesome/icons/cpu.png"
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(widget_cpu)
cpuwidget = wibox.widget.textbox()
--cpuwidget:set_width(32)
--cpuwidget.font = "Profont 8"
vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")


-- Memory usage widget
widget_mem = "/home/chille/.config/awesome/icons/mem.png"
memicon = wibox.widget.imagebox()
memicon:set_image(widget_mem)
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "<span>$1% ($2MB)</span>", 13)


-- FS usage widget
widget_fs = "/home/chille/.config/awesome/icons/disk.png"
fsicon = wibox.widget.imagebox()
fsicon:set_image(widget_fs)
fswidget = wibox.widget.textbox()
vicious.register(fswidget, vicious.widgets.fs, "${/ avail_p}% (${/ avail_gb}GB)", 13)


-- Network downlink
widget_netdn = "/home/chille/.config/awesome/icons/down.png"
dnicon = wibox.widget.imagebox()
dnicon:set_image(widget_netdn)
netwidgetdn = wibox.widget.textbox()
--netwidgetdn:set_width(40)
vicious.register(netwidgetdn, vicious.widgets.net, '<span color="#CC9393">${eth0 down_kb}</span>', 3)


-- Network uplink
widget_netup = "/home/chille/.config/awesome/icons/up.png"
upicon = wibox.widget.imagebox()
upicon:set_image(widget_netup)
netwidgetup = wibox.widget.textbox()
--netwidgetup:set_width(40)
vicious.register(netwidgetup, vicious.widgets.net, '<span color="#7F9F7F">${eth0 up_kb}</span>', 3)


-- Volume icon
widget_vol = "/home/chille/.config/awesome/icons/vol.png"
volicon = wibox.widget.imagebox()
volicon:set_image(widget_vol)


-- Separator
widget_separator = "/home/chille/.config/awesome/icons/separator.png"
separator = wibox.widget.imagebox()
separator:set_image(widget_separator)