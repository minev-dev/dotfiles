local M = {}

M.formatters_by_ft = {
  lua = { "stylua" },
  python = { "ruff", "ruff_format" },
  terraform = { "terraform_fmt" },
  markdown = { "prettier" },
  -- css = { "prettier" },
  -- html = { "prettier" },
}

M.format_on_save = {
  -- These options will be passed to conform.format()
  timeout_ms = 500,
  lsp_fallback = true,
}

return M
