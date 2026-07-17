-- Disable Kitty Keyboard Protocol to prevent double key presses in foot/kitty
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    io.stdout:write("\027[>1u")
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    io.stdout:write("\027[<1u")
  end,
})
