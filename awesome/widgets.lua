--widgetheight = 8


-- Music player widget
--mpdwidget = widget({ type = "textbox" })
--vicious.register(mpdwidget, vicious.widgets.mpd,
--	function (widget, args)
--		if args["{state}"] == "Stop" then
--			return " - "
--		else
--			return args["{Artist}"]..' - '.. args["{Title}"]
--		end
--	end, 10)


-- CPU usage widget
theme.widget_cpu = "/home/chille/.config/awesome/icons/cpu.png"
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
cpuwidget = widget({ type = "textbox" , width = 150})
cpuwidget.width=32
--cpuwidget.height=10
cpuwidget.font = "Profont 8"
vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")


-- Memory usage widget
theme.widget_mem = "/home/chille/.config/awesome/icons/mem.png"
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)
--memicon.image.height=10
memwidget = widget({ type = "textbox", font = "Profont 8" })
vicious.register(memwidget, vicious.widgets.mem, "<span>$1% ($2MB)</span>", 13)


-- FS usage widget
theme.widget_fs = "/home/chille/.config/awesome/icons/disk.png"
fsicon = widget({ type = "imagebox" })
fsicon.image = image(beautiful.widget_fs)
fswidget = widget({ type = "textbox" })
vicious.register(fswidget, vicious.widgets.fs, "${/ avail_p}% (${/ avail_gb}GB)", 13)


-- Network downlink
theme.widget_netdn = "/home/chille/.config/awesome/icons/down.png"
dnicon = widget({ type = "imagebox" })
dnicon.image = image(beautiful.widget_netdn)
netwidgetdn = widget({ type = "textbox" })
netwidgetdn.width=40
vicious.register(netwidgetdn, vicious.widgets.net, '<span color="#CC9393">${eth0 down_kb}</span>', 3)


-- Network uplink
theme.widget_netup = "/home/chille/.config/awesome/icons/up.png"
upicon = widget({ type = "imagebox" })
upicon.image = image(beautiful.widget_netup)
netwidgetup = widget({ type = "textbox" })
netwidgetup.width=40
vicious.register(netwidgetup, vicious.widgets.net, '<span color="#7F9F7F">${eth0 up_kb}</span>', 3)


-- Volume icon
theme.widget_vol = "/home/chille/.config/awesome/icons/vol.png"
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.widget_vol)


-- Separator
theme.widget_separator = "/home/chille/.config/awesome/icons/separator.png"
separator = widget({ type = "imagebox" })
separator.image = image(beautiful.widget_separator)
--separator.height=8
