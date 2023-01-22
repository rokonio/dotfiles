local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print("Exited from " .. debug.getinfo(1, "S").source .. ":" .. debug.getinfo(1, "l").currentline)
  return
end

require "user.lsp.mason"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
