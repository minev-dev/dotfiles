local M = {}

local servers = {
  "html",
  "cssls",
  "pyright",
  "marksman",
  "terraformls",
}

local function apply_core_defaults()
  require("nvchad.configs.lspconfig").defaults()
end

function M.setup()
  apply_core_defaults()
  vim.lsp.enable(servers)
end

M.setup()

return M
