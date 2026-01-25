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

--------------------------------------------------------------------------------
-- Gitsigns Configuration
--------------------------------------------------------------------------------

require("gitsigns").setup {
  on_attach = function(bufnr)
    local gitsigns = require "gitsigns"

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal { "]c", bang = true }
      else
        gitsigns.nav_hunk "next"
      end
    end, { desc = "Next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal { "[c", bang = true }
      else
        gitsigns.nav_hunk "prev"
      end
    end, { desc = "Prev hunk" })

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })

    map("v", "<leader>hs", function()
      gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "Stage hunk" })

    map("v", "<leader>hr", function()
      gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "Reset hunk" })

    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

    map("n", "<leader>hb", function()
      gitsigns.blame_line { full = true }
    end, { desc = "Blame line" })

    map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })

    map("n", "<leader>hD", function()
      gitsigns.diffthis "~"
    end, { desc = "Diff this ~" })

    map("n", "<leader>hQ", function()
      gitsigns.setqflist "all"
    end, { desc = "Set qflist all" })

    map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set qflist" })

    -- Toggles
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame" })
    map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" })
  end,
}
