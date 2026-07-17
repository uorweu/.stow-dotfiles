## the link 
https://www.youtube.com/watch?v=n4Lp4cV8YR0

## requirement: basic lua programming language

### things that i want in my neovim 
grep thing inside of neovim
find the file inside of neovim
bufferline lualine (these 2 i like take from the lazyvim distribution because i these 2 things)
side bar (other explorer in lazyvim)
syntax highting 
mason 
relative line
dashboard (for the quick access through the recent file)
telescope




# Learning about how a plugin is written first (but not entirely because i don't do this)
1. TJ a folder for the plugins for plugins
2. neovim doesn't know how to connect the folder for plugins yet
so in neovim they use "plug" to add the path of the plugin to neovim // to make neovim know that it has to run code from this path first 
-- this can be execute through the init.lua of neovim 
and through this file we can use the plugins manager such as packer of layzvim for manager the plugin 
so we the plugin manager can use to import the plugin

what is "vim runtime"?
- a list of a bunch of different folder that neovim consider is like the "base" folder and in those folder it will look for other important folder

- For example: it will look for the folder name lua and it will add those lua folder to lua environment

3. so there will be a couple of important folder that neovim consdider as load before start the editor
- such as plugins/ - for plugins or regular configs
- can check in the :help command of neovim with the following command

- lua/ for this folder

## Writing neovim config without any plugins manager
https://www.youtube.com/watch?v=skW3clVG5Fo
with only the init.lua right here
https://github.com/radleylewis/nvim-lite/tree/pluginless

neovim look inside of the .config and the init.lua file 
which is:
```bash
touch .config/nvim/init.lua
```
inside of the init.lua is completely blank

"vim.opt" the opt is for option to choice things available in neovim 
vim.opt.relativenumber = true -- to enable relative line number

# There are several phases in neovim 

## Entry point (init.lua)
neovim starts up and immediately looks for one specific file: init.lua
this file will point to other folder and files to make it happens

## phase 1: Core options
Usually, the very first hing init.lua does is load our core settings by running 
require("config.option")
this hapeens synchronously, blocking Neovim from doing anything else until it finishes. 
I want this to happen first so that basic settings (like spaces over tabs, clipboard settins, and line numbers) are established before any plugins start interacting with my editor.

## Phase 2: Loading the Plugin Manager 
Next, init.lua boots up the plugin manager (e.g, lazy.vim). It passess a list of all our plugins to lazy.vim

## Phease 3: Eeger Plugins
the plugin manger looks at our list of plugins. If a plugins is marked to load immedately (like our colorscheme, or critical UI elements), lazy.vim downloads it (if necesssary) and run its code right then and there.

## Phase 4: the "VeryLazy" Event (where keymaps go in LazyVim)
Once neovim has finished drawing the initial screen and loading eager plugins, lazy.nvim triggers a background event called User VeryLazy
Ths is where LazyVim choose to run require("config.keymaps") and 
require("config.autocmds")

- why load keymaps here? because keymaps and autocmds usually don't need to be active during the exact milisecond neovim is drawing its UI. By delaying them until the VeryLazy event, neovim feels like it opens instantly.

## Phase 5: LazyVim plugins

What about the rest of the plugins? If you ahve plugins for Markdown preview, or a file explorer, lazy.nvim intentionally does not load them yet.

Instead, it sets up triggers for example:
-"don't load the Markdown plugin until the user opens a .md file."
-"don't load telescope (the fuzzy finder) until the user presses <ldead>f"

when those specific actions happen, the plugin manager finally steps in and loads the plugin

# so to make the structure that i familiar with is the structure just like LazyVim distribution but but there is not distribution to load the plugins and config for me so i need to manual add them into the init.lua

so inside the nvim/lua is complete created by me 
so we can use lazyvim for manage the plugin
lazy.nvim go with the default UI menu for loading the plugins

# 







