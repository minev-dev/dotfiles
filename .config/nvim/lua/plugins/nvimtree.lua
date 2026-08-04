local nvim_tree_opts = {
  filters = {
    git_ignored = false,
  },
}

return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = nvim_tree_opts,
  },
}
