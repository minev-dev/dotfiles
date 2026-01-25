local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- load defaults i.e lua_ls
nvlsp.defaults()

local servers = {
  "html",
  "cssls",
  "pyright",
  "marksman",
  "terraformls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
