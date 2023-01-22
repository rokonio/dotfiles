local cmp_status_ok, crates = pcall(require, "crates")
if not cmp_status_ok then
  print("Exited from " .. debug.getinfo(1, "S").source .. ":" .. debug.getinfo(1, "l").currentline)
  return
end

crates.setup {
  null_ls = {
    enabled = true,
    name = "crates.nvim",
  },
}
