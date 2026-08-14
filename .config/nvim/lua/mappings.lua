local map = vim.keymap.set
local osc52 = require "osc52"

require "nvchad.mappings"

local function map_opts(overrides)
  return vim.tbl_extend("force", {
    noremap = true,
    silent = true,
    nowait = true,
  }, overrides or {})
end

local function register_group(mode, mappings)
  for _, mapping in ipairs(mappings) do
    map(mode, mapping.lhs, mapping.rhs, map_opts { desc = mapping.desc })
  end
end

local function setup_osc52_yank_autocmd()
  vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
      if vim.v.event.operator == "y" and vim.v.event.regname == "" then
        osc52.copy_register ""
      end
    end,
  })
end

local function nvim_tree_opener(action_name)
  return function()
    local ok, tree_api = pcall(require, "nvim-tree.api")
    if not ok then
      return
    end

    local action = tree_api.node.open[action_name]
    if action then
      action()
    end
  end
end

setup_osc52_yank_autocmd()

--------------------------------------------------------------------------------
-- Editing behavior
--------------------------------------------------------------------------------

register_group("n", {
  { lhs = ";", rhs = ":", desc = "CMD enter command mode" },
})

--------------------------------------------------------------------------------
-- Window resizing
--------------------------------------------------------------------------------

register_group({ "n", "t" }, {
  { lhs = "<C-w>+", rhs = "<cmd>resize +10<CR>", desc = "Increase window height" },
  { lhs = "<C-w>-", rhs = "<cmd>resize -10<CR>", desc = "Decrease window height" },
  { lhs = "<C-w>>", rhs = "<cmd>vertical resize +10<CR>", desc = "Increase window width" },
  { lhs = "<C-w><", rhs = "<cmd>vertical resize -10<CR>", desc = "Decrease window width" },
})

--------------------------------------------------------------------------------
-- File tree open helpers
--------------------------------------------------------------------------------

register_group("n", {
  { lhs = "<C-v>", rhs = nvim_tree_opener "vertical", desc = "nvim-tree: Open: Vertical Split" },
  { lhs = "<C-x>", rhs = nvim_tree_opener "horizontal", desc = "nvim-tree: Open: Horizontal Split" },
})

--------------------------------------------------------------------------------
-- LSP and coding tools
--------------------------------------------------------------------------------

register_group("n", {
  {
    lhs = "grr",
    rhs = function()
      require("telescope.builtin").lsp_references()
    end,
    desc = "Show references",
  },
  { lhs = "ga", rhs = function() vim.lsp.buf.code_action() end, desc = "Code action" },
})

--------------------------------------------------------------------------------
-- Clipboard / terminal UX
--------------------------------------------------------------------------------

map("n", "<leader>y", osc52.copy_operator, map_opts { expr = true, desc = "Copy operator" })
map("v", "<leader>y", osc52.copy_visual, map_opts { desc = "Copy visual" })
map("t", "<Esc>", "<C-\\><C-N>", map_opts { desc = "Enter Terminal Normal Mode" })

register_group({ "n", "t" }, {
  {
    lhs = "<leader>tv",
    rhs = function()
      require("nvchad.term").toggle { pos = "vsp", id = "custom_vertical_term", size = 0.4 }
    end,
    desc = "Toggle vertical terminal",
  },
  {
    lhs = "<leader>th",
    rhs = function()
      require("nvchad.term").toggle { pos = "sp", id = "custom_horizontal_term", size = 0.3 }
    end,
    desc = "Toggle horizontal terminal",
  },
})
