local M = {}

local function create_mapper(bufnr)
  return function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end
end

local function nav_hunk(gitsigns, direction, normal_motion)
  return function()
    if vim.wo.diff then
      vim.cmd.normal { normal_motion, bang = true }
    else
      gitsigns.nav_hunk(direction)
    end
  end
end

local function hunk_range_action(gitsigns, action)
  return function()
    action { vim.fn.line ".", vim.fn.line "v" }
  end
end

local function register_mappings(map, mode, mappings)
  for _, mapping in ipairs(mappings) do
    map(mode, mapping.lhs, mapping.rhs, mapping.desc)
  end
end

local function build_mappings(gitsigns)
  return {
    normal = {
      { lhs = "]c", rhs = nav_hunk(gitsigns, "next", "]c"), desc = "Next hunk" },
      { lhs = "[c", rhs = nav_hunk(gitsigns, "prev", "[c"), desc = "Prev hunk" },
      { lhs = "<leader>hs", rhs = gitsigns.stage_hunk, desc = "Stage hunk" },
      { lhs = "<leader>hr", rhs = gitsigns.reset_hunk, desc = "Reset hunk" },
      { lhs = "<leader>hS", rhs = gitsigns.stage_buffer, desc = "Stage buffer" },
      { lhs = "<leader>hR", rhs = gitsigns.reset_buffer, desc = "Reset buffer" },
      { lhs = "<leader>hp", rhs = gitsigns.preview_hunk, desc = "Preview hunk" },
      { lhs = "<leader>hi", rhs = gitsigns.preview_hunk_inline, desc = "Preview hunk inline" },
      { lhs = "<leader>hb", rhs = function()
        gitsigns.blame_line { full = true }
      end, desc = "Blame line" },
      { lhs = "<leader>hd", rhs = gitsigns.diffthis, desc = "Diff this" },
      { lhs = "<leader>hD", rhs = function()
        gitsigns.diffthis "~"
      end, desc = "Diff this ~" },
      { lhs = "<leader>hQ", rhs = function()
        gitsigns.setqflist "all"
      end, desc = "Set qflist all" },
      { lhs = "<leader>hq", rhs = gitsigns.setqflist, desc = "Set qflist" },
      { lhs = "<leader>tb", rhs = gitsigns.toggle_current_line_blame, desc = "Toggle blame" },
      { lhs = "<leader>tw", rhs = gitsigns.toggle_word_diff, desc = "Toggle word diff" },
    },
    visual = {
      { lhs = "<leader>hs", rhs = hunk_range_action(gitsigns, gitsigns.stage_hunk), desc = "Stage hunk" },
      { lhs = "<leader>hr", rhs = hunk_range_action(gitsigns, gitsigns.reset_hunk), desc = "Reset hunk" },
    },
  }
end

function M.on_attach(bufnr)
  local gitsigns = require "gitsigns"
  local map = create_mapper(bufnr)
  local mappings = build_mappings(gitsigns)

  register_mappings(map, "n", mappings.normal)
  register_mappings(map, "v", mappings.visual)
  map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select hunk")
end

return M
