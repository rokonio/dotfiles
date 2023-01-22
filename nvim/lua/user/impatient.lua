local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  print("Exited from " .. debug.getinfo(1, "S").source .. ":" .. debug.getinfo(1, "l").currentline)
  return
end

impatient.enable_profile()
