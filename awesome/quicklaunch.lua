local util = require('awful.util')

function find_icon(icon_name, icon_dirs)
	if string.sub(icon_name, 1, 1) == '/' then
		if util.file_readable(icon_name) then
			return icon_name
		else
			return nil
		end
	end
	if icon_dirs then
		for _, v in ipairs(icon_dirs) do
			if util.file_readable(v .. "/" .. icon_name .. ".png") then
				return v .. '/' .. icon_name .. ".png"
			end
		end
	end
	return nil
end
 
function getValue(t, key)
	_, _, res = string.find(t, key .. " *= *([^%c]+)%c")
	return res
end
 
launchbar = { layout = awful.widget.layout.horizontal.leftright }
filedir = "/home/chille/.config/awesome/launchbar/" -- Specify your folder with shortcuts here
local items = {}
local files = io.popen("ls " .. filedir .. "*.desktop")
for f in files:lines() do
	local t = io.open(f):read("*all")
	table.insert(items, { image = find_icon(getValue(t,"Icon"), { "/usr/share/icons/hicolor/22x22/apps", "/usr/share/app-install/icons/", "/home/chille/.config/awesome/launchbar" }) or image(beautiful.awesome_icon),
		command = getValue(t,"Exec"),
		tooltip = getValue(t,"Name"),
		position = tonumber(getValue(t,"Position")) or 255 })
end

table.sort(items, function(a,b) return a.position < b.position end)
for i = 1, table.getn(items) do
	launchbar[i] = awful.widget.launcher(items[i])

--	local txt = items[i].tooltip
	local tt = awful.tooltip({ objects = { launchbar[i] } })
	tt:set_text(items[i].tooltip)
	tt:set_timeout(0)

--	ttmargin = { layout = wibox.layout.margin }
--	ttmargin:set_widgets(tt)
end
