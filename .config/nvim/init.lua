--------------------------------------------------------------------------------
-- Global bootstrap
--------------------------------------------------------------------------------

local data_dir = vim.fn.stdpath "data"
vim.g.base46_cache = data_dir .. "/base46/"
vim.g.mapleader = " "

local lazy_path = data_dir .. "/lazy/lazy.nvim"
local lazy_repo = "https://github.com/folke/lazy.nvim.git"

local function ensure_lazy_installed()
  if vim.uv.fs_stat(lazy_path) then
    return
  end

  vim.fn.system { "git", "clone", "--filter=blob:none", lazy_repo, "--branch=stable", lazy_path }
end

ensure_lazy_installed()
vim.opt.rtp:prepend(lazy_path)

--------------------------------------------------------------------------------
-- Plugin runtime
--------------------------------------------------------------------------------

local lazy_config = require "configs.lazy"

require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

--------------------------------------------------------------------------------
-- Core UI defaults
--------------------------------------------------------------------------------

local function load_core_ui()
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")
end

load_core_ui()

--------------------------------------------------------------------------------
-- Configuration modules
--------------------------------------------------------------------------------

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

--------------------------------------------------------------------------------
-- Completion filtering
--------------------------------------------------------------------------------

require("cmp").setup {
  sources = {
    {
      name = "nvim_lsp",
      entry_filter = function(entry)
        return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
      end,
    },
  },
}

--------------------------------------------------------------------------------
-- Startup behavior
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    if pcall(require, "nvim-tree.api") then
      vim.defer_fn(function()
        vim.cmd "NvimTreeOpen"
      end, 10)
    end
  end,
  desc = "Auto open NvimTree on startup",
})
