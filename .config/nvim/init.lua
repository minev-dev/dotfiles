--------------------------------------------------------------------------------
-- Global bootstrap
--------------------------------------------------------------------------------

local data_dir = vim.fn.stdpath "data"
vim.g.base46_cache = data_dir .. "/base46/"
vim.g.mapleader = " "

local lazy_path = data_dir .. "/lazy/lazy.nvim"

local function ensure_lazy_installed(path)
  if not vim.uv.fs_stat(path) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", path }
  end
end

ensure_lazy_installed(lazy_path)
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
    -- Check if NvimTree is available before trying to open it.
    local nvimtree_status, _ = pcall(require, "nvim-tree.api")
    if nvimtree_status then
      -- Use a small delay to ensure the UI is ready.
      vim.defer_fn(function()
        vim.cmd "NvimTreeOpen"
      end, 10)
    end
  end,
  desc = "Auto open NvimTree on startup",
})
