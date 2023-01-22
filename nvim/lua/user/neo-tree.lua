local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
  print("Exited from " .. debug.getinfo(1, "S").source .. ":" .. debug.getinfo(1, "l").currentline)
  return
end

-- local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- if not config_status_ok then
--   print("Exited from " .. debug.getinfo(1, "S").source .. ":" .. debug.getinfo(1, "l").currentline)
--   return
-- end
--
-- local tree_cb = nvim_tree_config.nvim_tree_callback

neo_tree.setup {
  close_if_last_window = true,
  enable_diagnostics = false,
  source_selector = {
    winbar = true,
    content_layout = "center",
    tab_labels = {
      filesystem = "" .. " File",
      buffers = "" .. " Bufs",
      git_status = "" .. " Git",
      diagnostics = "⚠" .. " Diagnostic",
    },
  },
  default_component_configs = {
    indent = { padding = 0 },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "",
    },
    git_status = {
      symbols = {
        added = "",
        deleted = "",
        modified = "",
        renamed = "➜",
        untracked = "★",
        ignored = "◌",
        unstaged = "✗",
        staged = "✓",
        conflict = "",
      },
    },
  },
  window = {
    width = 30,
    mappings = {
      ["<space>"] = false, -- disable space until we figure out which-key disabling
      o = "open",
      H = "prev_source",
      L = "next_source",
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        O = "system_open",
        h = "toggle_hidden",
      },
    },
    commands = {
      system_open = function(state)
        local path = state.tree:get_node():get_id()
        path = path or vim.fn.expand "<cfile>"
        if vim.fn.has "mac" == 1 then
          -- if mac use the open command
          vim.fn.jobstart({ "open", path }, { detach = true })
        elseif vim.fn.has "unix" == 1 then
          -- if unix then use xdg-open
          vim.fn.jobstart({ "xdg-open", path }, { detach = true })
        else
          -- if any other operating system notify the user that there is currently no support
          print "System open is not supported on this OS!"
        end
      end,
    },
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(_)
        vim.opt_local.signcolumn = "auto"
      end,
    },
  },
}
