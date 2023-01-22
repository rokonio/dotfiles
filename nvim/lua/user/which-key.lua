local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print("Exited from " .. debug.getinfo(1, "S").source .. ":" .. debug.getinfo(1, "l").currentline)
  return
end

vim.o.timeout = true
vim.o.timeoutlen = 100

which_key.register {
  ["<leader>"] = {
    f = { name = "File" },
    l = { name = "LSP" },
    d = { name = "Debugger" },
    g = { name = "Git" },
    fe = { name = "Edit config" },
  },
}
