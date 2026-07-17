-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- norman
require("config.override_lualine")
require("config.prevent_double_keybpress") -- this allow other version of neovim (which high than 0.11.6 will works without the error of double backspace or the enterkey)
