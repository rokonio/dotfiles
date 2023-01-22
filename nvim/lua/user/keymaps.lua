-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Focus on left window", silent = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Focus on bottom window", silent = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Focus on top window", silent = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Focus on right window", silent = true })

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Move to left tab", silent = true })
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Move to right tab", silent = true })

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear highlight", silent = true })

-- Close buffers
keymap("n", "<leader>c", "<cmd>update<CR><cmd>Bdelete!<CR><cmd>NeoTreeFocus<CR>", { desc = "Save and Close tab", silent = true })
keymap("n", "<leader>q", "<cmd>update<CR><cmd>Bdelete!<CR>", { desc = "Save and Close tab", silent = true })

-- Save buffer
keymap({"n", "i", "v"}, "aa", "<esc>:update<CR>", { desc = "Save file", silent = true })

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press kj fast to enter
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NeoTree
keymap("n", "<leader>e", "<cmd>NeoTreeFocusToggle<CR>", { desc = "Toggle file explorer", silent = true })

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find a file", silent = true })
keymap("n", "<leader>ft", "<cmd>Telescope live_grep<CR>", { desc = "Find in all file", silent = true })
keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Open projects", silent = true })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find a buffer", silent = true })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Open keymaps explorer", silent = true })

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap(
  "n",
  "<leader>/",
  "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
  { desc = "Comment line", silent = true }
)
keymap(
  "x",
  "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment selection", silent = true }
)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { desc = "Format file", silent = true })

-- Toggle Term
keymap("", "<C-p>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal", silent = true })

keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("v", "<leader>p", [["_dP]], { desc = "Paste without changing buffer" })

keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
keymap({ "n", "v" }, "<leader>sp", [["+p]], { desc = "Paste from system clipboard" })
keymap({ "n", "v" }, "<leader>sP", [["+P]], { desc = "Paste from system clipboard" })
-- vim.keymap.set("n", "<leader>Y", [["+Y]], {desc="Move selection up"})

keymap({ "n", "x" }, "x", '"_x')

keymap("n", "fek", "<cmd>edit $HOME/.config/nvim/lua/user/keymaps.lua<cr>", { desc = "Edit keymaps" })
keymap("n", "fes", "<cmd>edit $HOME/.config/nvim/lua/user/options.lua<cr>", { desc = "Edit options" })
keymap("n", "fef", "<cmd>edit $HOME/.config/nvim/<cr>", { desc = "Edit folder" })
keymap("n", "fel", "<cmd>edit $HOME/.config/nvim/lua/user/lsp/mason.lua<cr>", { desc = "Edit LSP settings" })
