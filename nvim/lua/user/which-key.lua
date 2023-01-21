local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
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
    fe = { name = "Edit config"}
  },
}
