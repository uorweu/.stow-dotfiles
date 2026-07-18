return {
  "nendix/zen.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("zen").setup({
      variant = "black",
    })
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    -- vim.cmd.colorscheme("zen")
  end,
}
