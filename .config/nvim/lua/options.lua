require "nvchad.options"

--------------------------------------------------------------------------------
-- Editing behavior
--------------------------------------------------------------------------------

-- Force use of internal registers for clipboard operations.
-- OSC52 handles system clipboard copying via TextYankPost in mappings.lua.
vim.o.clipboard = ""
