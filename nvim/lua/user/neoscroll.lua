local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
  print("Exited from " .. debug.getinfo(1, "S").source .. ":" .. debug.getinfo(1, "l").currentline)
  return
end

neoscroll.setup {}
