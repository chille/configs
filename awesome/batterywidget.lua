 -- {{{ Battery state Widget
 
 batterywidget = widget({
     type = 'textbox',
     name = 'batterywidget',
     align = 'right'
     })
 
--vicious.register(batterywidget, 'function', function (widget, args)
awesome.connect_signal("timer", function (timeout)
     local f = io.open('/proc/acpi/battery/BAT0/info')
     local infocontents = f:read('*all')
     f:close()
 
     f = io.open('/proc/acpi/battery/BAT0/state')
     local statecontents = f:read('*all')
     f:close()
 
     local status, _
     -- Find the full capacity (from info)
     local full_cap
     
     status, _, full_cap = string.find(infocontents, "last full capacity:%s+(%d+).*")
 
     -- Find the current capacity, state and (dis)charge rate (from state)
     local state, rate, current_cap
     
     status, _, state = string.find(statecontents, "charging state:%s+(%w+)")
     status, _, rate  = string.find(statecontents, "present rate:%s+(%d+).*")
     status, _, current_cap = string.find(statecontents, "remaining capacity:%s+(%d+).*")
 
     local prefix, percent, time
     percent = current_cap / full_cap * 100
     if state == "charged" then
         return "AC: " .. fg("green", "100%")
     elseif state == "charging" then
         prefix = "AC: "
         time = (full_cap - current_cap) / rate
     elseif state == "discharging" then
         prefix = "Battery: "
         time = current_cap / rate
     end
 
     time_hour = math.floor(time)
     time_minute = math.floor((time - time_hour) * 60)
     
     percent = math.floor(percent)
     local percent_string
     if percent < 25 then
         percent_string = fg("red", percent .. "%")
     elseif percent < 50 then
         percent_string = fg("orange", percent .. "%")
     else
         percent_string = fg("green", percent .. "%")
     end
 
     return prefix .. percent_string .. " " .. string.format("(%02d:%02d)", time_hour, time_minute)
 end, 2)
 -- }}}