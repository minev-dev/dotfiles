require "nvchad.options"

-- add yours here!

-- Force use of internal registers for clipboard operations.
-- We handle system clipboard copying via TextYankPost autocmd in mappings.lua.
vim.o.clipboard = ""