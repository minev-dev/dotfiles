local map = vim.keymap.set

require "nvchad.mappings"

--------------------------------------------------------------------------------
-- General Settings
--------------------------------------------------------------------------------

-- Clipboard configuration (OSC52)
vim.g.clipboard = require("vim.ui.clipboard.osc52").tool
vim.opt.clipboard = "unnamedplus"

--------------------------------------------------------------------------------
-- General Mappings
--------------------------------------------------------------------------------

-- Enter command mode with ;
map("n", ";", ":", { desc = "CMD enter command mode" })

--------------------------------------------------------------------------------
-- Plugin Mappings
--------------------------------------------------------------------------------

-- Telescope / LSP
map(
  "n",
  "grr",
  ':lua require("telescope.builtin").lsp_references()<CR>',
  { noremap = true, silent = true, desc = "Show references" }
)
map("n", "ga", ":lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true, desc = "Code action" })

-- Clipboard (OSC52)
map("n", "<leader>y", require("osc52").copy_operator, { expr = true, desc = "Copy operator" })
map("v", "<leader>y", require("osc52").copy_visual, { desc = "Copy visual" })

-- NvimTree
local function nvim_tree_opts(desc)
  return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
end

map("n", "<C-v>", require("nvim-tree.api").node.open.vertical, nvim_tree_opts "Open: Vertical Split")
map("n", "<C-x>", require("nvim-tree.api").node.open.horizontal, nvim_tree_opts "Open: Horizontal Split")

-- Terminal
local term_toggle = require("nvchad.term").toggle

map("t", "<Esc>", "<C-\\><C-N>", { desc = "Enter Terminal Normal Mode" })

map({ "n", "t" }, "<leader>tv", function()
  term_toggle { pos = "vsp", id = "custom_vertical_term", size = 0.4 }
end, { noremap = true, silent = true, desc = "Toggle vertical terminal" })

map("n", "<leader>th", function()
  term_toggle { pos = "sp", id = "custom_horizontal_term", size = 0.3 }
end, { noremap = true, silent = true, desc = "Toggle horizontal terminal" })