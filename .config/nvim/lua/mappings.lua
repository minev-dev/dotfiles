local map = vim.keymap.set

require "nvchad.mappings"

--------------------------------------------------------------------------------
-- OSC52 + yank automation
--------------------------------------------------------------------------------

local function setup_osc52_yank_autocmd()
  -- Automatically copy to system clipboard on yank for default register.
  vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
      if vim.v.event.operator == "y" and vim.v.event.regname == "" then
        require("osc52").copy_register("")
      end
    end,
  })
end

setup_osc52_yank_autocmd()

--------------------------------------------------------------------------------
-- Editing behavior
--------------------------------------------------------------------------------

-- Enter command mode with ;
map("n", ";", ":", { desc = "CMD enter command mode" })

--------------------------------------------------------------------------------
-- Navigation
--------------------------------------------------------------------------------

-- Window resizing (normal mode)
map("n", "<C-w>+", "<cmd>resize +10<CR>", { noremap = true, silent = true, nowait = true, desc = "Increase window height" })
map("n", "<C-w>-", "<cmd>resize -10<CR>", { noremap = true, silent = true, nowait = true, desc = "Decrease window height" })
map("n", "<C-w>>", "<cmd>vertical resize +10<CR>", { noremap = true, silent = true, nowait = true, desc = "Increase window width" })
map("n", "<C-w><", "<cmd>vertical resize -10<CR>", { noremap = true, silent = true, nowait = true, desc = "Decrease window width" })

map("t", "<C-w>+", "<cmd>resize +10<CR>", { noremap = true, silent = true, nowait = true, desc = "Terminal increase window height" })
map("t", "<C-w>-", "<cmd>resize -10<CR>", { noremap = true, silent = true, nowait = true, desc = "Terminal decrease window height" })
map("t", "<C-w>>", "<cmd>vertical resize +10<CR>", { noremap = true, silent = true, nowait = true, desc = "Terminal increase window width" })
map("t", "<C-w><", "<cmd>vertical resize -10<CR>", { noremap = true, silent = true, nowait = true, desc = "Terminal decrease window width" })

-- File tree open helpers
local function nvim_tree_opts(desc)
  return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
end

map("n", "<C-v>", require("nvim-tree.api").node.open.vertical, nvim_tree_opts "Open: Vertical Split")
map("n", "<C-x>", require("nvim-tree.api").node.open.horizontal, nvim_tree_opts "Open: Horizontal Split")

--------------------------------------------------------------------------------
-- LSP and coding tools
--------------------------------------------------------------------------------

-- Telescope / LSP
map(
  "n",
  "grr",
  ':lua require("telescope.builtin").lsp_references()<CR>',
  { noremap = true, silent = true, desc = "Show references" }
)
map("n", "ga", ":lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true, desc = "Code action" })

--------------------------------------------------------------------------------
-- Clipboard / terminal UX
--------------------------------------------------------------------------------

-- Clipboard (OSC52)
map("n", "<leader>y", require("osc52").copy_operator, { expr = true, desc = "Copy operator" })
map("v", "<leader>y", require("osc52").copy_visual, { desc = "Copy visual" })

-- Terminal
local term_toggle = require("nvchad.term").toggle

map("t", "<Esc>", "<C-\\><C-N>", { desc = "Enter Terminal Normal Mode" })

map({ "n", "t" }, "<leader>tv", function()
  term_toggle { pos = "vsp", id = "custom_vertical_term", size = 0.4 }
end, { noremap = true, silent = true, desc = "Toggle vertical terminal" })

map("n", "<leader>th", function()
  term_toggle { pos = "sp", id = "custom_horizontal_term", size = 0.3 }
end, { noremap = true, silent = true, desc = "Toggle horizontal terminal" })
