{
  home.file = {
    ".config/nvim/init.lua" = {
      text = "
local ok, err = pcall(require, \"core\")
      ";
    };

    ".config/nvim/lua/colors/highlights.lua" = {
      text = "
local cmd = vim.cmd

local colors = require(\"colors\").get()

local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local green = colors.green
local grey = colors.grey
local grey_fg = colors.grey_fg
local line = colors.line
local nord_blue = colors.nord_blue
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow

local ui = require(\"core.utils\").load_config().ui

-- Define bg color
-- @param group Group
-- @param color Color
local function bg(group, color)
   cmd(\"hi \" .. group .. \" guibg=\" .. color)
end

-- Define fg color
-- @param group Group
-- @param color Color
local function fg(group, color)
   cmd(\"hi \" .. group .. \" guifg=\" .. color)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
local function fg_bg(group, fgcol, bgcol)
   cmd(\"hi \" .. group .. \" guifg=\" .. fgcol .. \" guibg=\" .. bgcol)
end

-- Comments
if ui.italic_comments then
   fg(\"Comment\", grey_fg .. \" gui=italic\")
else
   fg(\"Comment\", grey_fg)
end

-- Disable cusror line
cmd \"hi clear CursorLine\"
-- Line number
fg(\"cursorlinenr\", white)

-- same it bg, so it doesn't appear
fg(\"EndOfBuffer\", black)

-- For floating windows
fg(\"FloatBorder\", blue)
bg(\"NormalFloat\", one_bg)

-- Pmenu
bg(\"Pmenu\", one_bg)
bg(\"PmenuSbar\", one_bg2)
bg(\"PmenuSel\", pmenu_bg)
bg(\"PmenuThumb\", nord_blue)
fg(\"CmpItemAbbr\", white)
fg(\"CmpItemAbbrMatch\", white)
fg(\"CmpItemKind\", white)
fg(\"CmpItemMenu\", white)

-- misc

-- inactive statuslines as thin lines
fg(\"StatusLineNC\", one_bg2 .. \" gui=underline\")

fg(\"LineNr\", grey)
fg(\"NvimInternalError\", red)
fg(\"VertSplit\", one_bg2)

if ui.transparency then
   bg(\"Normal\", \"NONE\")
   bg(\"Folded\", \"NONE\")
   fg(\"Folded\", \"NONE\")
   fg(\"Comment\", grey)
end

-- [[ Plugin Highlights

-- Dashboard
fg(\"DashboardCenter\", grey_fg)
fg(\"DashboardFooter\", grey_fg)
fg(\"DashboardHeader\", grey_fg)
fg(\"DashboardShortcut\", grey_fg)

-- Git signs
fg_bg(\"DiffAdd\", nord_blue, \"none\")
fg_bg(\"DiffChange\", grey_fg, \"none\")
fg_bg(\"DiffModified\", nord_blue, \"none\")

-- Indent blankline plugin
fg(\"IndentBlanklineChar\", line)

-- ]]

-- [[ LspDiagnostics

-- Errors
fg(\"LspDiagnosticsSignError\", red)
fg(\"LspDiagnosticsSignWarning\", yellow)
fg(\"LspDiagnosticsVirtualTextError\", red)
fg(\"LspDiagnosticsVirtualTextWarning\", yellow)

-- Info
fg(\"LspDiagnosticsSignInformation\", green)
fg(\"LspDiagnosticsVirtualTextInformation\", green)

-- Hints
fg(\"LspDiagnosticsSignHint\", purple)
fg(\"LspDiagnosticsVirtualTextHint\", purple)

-- ]]

-- NvimTree
fg(\"NvimTreeEmptyFolderName\", blue)
fg(\"NvimTreeEndOfBuffer\", darker_black)
fg(\"NvimTreeFolderIcon\", folder_bg)
fg(\"NvimTreeFolderName\", folder_bg)
fg(\"NvimTreeGitDirty\", red)
fg(\"NvimTreeIndentMarker\", one_bg2)
bg(\"NvimTreeNormal\", darker_black)
bg(\"NvimTreeNormalNC\", darker_black)
fg(\"NvimTreeOpenedFolderName\", blue)
fg(\"NvimTreeRootFolder\", red .. \" gui=underline\") -- enable underline for root folder in nvim tree
fg_bg(\"NvimTreeStatuslineNc\", darker_black, darker_black)
fg(\"NvimTreeVertSplit\", darker_black)
bg(\"NvimTreeVertSplit\", darker_black)
fg_bg(\"NvimTreeWindowPicker\", red, black2)

-- Disable some highlight in nvim tree if transparency enabled
if ui.transparency then
   bg(\"NvimTreeNormal\", \"NONE\")
   bg(\"NvimTreeStatusLineNC\", \"NONE\")
   bg(\"NvimTreeVertSplit\", \"NONE\")
   fg(\"NvimTreeVertSplit\", grey)
end

-- Telescope
fg(\"TelescopeBorder\", line)
fg(\"TelescopePreviewBorder\", grey)
fg(\"TelescopePromptBorder\", line)
fg(\"TelescopeResultsBorder\", line)
      ";
    };

    ".config/nvim/lua/colors/init.lua" = {
      text = "
local M = {}

-- if theme given, load given theme if given, otherwise nvchad_theme
M.init = function(theme)
   if not theme then
      theme = require(\"core.utils\").load_config().ui.theme
   end

   -- set the global theme, used at various places like theme switcher, highlights
   vim.g.nvchad_theme = theme

   local present, base16 = pcall(require, \"base16\")

   if present then
      -- first load the base16 theme
      base16(base16.themes(theme), true)

      -- unload to force reload
      package.loaded[\"colors.highlights\" or false] = nil
      -- then load the highlights
      require \"colors.highlights\"
   else
      return false
   end
end

-- returns a table of colors for givem or current theme
M.get = function(theme)
   if not theme then
      theme = vim.g.nvchad_theme
   end

   return require(\"hl_themes.\" .. theme)
end

return M
      ";
    };

    ".config/nvim/lua/core/autocmds.lua" = {
      text = "
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]
vim.cmd [[ autocmd BufEnter,BufWinEnter,FileType,WinEnter * lua require(\"core.utils\").hide_statusline() ]]
      ";
    };

    ".config/nvim/lua/core/custom.lua" = {
      text = "
local function isModuleAvailable(name)
   if package.loaded[name] then
      return true
   else
      for _, searcher in ipairs(package.searchers or package.loaders) do
         local loader = searcher(name)
         if type(loader) == \"function\" then
            package.preload[name] = loader
            return true
         end
      end
      return false
   end
end

local loadIfExists = function(module)
   if isModuleAvailable(module) then
      require(module)
   end
end

loadIfExists \"custom\"
      ";
    };

    ".config/nvim/lua/core/default_config.lua" = {
      text = "
-- IMPORTANT NOTE : This is default config, so dont change anything here.
-- use custom/chadrc.lua instead

local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

-- non plugin normal, available without any plugins
M.options = {
   -- NeoVim/Vim options
   clipboard = \"unnamedplus\",
   cmdheight = 1,
   ruler = false,
   hidden = true,
   ignorecase = true,
   smartcase = true,
   mapleader = \" \",
   mouse = \"a\",
   number = true,
   -- relative numbers in normal mode tool at the bottom of options.lua
   numberwidth = 2,
   relativenumber = false,
   expandtab = true,
   shiftwidth = 2,
   smartindent = true,
   tabstop = 8, -- Number of spaces that a <Tab> in the file counts for
   timeoutlen = 400,
   -- interval for writing swap file to disk, also used by gitsigns
   updatetime = 250,
   undofile = true, -- keep a permanent undo (across restarts)
   -- NvChad options
   nvChad = {
      copy_cut = true, -- copy cut text ( x key ), visual and normal mode
      copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
      insert_nav = true, -- navigation in insertmode
      window_nav = true,
      theme_toggler = false,
      -- used for updater
      update_url = \"https://github.com/NvChad/NvChad\",
      update_branch = \"main\",
   },
}

-- ui configs
M.ui = {
   italic_comments = false,
   -- theme to be used, check available themes with `<leader> + t + h`
   theme = \"onedark\",
   -- toggle between two themes, see theme_toggler mappings
   theme_toggler = {
      \"onedark\",
      \"gruvchad\",
   },
   -- Enable this only if your terminal has the colorscheme set which nvchad uses
   -- For Ex : if you have onedark set in nvchad, set onedark's bg color on your terminal
   transparency = false,
}

-- these are plugin related options
M.plugins = {
   -- enable and disable plugins (false for disable)
   status = {
      blankline = true, -- show code scope with symbols
      bufferline = true, -- list open buffers up the top, easy switching too
      colorizer = false, -- color RGB, HEX, CSS, NAME color codes
      comment = true, -- easily (un)comment code, language aware
      dashboard = false, -- NeoVim 'home screen' on open
      esc_insertmode = true, -- map to <ESC> with no lag
      feline = true, -- statusline
      gitsigns = true, -- gitsigns in statusline
      lspsignature = true, -- lsp enhancements
      telescope_media = false, -- media previews within telescope finders
      vim_matchup = true, -- % operator enhancements
      cmp = true,
      nvimtree = true,
      autopairs = true,
   },
   options = {
      lspconfig = {
         setup_lspconf = \"\", -- path of file containing setups of different lsps
      },
      nvimtree = {
         enable_git = 0,
      },
      luasnip = {
         snippet_path = {},
      },
      statusline = { -- statusline related options
         -- these are filetypes, not pattern matched
         -- shown filetypes will overrule hidden filetypes
         hidden = {
            \"help\",
            \"dashboard\",
            \"NvimTree\",
            \"terminal\",
         },
         -- show short statusline on small screens
         shortline = true,
         shown = {},
         -- default, round , slant , block , arrow
         style = \"default\",
      },
      esc_insertmode_timeout = 300,
   },
   default_plugin_config_replace = {},
}

-- mappings -- don't use a single keymap twice --
-- non plugin mappings
M.mappings = {
   -- custom = {}, -- all custom user mappings
   -- close current focused buffer
   close_buffer = \"<leader>x\",
   copy_whole_file = \"<C-a>\", -- copy all contents of the current buffer
   line_number_toggle = \"<leader>n\", -- show or hide line number
   new_buffer = \"<S-t>\", -- open a new buffer
   new_tab = \"<C-t>b\", -- open a new vim tab
   save_file = \"<C-s>\", -- save file using :w
   theme_toggler = \"<leader>tt\", -- for theme toggler, see in ui.theme_toggler
   -- navigation in insert mode, only if enabled in options
   insert_nav = {
      backward = \"<C-h>\",
      end_of_line = \"<C-e>\",
      forward = \"<C-l>\",
      next_line = \"<C-k>\",
      prev_line = \"<C-j>\",
      beginning_of_line = \"<C-a>\",
   },
   --better window movement
   window_nav = {
      moveLeft = \"<C-h>\",
      moveRight = \"<C-l>\",
      moveUp = \"<C-k>\",
      moveDown = \"<C-j>\",
   },
   -- terminal related mappings
   terminal = {
      -- multiple mappings can be given for esc_termmode and esc_hide_termmode
      -- get out of terminal mode
      esc_termmode = { \"jk\" }, -- multiple mappings allowed
      -- get out of terminal mode and hide it
      esc_hide_termmode = { \"JK\" }, -- multiple mappings allowed
      -- show & recover hidden terminal buffers in a telescope picker
      pick_term = \"<leader>W\",
      -- below three are for spawning terminals
      new_horizontal = \"<leader>h\",
      new_vertical = \"<leader>v\",
      new_window = \"<leader>w\",
   },
   -- update nvchad from nvchad, chadness 101
   update_nvchad = \"<leader>uu\",
}

-- all plugins related mappings
M.mappings.plugins = {
   -- list open buffers up the top, easy switching too
   bufferline = {
      next_buffer = \"<TAB>\", -- next buffer
      prev_buffer = \"<S-Tab>\", -- previous buffer
   },
   -- easily (un)comment code, language aware
   comment = {
      toggle = \"<leader>/\", -- toggle comment (works on multiple lines)
   },
   -- NeoVim 'home screen' on open
   dashboard = {
      bookmarks = \"<leader>bm\",
      new_file = \"<leader>fn\", -- basically create a new buffer
      open = \"<leader>db\", -- open dashboard
      session_load = \"<leader>l\", -- load a saved session
      session_save = \"<leader>s\", -- save a session
   },
   -- map to <ESC> with no lag
   better_escape = { -- <ESC> will still work
      esc_insertmode = { \"jk\" }, -- multiple mappings allowed
   },
   -- file explorer/tree
   nvimtree = {
      toggle = \"<C-n>\",
      focus = \"<leader>e\",
   },
   -- multitool for finding & picking things
   telescope = {
      buffers = \"<leader>fb\",
      find_files = \"<leader>ff\",
      find_hiddenfiles = \"<leader>fa\",
      git_commits = \"<leader>cm\",
      git_status = \"<leader>gt\",
      help_tags = \"<leader>fh\",
      live_grep = \"<leader>fw\",
      oldfiles = \"<leader>fo\",
      themes = \"<leader>th\", -- NvChad theme picker
      -- media previews within telescope finders
      telescope_media = {
         media_files = \"<leader>fp\",
      },
   },
}

return M
      ";
    };

    ".config/nvim/lua/core/hooks.lua" = {
      text = "
local hooks, overrides, M = {}, {}, {}
local allowed_hooks = {
   \"install_plugins\",
   \"setup_mappings\",
   \"ready\",
}

local function has_value(tab, val)
   for _, value in ipairs(tab) do
      if value == val then
         return true
      end
   end

   return false
end

M.add = function(name, fn)
   if not (has_value(allowed_hooks, name)) then
      error(\"Custom lua uses unallowed hook \" .. name)
   end
   if hooks[name] == nil then
      hooks[name] = {}
   end
   table.insert(hooks[name], fn)
end

M.run = function(name, args)
   if hooks[name] == nil then
      return
   end

   for _, hook in pairs(hooks[name]) do
      hook(args)
   end
end

M.createOverrides = function(module)
   local O = {}

   O.get = function(name, default)
      local current = default
      if overrides[module] and overrides[module][name] then
         if type(overrides[module][name]) == \"function\" then
            current = overrides[module][name]
         elseif type(overrides[module][name]) == \"table\" then
            for _, override in pairs(overrides[module][name]) do
               current = override(current)
            end
         end
      end
      return current
   end

   return O
end

M.override = function(module, name, overwrite)
   if overrides[module] == nil then
      overrides[module] = {}
   end
   if overrides[module][name] == nil then
      overrides[module][name] = {}
   end
   table.insert(overrides[module][name], overwrite)
end

return M
      ";
    };

    ".config/nvim/lua/core/init.lua" = {
      text = "
local core_modules = {
   \"core.custom\",
   \"core.options\",
   \"core.autocmds\",
   \"core.mappings\",
}

local hooks = require \"core.hooks\"

-- set all the non plugin mappings
require(\"core.mappings\").misc()

hooks.run \"ready\"
      ";
    };

    ".config/nvim/lua/core/mappings.lua" = {
      text = "
local utils = require \"core.utils\"
local hooks = require \"core.hooks\"

local config = utils.load_config()
local map = utils.map

local maps = config.mappings
local plugin_maps = maps.plugins
local nvChad_options = config.options.nvChad

local cmd = vim.cmd

local M = {}

-- these mappings will only be called during initialization
M.misc = function()
   local function non_config_mappings()
      -- Don't copy the replaced text after pasting in visual mode
      map(\"v\", \"p\", '\"_dP')

      -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
      -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
      -- empty mode is same as using :map
      -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
      map(\"\", \"j\", 'v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"', { expr = true })
      map(\"\", \"k\", 'v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"', { expr = true })
      map(\"\", \"<Down>\", 'v:count || mode(1)[0:1] == \"no\" ? \"j\" : \"gj\"', { expr = true })
      map(\"\", \"<Up>\", 'v:count || mode(1)[0:1] == \"no\" ? \"k\" : \"gk\"', { expr = true })

      -- use ESC to turn off search highlighting
      map(\"n\", \"<Esc>\", \":noh <CR>\")
   end

   local function optional_mappings()
      -- don't yank text on cut ( x )
      if not nvChad_options.copy_cut then
         map({ \"n\", \"v\" }, \"x\", '\"_x')
      end

      -- don't yank text on delete ( dd )
      if not nvChad_options.copy_del then
         map({ \"n\", \"v\" }, \"d\", '\"_d')
      end

      -- navigation within insert mode
      if nvChad_options.insert_nav then
         local inav = maps.insert_nav

         map(\"i\", inav.backward, \"<Left>\")
         map(\"i\", inav.end_of_line, \"<End>\")
         map(\"i\", inav.forward, \"<Right>\")
         map(\"i\", inav.next_line, \"<Up>\")
         map(\"i\", inav.prev_line, \"<Down>\")
         map(\"i\", inav.beginning_of_line, \"<ESC>^i\")
      end

      -- easier navigation between windows
      if nvChad_options.window_nav then
         local wnav = maps.window_nav

         map(\"n\", wnav.moveLeft, \"<C-w>h\")
         map(\"n\", wnav.moveRight, \"<C-w>l\")
         map(\"n\", wnav.moveUp, \"<C-w>k\")
         map(\"n\", wnav.moveDown, \"<C-w>j\")
      end

      -- check the theme toggler
      if nvChad_options.theme_toggler then
         map(
            \"n\",
            maps.theme_toggler,
            \":lua require('nvchad').toggle_theme(require('core.utils').load_config().ui.theme_toggler) <CR>\"
         )
      end
   end

   local function required_mappings()
      map(\"n\", maps.close_buffer, \":lua require('core.utils').close_buffer() <CR>\") -- close  buffer
      map(\"n\", maps.copy_whole_file, \":%y+ <CR>\") -- copy whole file content
      map(\"n\", maps.new_buffer, \":enew <CR>\") -- new buffer
      map(\"n\", maps.new_tab, \":tabnew <CR>\") -- new tabs
      map(\"n\", maps.line_number_toggle, \":set nu! <CR>\") -- toggle numbers
      map(\"n\", maps.save_file, \":w <CR>\") -- ctrl + s to save file

      -- terminal mappings --
      local term_maps = maps.terminal
      -- get out of terminal mode
      map(\"t\", term_maps.esc_termmode, \"<C-\\><C-n>\")
      -- hide a term from within terminal mode
      map(\"t\", term_maps.esc_hide_termmode, \"<C-\\><C-n> :lua require('core.utils').close_buffer() <CR>\")
      -- pick a hidden term
      map(\"n\", term_maps.pick_term, \":Telescope terms <CR>\")
      -- Open terminals
      -- TODO this opens on top of an existing vert/hori term, fixme
      map(\"n\", term_maps.new_horizontal, \":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>\")
      map(\"n\", term_maps.new_vertical, \":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>\")
      map(\"n\", term_maps.new_window, \":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>\")
      -- terminal mappings end --

      -- Add Packer commands because we are not loading it at startup
      cmd \"silent! command PackerClean lua require 'plugins' require('packer').clean()\"
      cmd \"silent! command PackerCompile lua require 'plugins' require('packer').compile()\"
      cmd \"silent! command PackerInstall lua require 'plugins' require('packer').install()\"
      cmd \"silent! command PackerStatus lua require 'plugins' require('packer').status()\"
      cmd \"silent! command PackerSync lua require 'plugins' require('packer').sync()\"
      cmd \"silent! command PackerUpdate lua require 'plugins' require('packer').update()\"

      -- add NvChadUpdate command and mapping
      cmd \"silent! command! NvChadUpdate lua require('nvchad').update_nvchad()\"
      map(\"n\", maps.update_nvchad, \":NvChadUpdate <CR>\")

      -- add ChadReload command and maping
      -- cmd \"silent! command! NvChadReload lua require('nvchad').reload_config()\"
   end

   non_config_mappings()
   optional_mappings()
   required_mappings()
   hooks.run(\"setup_mappings\", map)
end

-- below are all plugin related mappings

M.bufferline = function()
   local m = plugin_maps.bufferline

   map(\"n\", m.next_buffer, \":BufferLineCycleNext <CR>\")
   map(\"n\", m.prev_buffer, \":BufferLineCyclePrev <CR>\")
end

M.comment = function()
   local m = plugin_maps.comment.toggle
   map(\"n\", m, \":CommentToggle <CR>\")
   map(\"v\", m, \":CommentToggle <CR>\")
end

M.dashboard = function()
   local m = plugin_maps.dashboard

   map(\"n\", m.bookmarks, \":DashboardJumpMarks <CR>\")
   map(\"n\", m.new_file, \":DashboardNewFile <CR>\")
   map(\"n\", m.open, \":Dashboard <CR>\")
   map(\"n\", m.session_load, \":SessionLoad <CR>\")
   map(\"n\", m.session_save, \":SessionSave <CR>\")
end

M.nvimtree = function()
   map(\"n\", plugin_maps.nvimtree.toggle, \":NvimTreeToggle <CR>\")
   map(\"n\", plugin_maps.nvimtree.focus, \":NvimTreeFocus <CR>\")
end

M.telescope = function()
   local m = plugin_maps.telescope

   map(\"n\", m.buffers, \":Telescope buffers <CR>\")
   map(\"n\", m.find_files, \":Telescope find_files <CR>\")
   map(\"n\", m.find_hiddenfiles, \":Telescope find_files hidden=true <CR>\")
   map(\"n\", m.git_commits, \":Telescope git_commits <CR>\")
   map(\"n\", m.git_status, \":Telescope git_status <CR>\")
   map(\"n\", m.help_tags, \":Telescope help_tags <CR>\")
   map(\"n\", m.live_grep, \":Telescope live_grep <CR>\")
   map(\"n\", m.oldfiles, \":Telescope oldfiles <CR>\")
   map(\"n\", m.themes, \":Telescope themes <CR>\")
end

M.telescope_media = function()
   local m = plugin_maps.telescope.telescope_media

   map(\"n\", m.media_files, \":Telescope media_files <CR>\")
end

return M
      ";
    };

    ".config/nvim/lua/core/options.lua" = {
      text = "
local opt = vim.opt
local g = vim.g

-- export user config as a global varibale
g.nvchad_user_config = \"chadrc\"

local options = require(\"core.utils\").load_config().options

opt.title = true
opt.clipboard = options.clipboard
opt.cmdheight = options.cmdheight
opt.cul = true -- cursor line

-- Indentline
opt.expandtab = options.expandtab
opt.shiftwidth = options.shiftwidth
opt.smartindent = options.smartindent

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = \" \" }

opt.hidden = options.hidden
opt.ignorecase = options.ignorecase
opt.smartcase = options.smartcase
opt.mouse = options.mouse

-- Numbers
opt.number = options.number
opt.numberwidth = options.numberwidth
opt.relativenumber = options.relativenumber
opt.ruler = options.ruler

-- disable nvim intro
opt.shortmess:append \"sI\"

opt.signcolumn = \"yes\"
opt.splitbelow = true
opt.splitright = true
opt.tabstop = options.tabstop
opt.termguicolors = true
opt.timeoutlen = options.timeoutlen
opt.undofile = options.undofile

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = options.updatetime

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append \"<>[]hl\"

g.mapleader = options.mapleader

-- disable some builtin vim plugins
local disabled_built_ins = {
   \"2html_plugin\",
   \"getscript\",
   \"getscriptPlugin\",
   \"gzip\",
   \"logipat\",
   \"netrw\",
   \"netrwPlugin\",
   \"netrwSettings\",
   \"netrwFileHandlers\",
   \"matchit\",
   \"tar\",
   \"tarPlugin\",
   \"rrhelper\",
   \"spellfile_plugin\",
   \"vimball\",
   \"vimballPlugin\",
   \"zip\",
   \"zipPlugin\",
}

for _, plugin in pairs(disabled_built_ins) do
   g[\"loaded_\" .. plugin] = 1
end
      ";
    };

    ".config/nvim/lua/core/" = {
      text = "
local M = {}

M.close_buffer = function(bufexpr, force)
   -- This is a modification of a NeoVim plugin from
   -- Author: ojroques - Olivier Roques
   -- Src: https://github.com/ojroques/nvim-bufdel
   -- (Author has okayed copy-paste)

   -- Options
   local opts = {
      next = \"cycle\", -- how to retrieve the next buffer
      quit = false, -- exit when last buffer is deleted
      --TODO make this a chadrc flag/option
   }

   -- ----------------
   -- Helper functions
   -- ----------------

   -- Switch to buffer 'buf' on each window from list 'windows'
   local function switch_buffer(windows, buf)
      local cur_win = vim.fn.winnr()
      for _, winid in ipairs(windows) do
         vim.cmd(string.format(\"%d wincmd w\", vim.fn.win_id2win(winid)))
         vim.cmd(string.format(\"buffer %d\", buf))
      end
      vim.cmd(string.format(\"%d wincmd w\", cur_win)) -- return to original window
   end

   -- Select the first buffer with a number greater than given buffer
   local function get_next_buf(buf)
      local next = vim.fn.bufnr \"#\"
      if opts.next == \"alternate\" and vim.fn.buflisted(next) == 1 then
         return next
      end
      for i = 0, vim.fn.bufnr \"$\" - 1 do
         next = (buf + i) % vim.fn.bufnr \"$\" + 1 -- will loop back to 1
         if vim.fn.buflisted(next) == 1 then
            return next
         end
      end
   end

   -- ----------------
   -- End helper functions
   -- ----------------

   local buf = vim.fn.bufnr()
   if vim.fn.buflisted(buf) == 0 then -- exit if buffer number is invalid
      vim.cmd \"close\"
      return
   end

   if #vim.fn.getbufinfo { buflisted = 1 } < 2 then
      if opts.quit then
         -- exit when there is only one buffer left
         if force then
            vim.cmd \"qall!\"
         else
            vim.cmd \"confirm qall\"
         end
         return
      end

      local chad_term, type = pcall(function()
         return vim.api.nvim_buf_get_var(buf, \"term_type\")
      end)

      if chad_term then
         -- Must be a window type
         vim.cmd(string.format(\"setlocal nobl\", buf))
         vim.cmd \"enew\"
         return
      end
      -- don't exit and create a new empty buffer
      vim.cmd \"enew\"
      vim.cmd \"bp\"
   end

   local next_buf = get_next_buf(buf)
   local windows = vim.fn.getbufinfo(buf)[1].windows

   -- force deletion of terminal buffers to avoid the prompt
   if force or vim.fn.getbufvar(buf, \"&buftype\") == \"terminal\" then
      local chad_term, type = pcall(function()
         return vim.api.nvim_buf_get_var(buf, \"term_type\")
      end)

      -- TODO this scope is error prone, make resilient
      if chad_term then
         if type == \"wind\" then
            -- hide from bufferline
            vim.cmd(string.format(\"%d bufdo setlocal nobl\", buf))
            -- swtich to another buff
            -- TODO switch to next bufffer, this works too
            vim.cmd \"BufferLineCycleNext\"
         else
            local cur_win = vim.fn.winnr()
            -- we can close this window
            vim.cmd(string.format(\"%d wincmd c\", cur_win))
            return
         end
      else
         switch_buffer(windows, next_buf)
         vim.cmd(string.format(\"bd! %d\", buf))
      end
   else
      switch_buffer(windows, next_buf)
      vim.cmd(string.format(\"silent! confirm bd %d\", buf))
   end
   -- revert buffer switches if user has canceled deletion
   if vim.fn.buflisted(buf) == 1 then
      switch_buffer(windows, buf)
   end
end

-- hide statusline
-- tables fetched from load_config function
M.hide_statusline = function()
   local hidden = require(\"core.utils\").load_config().plugins.options.statusline.hidden
   local shown = require(\"core.utils\").load_config().plugins.options.statusline.shown
   local api = vim.api
   local buftype = api.nvim_buf_get_option(\"%\", \"ft\")

   -- shown table from config has the highest priority
   if vim.tbl_contains(shown, buftype) then
      api.nvim_set_option(\"laststatus\", 2)
      return
   end

   if vim.tbl_contains(hidden, buftype) then
      api.nvim_set_option(\"laststatus\", 0)
      return
   else
      api.nvim_set_option(\"laststatus\", 2)
   end
end

-- load config
-- 1st arg = boolean - whether to force reload
-- Modifies _G._NVCHAD_CONFIG global variable
M.load_config = function(reload)
   -- only do the stuff below one time, otherwise just return the set config
   if _G._NVCHAD_CONFIG_CONTENTS ~= nil and not (reload or false) then
      return _G._NVCHAD_CONFIG_CONTENTS
   end

   -- these are the table value which will be always prioritiezed to take user config value
   local to_replace = {
      \"['mappings']['plugins']['esc_insertmode']\",
      \"['mappings']['terminal']['esc_termmode']\",
      \"['mappings']['terminal']['esc_hide_termmode']\",
   }

   local default_config = \"core.default_config\"
   local config_name = vim.g.nvchad_user_config or \"chadrc\"
   local config_file = vim.fn.stdpath \"config\" .. \"/lua/custom/\" .. config_name .. \".lua\"

   -- unload the modules if force reload
   if reload then
      package.loaded[default_config or false] = nil
      package.loaded[config_name or false] = nil
   end

   -- don't enclose in pcall, it better break when default config is faulty
   _G._NVCHAD_CONFIG_CONTENTS = require(default_config)

   -- user config is not required to run nvchad but a optional
   -- Make sure the config doesn't break the whole system if user config is not present or in bad state or not a table
   -- print warning texts if user config file is  present
   -- check if the user config is present
   if vim.fn.filereadable(vim.fn.glob(config_file)) == 1 then
      local present, config = pcall(require, \"custom/\" .. config_name)
      if present then
         -- make sure the returned value is table
         if type(config) == \"table\" then
            -- data = require(config_name)
            _G._NVCHAD_CONFIG_CONTENTS = require(\"core.utils\").merge_table(
               _G._NVCHAD_CONFIG_CONTENTS,
               config,
               to_replace
            )
         else
            print(\"Warning: \" .. config_name .. \" sourced successfully but did not return a lua table.\")
         end
      else
         print(\"Warning: \" .. config_file .. \" is present but sourcing failed.\")
      end
   end
   return _G._NVCHAD_CONFIG_CONTENTS
end

M.map = function(mode, keys, cmd, opt)
   local options = { noremap = true, silent = true }
   if opt then
      options = vim.tbl_extend(\"force\", options, opt)
   end

   -- all valid modes allowed for mappings
   -- :h map-modes
   local valid_modes = {
      [\"\"] = true,
      [\"n\"] = true,
      [\"v\"] = true,
      [\"s\"] = true,
      [\"x\"] = true,
      [\"o\"] = true,
      [\"!\"] = true,
      [\"i\"] = true,
      [\"l\"] = true,
      [\"c\"] = true,
      [\"t\"] = true,
   }

   -- helper function for M.map
   -- can gives multiple modes and keys
   local function map_wrapper(mode, lhs, rhs, options)
      if type(lhs) == \"table\" then
         for _, key in ipairs(lhs) do
            map_wrapper(mode, key, rhs, options)
         end
      else
         if type(mode) == \"table\" then
            for _, m in ipairs(mode) do
               map_wrapper(m, lhs, rhs, options)
            end
         else
            if valid_modes[mode] and lhs and rhs then
               vim.api.nvim_set_keymap(mode, lhs, rhs, options)
            else
               mode, lhs, rhs = mode or \"\", lhs or \"\", rhs or \"\"
               print(\"Cannot set mapping [ mode = '\" .. mode .. \"' | key = '\" .. lhs .. \"' | cmd = '\" .. rhs .. \"' ]\")
            end
         end
      end
   end

   map_wrapper(mode, keys, cmd, options)
end

-- Base code: https://gist.github.com/revolucas/184aec7998a6be5d2f61b984fac1d7f7
-- Changes over it: preserving table 1 contents and also update with table b, without duplicating
-- 1st arg - base table
-- 2nd arg - table to merge
-- 3rg arg - list of nodes as a table, if the node is found replace the from table2 to result, rather than adding the value
-- e.g: merge_table(t1, t2, { ['mappings']['plugins']['bufferline'] })
M.merge_table = function(into, from, nodes_to_replace)
   -- make sure both are table
   if type(into) ~= \"table\" or type(from) ~= \"table\" then
      return into
   end

   local stack, seen = {}, {}
   local table1, table2 = into, from

   if type(nodes_to_replace) == \"table\" then
      -- function that will be executed with loadstring
      local replace_fn = function(node)
         local base_fn = [[
return function(table1, table2)
   local t1, t2 = table1_node or false , table2_node or false
   if t1 and t2 then
      table1_node = table2_node
   end
   return table1
end]]

         -- replace the _node in base_fn to actual given node value
         local fn = base_fn:gsub(\"_node\", node)
         -- return the function created from the string base_fn
         return loadstring(fn)()(table1, table2)
      end

      for _, node in ipairs(nodes_to_replace) do
         -- pcall() is a poor workaround for if \"['mappings']['plugins']['esc_insertmode']\" 'plugins' sub-table does not exist
         local ok, result = pcall(replace_fn, node)
         if ok then
            -- if the node is found then replace
            table1 = result
         end
      end
   end

   while true do
      for k, v in pairs(table2) do
         if type(v) == \"table\" and type(table1[k]) == \"table\" then
            table.insert(stack, { table1[k], table2[k] })
         else
            local present = seen[v] or false
            if not present then
               if type(k) == \"number\" then
                  -- add the value to seen table until value is found
                  -- only do when key is number we just want to append to subtables
                  -- todo: maybe improve this

                  for _, value in pairs(table1) do
                     if value == v then
                        present = true
                        break
                     end
                  end
                  seen[v] = true
                  if not present then
                     table1[#table1 + 1] = v
                  end
               else
                  table1[k] = v
               end
            end
         end
      end
      if #stack > 0 then
         local t = stack[#stack]
         table1, table2 = t[1], t[2]
         stack[#stack] = nil
      else
         break
      end
   end
   return into
end

-- load plugin after entering vim ui
M.packer_lazy_load = function(plugin, timer)
   if plugin then
      timer = timer or 0
      vim.defer_fn(function()
         require(\"packer\").loader(plugin)
      end, timer)
   end
end

return M
      ";
    };

    ".config/nvim/lua/custom/chadrc.lua" = {
      text = "
-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'

local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

-- NOTE: To use this, make a copy with `cp example_chadrc.lua chadrc.lua`

--------------------------------------------------------------------

-- To use this file, copy the structure of `core/default_config.lua`,
-- examples of setting relative number & changing theme:

M.options = {
  relativenumber = true,
}

M.ui = {
  theme = \"tokyonight\"
}

-- NvChad included plugin options & overrides
M.plugins = {
   options = {
      --   lspconfig = {
      --    path of file containing setups of different lsps (ex : \"custom.plugins.lspconfig\"), read the docs for more info
      --    setup_lspconf = \"\",
      --   },
   },
   -- To change the Packer `config` of a plugin that comes with NvChad,
   -- add a table entry below matching the plugin github name
   --              '-' -> '_', remove any '.lua', '.nvim' extensions
   -- this string will be called in a `require`
   --              use \"(custom.configs).my_func()\" to call a function
   --              use \"custom.blankline\" to call a file
   default_plugin_config_replace = {},
}

return M
      ";
    };

    ".config/nvim/lua/custom/init.lua" = {
      text = "
-- This is where your custom modules and plugins go.
-- See the wiki for a guide on how to extend NvChad

local hooks = require \"core.hooks\"

-- NOTE: To use this, make a copy with `cp example_init.lua init.lua`

--------------------------------------------------------------------

-- To modify packaged plugin configs, use the overrides functionality
-- if the override does not exist in the plugin config, make or request a PR,
-- or you can override the whole plugin config with 'chadrc' -> M.plugins.default_plugin_config_replace{}
-- this will run your config instead of the NvChad config for the given plugin

-- hooks.override(\"lsp\", \"publish_diagnostics\", function(current)
--   current.virtual_text = false;
--   return current;
-- end)

-- To add new mappings, use the \"setup_mappings\" hook,
-- you can set one or many mappings
-- example below:

-- hooks.add(\"setup_mappings\", function(map)
--    map(\"n\", \"<leader>cc\", \"gg0vG$d\", opt) -- example to delete the buffer
--    .... many more mappings ....
-- end)

-- To add new plugins, use the \"install_plugin\" hook,
-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- examples below:

hooks.add(\"install_plugins\", function(use)
   use {
      \"LnL7/vim-nix\",
       event = \"InsertEnter\",
   }
   use {
      \"folke/tokyonight.nvim\",
   }

end)

-- alternatively, put this in a sub-folder like \"lua/custom/plugins/mkdir\"
-- then source it with

-- require \"custom.plugins.mkdir\"
      ";
    };

    ".config/nvim/lua/plugins/init.lua" = {
      text = "
local present, packer = pcall(require, \"plugins.packerInit\")

if not present then
   return false
end

local use = packer.use

return packer.startup(function()
   local status = require(\"core.utils\").load_config().plugins.status

   -- FUNCTION: override_req, use `chadrc` plugin config override if present
   -- name = name inside `default_config` / `chadrc`
   -- default_req = run this if 'name' does not exist in `default_config` / `chadrc`
   -- if override or default_req start with `(`, then strip that and assume override calls a function, not a whole file
   local override_req = function(name, default_req)
      local override = require(\"core.utils\").load_config().plugins.default_plugin_config_replace[name]
      local result

      if override == nil then
         result = default_req
      else
         result = override
      end

      if string.match(result, \"^%(\") then
         result = result:sub(2)
         result = result:gsub(\"%)%.\", \"').\", 1)
         return \"require('\" .. result
      else
         return \"require('\" .. result .. \"')\"
      end
   end

   -- this is arranged on the basis of when a plugin starts

   -- this is the nvchad core repo containing utilities for some features like theme swticher, no need to lazy load
   use {
      \"Nvchad/extensions\",
   }

   use {
      \"nvim-lua/plenary.nvim\",
   }

   use {
      \"wbthomason/packer.nvim\",
      event = \"VimEnter\",
   }

   use {
      \"NvChad/nvim-base16.lua\",
      after = \"packer.nvim\",
      config = function()
         require(\"colors\").init()
      end,
   }

   use {
      \"kyazdani42/nvim-web-devicons\",
      after = \"nvim-base16.lua\",
      config = override_req(\"nvim_web_devicons\", \"plugins.configs.icons\"),
   }

   use {
      \"famiu/feline.nvim\",
      disable = not status.feline,
      after = \"nvim-web-devicons\",
      config = override_req(\"feline\", \"plugins.configs.statusline\"),
   }

   use {
      \"akinsho/bufferline.nvim\",
      disable = not status.bufferline,
      after = \"nvim-web-devicons\",
      config = override_req(\"bufferline\", \"plugins.configs.bufferline\"),
      setup = function()
         require(\"core.mappings\").bufferline()
      end,
   }

   use {
      \"lukas-reineke/indent-blankline.nvim\",
      disable = not status.blankline,
      event = \"BufRead\",
      config = override_req(\"indent_blankline\", \"(plugins.configs.others).blankline()\"),
   }

   use {
      \"norcalli/nvim-colorizer.lua\",
      disable = not status.colorizer,
      event = \"BufRead\",
      config = override_req(\"nvim_colorizer\", \"(plugins.configs.others).colorizer()\"),
   }

   use {
      \"nvim-treesitter/nvim-treesitter\",
      branch = \"0.5-compat\",
      event = \"BufRead\",
      config = override_req(\"nvim_treesitter\", \"plugins.configs.treesitter\"),
   }

   -- git stuff
   use {
      \"lewis6991/gitsigns.nvim\",
      disable = not status.gitsigns,
      opt = true,
      config = override_req(\"gitsigns\", \"plugins.configs.gitsigns\"),
      setup = function()
         require(\"core.utils\").packer_lazy_load \"gitsigns.nvim\"
      end,
   }

   -- lsp stuff

   use {
      \"neovim/nvim-lspconfig\",
      opt = true,
      setup = function()
         require(\"core.utils\").packer_lazy_load \"nvim-lspconfig\"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == \"packer\" | echo \"\" | else | silent! e %'
         end, 0)
      end,
      config = override_req(\"lspconfig\", \"plugins.configs.lspconfig\"),
   }

   use {
      \"ray-x/lsp_signature.nvim\",
      disable = not status.lspsignature,
      after = \"nvim-lspconfig\",
      config = override_req(\"signature\", \"(plugins.configs.others).signature()\"),
   }

   use {
      \"andymass/vim-matchup\",
      disable = not status.vim_matchup,
      opt = true,
      setup = function()
         require(\"core.utils\").packer_lazy_load \"vim-matchup\"
      end,
   }

   use {
      \"max397574/better-escape.nvim\",
      disable = not status.esc_insertmode,
      event = \"InsertEnter\",
      config = override_req(\"better_escape\", \"(plugins.configs.others).better_escape()\"),
   }

   -- load luasnips + cmp related in insert mode only

   use {
      \"rafamadriz/friendly-snippets\",
      disable = not status.cmp,
      event = \"InsertEnter\",
   }

   use {
      \"hrsh7th/nvim-cmp\",
      disable = not status.cmp,
      after = \"friendly-snippets\",
      config = override_req(\"nvim_cmp\", \"plugins.configs.cmp\"),
   }

   use {
      \"L3MON4D3/LuaSnip\",
      disable = not status.cmp,
      wants = \"friendly-snippets\",
      after = \"nvim-cmp\",
      config = override_req(\"luasnip\", \"(plugins.configs.others).luasnip()\"),
   }

   use {
      \"saadparwaiz1/cmp_luasnip\",
      disable = not status.cmp,
      after = \"LuaSnip\",
   }

   use {
      \"hrsh7th/cmp-nvim-lua\",
      disable = not status.cmp,
      after = \"cmp_luasnip\",
   }

   use {
      \"hrsh7th/cmp-nvim-lsp\",
      disable = not status.cmp,
      after = \"cmp-nvim-lua\",
   }

   use {
      \"hrsh7th/cmp-buffer\",
      disable = not status.cmp,
      after = \"cmp-nvim-lsp\",
   }

   use {
      \"hrsh7th/cmp-path\",
      disable = not status.cmp,
      after = \"cmp-buffer\",
   }
   -- misc plugins
   use {
      \"windwp/nvim-autopairs\",
      disable = not status.autopairs,
      after = \"nvim-cmp\",
      config = override_req(\"nvim_autopairs\", \"(plugins.configs.others).autopairs()\"),
   }

   use {
      \"glepnir/dashboard-nvim\",
      disable = not status.dashboard,
      config = override_req(\"dashboard\", \"plugins.configs.dashboard\"),
      setup = function()
         require(\"core.mappings\").dashboard()
      end,
   }

   use {
      \"terrortylor/nvim-comment\",
      disable = not status.comment,
      cmd = \"CommentToggle\",
      config = override_req(\"nvim_comment\", \"(plugins.configs.others).comment()\"),
      setup = function()
         require(\"core.mappings\").comment()
      end,
   }

   -- file managing , picker etc
   use {
      \"kyazdani42/nvim-tree.lua\",
      disable = not status.nvimtree,
      cmd = { \"NvimTreeToggle\", \"NvimTreeFocus\" },
      config = override_req(\"nvim_tree\", \"plugins.configs.nvimtree\"),
      setup = function()
         require(\"core.mappings\").nvimtree()
      end,
   }

   use {
      \"nvim-telescope/telescope.nvim\",
      module = \"telescope\",
      cmd = \"Telescope\",
      requires = {
         {
            \"nvim-telescope/telescope-fzf-native.nvim\",
            run = \"make\",
         },
         {
            \"nvim-telescope/telescope-media-files.nvim\",
            disable = not status.telescope_media,
            setup = function()
               require(\"core.mappings\").telescope_media()
            end,
         },
      },
      config = override_req(\"telescope\", \"plugins.configs.telescope\"),
      setup = function()
         require(\"core.mappings\").telescope()
      end,
   }

   require(\"core.hooks\").run(\"install_plugins\", use)
end)
      ";
    };

    ".config/nvim/lua/plugins/packerInit.lua" = {
      text = "
local cmd = vim.cmd

cmd \"packadd packer.nvim\"

local present, packer = pcall(require, \"packer\")

if not present then
   local packer_path = vim.fn.stdpath \"data\" .. \"/site/pack/packer/opt/packer.nvim\"

   print \"Cloning packer..\"
   -- remove the dir before cloning
   vim.fn.delete(packer_path, \"rf\")
   vim.fn.system {
      \"git\",
      \"clone\",
      \"https://github.com/wbthomason/packer.nvim\",
      \"--depth\",
      \"20\",
      packer_path,
   }

   cmd \"packadd packer.nvim\"
   present, packer = pcall(require, \"packer\")

end

packer.init {
   display = {
      open_fn = function()
         return require(\"packer.util\").float { border = \"single\" }
      end,
      prompt_border = \"single\",
   },
   git = {
      clone_timeout = 600, -- Timeout, in seconds, for git clones
   },
   auto_clean = true,
   compile_on_sync = true,
   --    auto_reload_compiled = true
}

return packer
      ";
    };

    ".config/nvim/lua/plugins/configs" = {
      text = "
local colors = require(\"colors\").get()

local present, bufferline = pcall(require, \"bufferline\")
if not present then
   return
end

bufferline.setup {
   options = {
      offsets = { { filetype = \"NvimTree\", text = \"\", padding = 1 } },
      buffer_close_icon = \"\",
      modified_icon = \"\",
      -- close_icon = \"%@NvChad_bufferline_quitvim@%X\",
      close_icon = \"\",
      show_close_icon = true,
      left_trunc_marker = \"\",
      right_trunc_marker = \"\",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = \"multiwindow\",
      show_buffer_close_icons = true,
      separator_style = \"thin\",
      always_show_bufferline = true,
      diagnostics = false, -- \"or nvim_lsp\"
      custom_filter = function(buf_number)
         -- Func to filter out our managed/persistent split terms
         local present_type, type = pcall(function()
            return vim.api.nvim_buf_get_var(buf_number, \"term_type\")
         end)

         if present_type then
            if type == \"vert\" then
               return false
            elseif type == \"hori\" then
               return false
            else
               return true
            end
         else
            return true
         end
      end,
   },

   highlights = {
      background = {
         guifg = colors.grey_fg,
         guibg = colors.black2,
      },

      -- buffers
      buffer_selected = {
         guifg = colors.white,
         guibg = colors.black,
         gui = \"bold\",
      },
      buffer_visible = {
         guifg = colors.light_grey,
         guibg = colors.black2,
      },

      -- for diagnostics = \"nvim_lsp\"
      error = {
         guifg = colors.light_grey,
         guibg = colors.black2,
      },
      error_diagnostic = {
         guifg = colors.light_grey,
         guibg = colors.black2,
      },

      -- close buttons
      close_button = {
         guifg = colors.light_grey,
         guibg = colors.black2,
      },
      close_button_visible = {
         guifg = colors.light_grey,
         guibg = colors.black2,
      },
      close_button_selected = {
         guifg = colors.red,
         guibg = colors.black,
      },
      fill = {
         guifg = colors.grey_fg,
         guibg = colors.black2,
      },
      indicator_selected = {
         guifg = colors.black,
         guibg = colors.black,
      },

      -- modified
      modified = {
         guifg = colors.red,
         guibg = colors.black2,
      },
      modified_visible = {
         guifg = colors.red,
         guibg = colors.black2,
      },
      modified_selected = {
         guifg = colors.green,
         guibg = colors.black,
      },

      -- separators
      separator = {
         guifg = colors.black2,
         guibg = colors.black2,
      },
      separator_visible = {
         guifg = colors.black2,
         guibg = colors.black2,
      },
      separator_selected = {
         guifg = colors.black2,
         guibg = colors.black2,
      },
      -- tabs
      tab = {
         guifg = colors.light_grey,
         guibg = colors.one_bg3,
      },
      tab_selected = {
         guifg = colors.black2,
         guibg = colors.nord_blue,
      },
      tab_close = {
         guifg = colors.red,
         guibg = colors.black,
      },
   },
}
      ";
    };

    ".config/nvim/lua/plugins/configs/cmp.lua" = {
      text = "
local present, cmp = pcall(require, \"cmp\")

if not present then
   return
end

vim.opt.completeopt = \"menuone,noselect\"

-- nvim-cmp setup
cmp.setup {
   snippet = {
      expand = function(args)
         require(\"luasnip\").lsp_expand(args.body)
      end,
   },
   formatting = {
      format = function(entry, vim_item)
         -- load lspkind icons
         vim_item.kind = string.format(
            \"%s %s\",
            require(\"plugins.configs.lspkind_icons\").icons[vim_item.kind],
            vim_item.kind
         )

         vim_item.menu = ({
            nvim_lsp = \"[LSP]\",
            nvim_lua = \"[Lua]\",
            buffer = \"[BUF]\",
         })[entry.source.name]

         return vim_item
      end,
   },
   mapping = {
      [\"<C-p>\"] = cmp.mapping.select_prev_item(),
      [\"<C-n>\"] = cmp.mapping.select_next_item(),
      [\"<C-d>\"] = cmp.mapping.scroll_docs(-4),
      [\"<C-f>\"] = cmp.mapping.scroll_docs(4),
      [\"<C-Space>\"] = cmp.mapping.complete(),
      [\"<C-e>\"] = cmp.mapping.close(),
      [\"<CR>\"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      [\"<Tab>\"] = function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif require(\"luasnip\").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes(\"<Plug>luasnip-expand-or-jump\", true, true, true), \"\")
         else
            fallback()
         end
      end,
      [\"<S-Tab>\"] = function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif require(\"luasnip\").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes(\"<Plug>luasnip-jump-prev\", true, true, true), \"\")
         else
            fallback()
         end
      end,
   },
   sources = {
      { name = \"nvim_lsp\" },
      { name = \"luasnip\" },
      { name = \"buffer\" },
      { name = \"nvim_lua\" },
      { name = \"path\" },
   },
}
      ";
    };

    ".config/nvim/lua/plugins/configs/dashboard.lua" = {
      text = "
local g = vim.g

g.dashboard_disable_at_vimenter = 0
g.dashboard_disable_statusline = 1
g.dashboard_default_executive = \"telescope\"
g.dashboard_custom_header = {
   \"                                   \",
   \"                                   \",
   \"                                   \",
   \"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          \",
   \"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       \",
   \"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     \",
   \"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    \",
   \"          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   \",
   \"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  \",
   \"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   \",
   \" ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  \",
   \" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ \",
   \"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     \",
   \"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     \",
   \"                                   \",
}

g.dashboard_custom_section = {
   a = { description = { \"  Find File                 SPC f f\" }, command = \"Telescope find_files\" },
   b = { description = { \"  Recents                   SPC f o\" }, command = \"Telescope oldfiles\" },
   c = { description = { \"  Find Word                 SPC f w\" }, command = \"Telescope live_grep\" },
   d = { description = { \"洛 New File                  SPC f n\" }, command = \"DashboardNewFile\" },
   e = { description = { \"  Bookmarks                 SPC b m\" }, command = \"Telescope marks\" },
   f = { description = { \"  Load Last Session         SPC l  \" }, command = \"SessionLoad\" },
}

g.dashboard_custom_footer = {
   \"   \",
}
      ";
    };

    ".config/nvim/lua/plugins/configs/gitsigns.lua" = {
      text = "
local present, gitsigns = pcall(require, \"gitsigns\")
if not present then
   return
end

gitsigns.setup {
   keymaps = {
      -- Default keymap options
      buffer = true,
      noremap = true,
      [\"n ]c\"] = { expr = true, \"&diff ? ']c' : '<cmd>lua require\\\"gitsigns\\\".next_hunk()<CR>'\" },
      [\"n [c\"] = { expr = true, \"&diff ? '[c' : '<cmd>lua require\\\"gitsigns\\\".prev_hunk()<CR>'\" },
      [\"n <leader>hs\"] = '<cmd>lua require\"gitsigns\".stage_hunk()<CR>',
      [\"n <leader>hu\"] = '<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>',
      [\"n <leader>hr\"] = '<cmd>lua require\"gitsigns\".reset_hunk()<CR>',
      [\"n <leader>hp\"] = '<cmd>lua require\"gitsigns\".preview_hunk()<CR>',
      [\"n <leader>hb\"] = '<cmd>lua require\"gitsigns\".blame_line()<CR>',
   },
   numhl = false,

   sign_priority = 5,
   signs = {
      add = { hl = \"DiffAdd\", text = \"│\", numhl = \"GitSignsAddNr\" },
      change = { hl = \"DiffChange\", text = \"│\", numhl = \"GitSignsChangeNr\" },
      changedelete = { hl = \"DiffChange\", text = \"~\", numhl = \"GitSignsChangeNr\" },
      delete = { hl = \"DiffDelete\", text = \"_\", numhl = \"GitSignsDeleteNr\" },
      topdelete = { hl = \"DiffDelete\", text = \"‾\", numhl = \"GitSignsDeleteNr\" },
   },

   status_formatter = nil, -- Use default
   watch_gitdir = {
      interval = 100,
   },
}
      ";
    };

    ".config/nvim/lua/plugins/configs/icons.lua" = {
      text = "
local present, icons = pcall(require, \"nvim-web-devicons\")
if not present then
   return
end

local colors = require(\"colors\").get()

icons.setup {
   override = {
      c = {
         icon = \"\",
         color = colors.blue,
         name = \"c\",
      },
      css = {
         icon = \"\",
         color = colors.blue,
         name = \"css\",
      },
      deb = {
         icon = \"\",
         color = colors.cyan,
         name = \"deb\",
      },
      Dockerfile = {
         icon = \"\",
         color = colors.cyan,
         name = \"Dockerfile\",
      },
      html = {
         icon = \"\",
         color = colors.baby_pink,
         name = \"html\",
      },
      jpeg = {
         icon = \"\",
         color = colors.dark_purple,
         name = \"jpeg\",
      },
      jpg = {
         icon = \"\",
         color = colors.dark_purple,
         name = \"jpg\",
      },
      js = {
         icon = \"\",
         color = colors.sun,
         name = \"js\",
      },
      kt = {
         icon = \"󱈙\",
         color = colors.orange,
         name = \"kt\",
      },
      lock = {
         icon = \"\",
         color = colors.red,
         name = \"lock\",
      },
      lua = {
         icon = \"\",
         color = colors.blue,
         name = \"lua\",
      },
      mp3 = {
         icon = \"\",
         color = colors.white,
         name = \"mp3\",
      },
      mp4 = {
         icon = \"\",
         color = colors.white,
         name = \"mp4\",
      },
      out = {
         icon = \"\",
         color = colors.white,
         name = \"out\",
      },
      png = {
         icon = \"\",
         color = colors.dark_purple,
         name = \"png\",
      },
      py = {
         icon = \"\",
         color = colors.cyan,
         name = \"py\",
      },
      [\"robots.txt\"] = {
         icon = \"ﮧ\",
         color = colors.red,
         name = \"robots\",
      },
      toml = {
         icon = \"\",
         color = colors.blue,
         name = \"toml\",
      },
      ts = {
         icon = \"ﯤ\",
         color = colors.teal,
         name = \"ts\",
      },
      ttf = {
         icon = \"\",
         color = colors.white,
         name = \"TrueTypeFont\",
      },
      rb = {
         icon = \"\",
         color = colors.pink,
         name = \"rb\",
      },
      rpm = {
         icon = \"\",
         color = colors.orange,
         name = \"rpm\",
      },
      vue = {
         icon = \"﵂\",
         color = colors.vibrant_green,
         name = \"vue\",
      },
      woff = {
         icon = \"\",
         color = colors.white,
         name = \"WebOpenFontFormat\",
      },
      woff2 = {
         icon = \"\",
         color = colors.white,
         name = \"WebOpenFontFormat2\",
      },
      xz = {
         icon = \"\",
         color = colors.sun,
         name = \"xz\",
      },
      zip = {
         icon = \"\",
         color = colors.sun,
         name = \"zip\",
      },
   },
}

      ";
    };

    ".config/nvim/lua/plugins/configs/lspconfig.lua" = {
      text = "
local overrides = require(\"core.hooks\").createOverrides \"lsp\"

local function on_attach(_, bufnr)
   local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end
   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

   -- Enable completion triggered by <c-x><c-o>
   buf_set_option(\"omnifunc\", \"v:lua.vim.lsp.omnifunc\")

   -- Mappings.
   local opts = { noremap = true, silent = true }

   -- See `:help vim.lsp.*` for documentation on any of the below functions
   buf_set_keymap(\"n\", \"gD\", \"<cmd>lua vim.lsp.buf.declaration()<CR>\", opts)
   buf_set_keymap(\"n\", \"gd\", \"<cmd>lua vim.lsp.buf.definition()<CR>\", opts)
   buf_set_keymap(\"n\", \"K\", \"<cmd>lua vim.lsp.buf.hover()<CR>\", opts)
   buf_set_keymap(\"n\", \"gi\", \"<cmd>lua vim.lsp.buf.implementation()<CR>\", opts)
   buf_set_keymap(\"n\", \"gk\", \"<cmd>lua vim.lsp.buf.signature_help()<CR>\", opts)
   buf_set_keymap(\"n\", \"<space>wa\", \"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>\", opts)
   buf_set_keymap(\"n\", \"<space>wr\", \"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>\", opts)
   buf_set_keymap(\"n\", \"<space>wl\", \"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>\", opts)
   buf_set_keymap(\"n\", \"<space>D\", \"<cmd>lua vim.lsp.buf.type_definition()<CR>\", opts)
   buf_set_keymap(\"n\", \"<space>rn\", \"<cmd>lua vim.lsp.buf.rename()<CR>\", opts)
   buf_set_keymap(\"n\", \"<space>ca\", \"<cmd>lua vim.lsp.buf.code_action()<CR>\", opts)
   buf_set_keymap(\"n\", \"gr\", \"<cmd>lua vim.lsp.buf.references()<CR>\", opts)
   buf_set_keymap(\"n\", \"ge\", \"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>\", opts)
   buf_set_keymap(\"n\", \"[d\", \"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\", opts)
   buf_set_keymap(\"n\", \"]d\", \"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>\", opts)
   buf_set_keymap(\"n\", \"<space>q\", \"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\", opts)
   buf_set_keymap(\"n\", \"<space>fm\", \"<cmd>lua vim.lsp.buf.formatting()<CR>\", opts)
   buf_set_keymap(\"v\", \"<space>ca\", \"<cmd>lua vim.lsp.buf.range_code_action()<CR>\", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { \"markdown\", \"plaintext\" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      \"documentation\",
      \"detail\",
      \"additionalTextEdits\",
   },
}

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
   vim.fn.sign_define(\"LspDiagnosticsSign\" .. name, { text = icon, numhl = \"LspDiagnosticsDefault\" .. name })
end

lspSymbol(\"Error\", \"\")
lspSymbol(\"Information\", \"\")
lspSymbol(\"Hint\", \"\")
lspSymbol(\"Warning\", \"\")

local lsp_publish_diagnostics_options = overrides.get(\"publish_diagnostics\", {
   virtual_text = {
      prefix = \"\",
      spacing = 0,
   },
   signs = true,
   underline = true,
   update_in_insert = false, -- update diagnostics insert mode
})
vim.lsp.handlers[\"textDocument/publishDiagnostics\"] = vim.lsp.with(
   vim.lsp.diagnostic.on_publish_diagnostics,
   lsp_publish_diagnostics_options
)
vim.lsp.handlers[\"textDocument/hover\"] = vim.lsp.with(vim.lsp.handlers.hover, {
   border = \"single\",
})
vim.lsp.handlers[\"textDocument/signatureHelp\"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
   border = \"single\",
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
   if msg:match \"exit code\" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end

-- requires a file containing user's lspconfigs

local addlsp_confs = require(\"core.utils\").load_config().plugins.options.lspconfig.setup_lspconf

if string.len(addlsp_confs) ~= 0 then
   require(addlsp_confs).setup_lsp(on_attach, capabilities)
end
      ";
    };

    ".config/nvim/lua/plugins/configs/lspkind_icons.lua" = {
      text = "
local M = {}

M.icons = {
   Text = \"\",
   Method = \"\",
   Function = \"\",
   Constructor = \"\",
   Field = \"ﰠ\",
   Variable = \"\",
   Class = \"ﴯ\",
   Interface = \"\",
   Module = \"\",
   Property = \"ﰠ\",
   Unit = \"塞\",
   Value = \"\",
   Enum = \"\",
   Keyword = \"\",
   Snippet = \"\",
   Color = \"\",
   File = \"\",
   Reference = \"\",
   Folder = \"\",
   EnumMember = \"\",
   Constant = \"\",
   Struct = \"פּ\",
   Event = \"\",
   Operator = \"\",
   TypeParameter = \"\",
}

return M
      ";
    };

    ".config/nvim/lua/plugins/configs/nvimtree.lua" = {
      text = "
local present, nvimtree = pcall(require, \"nvim-tree\")
local git_status = require(\"core.utils\").load_config().plugins.options.nvimtree.enable_git

if not present then
   return
end

local g = vim.g

vim.o.termguicolors = true

g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = git_status
g.nvim_tree_gitignore = 0
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_ignore = { \".git\", \"node_modules\", \".cache\" }
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat { \":t:gs?$?/..\", string.rep(\" \", 1000), \"?:gs?^??\" }
--
g.nvim_tree_show_icons = {
   folders = 1,
   -- folder_arrows= 1
   files = 1,
   git = git_status,
}

g.nvim_tree_icons = {
   default = \"\",
   symlink = \"\",
   git = {
      deleted = \"\",
      ignored = \"◌\",
      renamed = \"➜\",
      staged = \"✓\",
      unmerged = \"\",
      unstaged = \"✗\",
      untracked = \"★\",
   },
   folder = {
      -- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
      -- arrow_open = \"\",
      -- arrow_closed = \"\",
      default = \"\",
      empty = \"\", -- 
      empty_open = \"\",
      open = \"\",
      symlink = \"\",
      symlink_open = \"\",
   },
}

nvimtree.setup {
   diagnostics = {
      enable = false,
      icons = {
         hint = \"\",
         info = \"\",
         warning = \"\",
         error = \"\",
      },
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { \"dashboard\" },
   auto_close = false,
   open_on_tab = false,
   hijack_cursor = true,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
   },
   view = {
      allow_resize = true,
      side = \"left\",
      width = 25,
   },
}
      ";
    };

    ".config/nvim/lua/plugins/configs/others.lua" = {
      text = "
local M = {}

local chadrc_config = require(\"core.utils\").load_config()
M.autopairs = function()
   local present1, autopairs = pcall(require, \"nvim-autopairs\")
   local present2, autopairs_completion = pcall(require, \"nvim-autopairs.completion.cmp\")

   if not (present1 or present2) then
      return
   end

   autopairs.setup()

   -- not needed if you disable cmp, the above var related to cmp tooo! override default config for autopairs

   autopairs_completion.setup {
      map_complete = true, -- insert () func completion
      map_cr = true,
   }
end

M.better_escape = function()
   require(\"better_escape\").setup {
      mapping = chadrc_config.mappings.plugins.better_escape.esc_insertmode,
      timeout = chadrc_config.plugins.options.esc_insertmode_timeout,
   }
end

M.blankline = function()
   require(\"indent_blankline\").setup {
      indentLine_enabled = 1,
      char = \"▏\",
      filetype_exclude = {
         \"help\",
         \"terminal\",
         \"dashboard\",
         \"packer\",
         \"lspinfo\",
         \"TelescopePrompt\",
         \"TelescopeResults\",
      },
      buftype_exclude = { \"terminal\" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
   }
end

M.colorizer = function()
   local present, colorizer = pcall(require, \"colorizer\")
   if present then
      colorizer.setup({ \"*\" }, {
         RGB = true, -- #RGB hex codes
         RRGGBB = true, -- #RRGGBB hex codes
         names = false, -- \"Name\" codes like Blue
         RRGGBBAA = false, -- #RRGGBBAA hex codes
         rgb_fn = false, -- CSS rgb() and rgba() functions
         hsl_fn = false, -- CSS hsl() and hsla() functions
         css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
         css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

         -- Available modes: foreground, background
         mode = \"background\", -- Set the display mode.
      })
      vim.cmd \"ColorizerReloadAllBuffers\"
   end
end

M.comment = function()
   local present, nvim_comment = pcall(require, \"nvim_comment\")
   if present then
      nvim_comment.setup()
   end
end

M.luasnip = function()
   local present, luasnip = pcall(require, \"luasnip\")
   if not present then
      return
   end

   luasnip.config.set_config {
      history = true,
      updateevents = \"TextChanged,TextChangedI\",
   }
   require(\"luasnip/loaders/from_vscode\").load { path = { chadrc_config.plugins.options.luasnip.snippet_path } }
end

M.signature = function()
   local present, lspsignature = pcall(require, \"lsp_signature\")
   if present then
      lspsignature.setup {
         bind = true,
         doc_lines = 0,
         floating_window = true,
         fix_pos = true,
         hint_enable = true,
         hint_prefix = \" \",
         hint_scheme = \"String\",
         hi_parameter = \"Search\",
         max_height = 22,
         max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
         handler_opts = {
            border = \"single\", -- double, single, shadow, none
         },
         zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
         padding = \"\", -- character to pad on left and right of signature can be ' ', or '|'  etc
      }
   end
end

return M
      ";
    };

    ".config/nvim/lua/plugins/configs/statusline.lua" = {
      text = "
local colors = require(\"colors\").get()
local lsp = require \"feline.providers.lsp\"

local icon_styles = {
   default = {
      left = \"\",
      right = \" \",
      main_icon = \"  \",
      vi_mode_icon = \" \",
      position_icon = \" \",
   },
   arrow = {
      left = \"\",
      right = \"\",
      main_icon = \"  \",
      vi_mode_icon = \" \",
      position_icon = \" \",
   },

   block = {
      left = \" \",
      right = \" \",
      main_icon = \"   \",
      vi_mode_icon = \"  \",
      position_icon = \"  \",
   },

   round = {
      left = \"\",
      right = \"\",
      main_icon = \"  \",
      vi_mode_icon = \" \",
      position_icon = \" \",
   },

   slant = {
      left = \" \",
      right = \" \",
      main_icon = \"  \",
      vi_mode_icon = \" \",
      position_icon = \" \",
   },
}

local config = require(\"core.utils\").load_config().plugins.options.statusline
-- statusline style
local user_statusline_style = config.style
local statusline_style = icon_styles[user_statusline_style]
-- if show short statusline on small screens
local shortline = config.shortline == false and true

-- Initialize the components table
local components = {
   active = {},
   inactive = {},
}

-- Initialize left, mid and right
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

components.active[1][1] = {
   provider = statusline_style.main_icon,

   hl = {
      fg = colors.statusline_bg,
      bg = colors.nord_blue,
   },

   right_sep = { str = statusline_style.right, hl = {
      fg = colors.nord_blue,
      bg = colors.lightbg,
   } },
}

components.active[1][2] = {
   provider = function()
      local filename = vim.fn.expand \"%:t\"
      local extension = vim.fn.expand \"%:e\"
      local icon = require(\"nvim-web-devicons\").get_icon(filename, extension)
      if icon == nil then
         icon = \" \"
         return icon
      end
      return \" \" .. icon .. \" \" .. filename .. \" \"
   end,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 70
   end,
   hl = {
      fg = colors.white,
      bg = colors.lightbg,
   },

   right_sep = { str = statusline_style.right, hl = { fg = colors.lightbg, bg = colors.lightbg2 } },
}

components.active[1][3] = {
   provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), \":t\")
      return \"  \" .. dir_name .. \" \"
   end,

   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 80
   end,

   hl = {
      fg = colors.grey_fg2,
      bg = colors.lightbg2,
   },
   right_sep = {
      str = statusline_style.right,
      hi = {
         fg = colors.lightbg2,
         bg = colors.statusline_bg,
      },
   },
}

components.active[1][4] = {
   provider = \"git_diff_added\",
   hl = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg,
   },
   icon = \" \",
}
-- diffModfified
components.active[1][5] = {
   provider = \"git_diff_changed\",
   hl = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg,
   },
   icon = \"   \",
}
-- diffRemove
components.active[1][6] = {
   provider = \"git_diff_removed\",
   hl = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg,
   },
   icon = \"  \",
}

components.active[1][7] = {
   provider = \"diagnostic_errors\",
   enabled = function()
      return lsp.diagnostics_exist \"Error\"
   end,

   hl = { fg = colors.red },
   icon = \"  \",
}

components.active[1][8] = {
   provider = \"diagnostic_warnings\",
   enabled = function()
      return lsp.diagnostics_exist \"Warning\"
   end,
   hl = { fg = colors.yellow },
   icon = \"  \",
}

components.active[1][9] = {
   provider = \"diagnostic_hints\",
   enabled = function()
      return lsp.diagnostics_exist \"Hint\"
   end,
   hl = { fg = colors.grey_fg2 },
   icon = \"  \",
}

components.active[1][10] = {
   provider = \"diagnostic_info\",
   enabled = function()
      return lsp.diagnostics_exist \"Information\"
   end,
   hl = { fg = colors.green },
   icon = \"  \",
}

components.active[2][1] = {
   provider = function()
      local Lsp = vim.lsp.util.get_progress_messages()[1]
      if Lsp then
         local msg = Lsp.message or \"\"
         local percentage = Lsp.percentage or 0
         local title = Lsp.title or \"\"
         local spinners = {
            \"\",
            \"\",
            \"\",
         }

         local success_icon = {
            \"\",
            \"\",
            \"\",
         }

         local ms = vim.loop.hrtime() / 1000000
         local frame = math.floor(ms / 120) % #spinners

         if percentage >= 70 then
            return string.format(\" %%<%s %s %s (%s%%%%) \", success_icon[frame + 1], title, msg, percentage)
         else
            return string.format(\" %%<%s %s %s (%s%%%%) \", spinners[frame + 1], title, msg, percentage)
         end
      end
      return \"\"
   end,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 80
   end,
   hl = { fg = colors.green },
}

components.active[3][1] = {
   provider = function()
      if next(vim.lsp.buf_get_clients()) ~= nil then
         return \"  LSP\"
      else
         return \"\"
      end
   end,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 70
   end,
   hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
}

components.active[3][2] = {
   provider = \"git_branch\",
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 70
   end,
   hl = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg,
   },
   icon = \"  \",
}

components.active[3][3] = {
   provider = \" \" .. statusline_style.left,
   hl = {
      fg = colors.one_bg2,
      bg = colors.statusline_bg,
   },
}

local mode_colors = {
   [\"n\"] = { \"NORMAL\", colors.red },
   [\"no\"] = { \"N-PENDING\", colors.red },
   [\"i\"] = { \"INSERT\", colors.dark_purple },
   [\"ic\"] = { \"INSERT\", colors.dark_purple },
   [\"t\"] = { \"TERMINAL\", colors.green },
   [\"v\"] = { \"VISUAL\", colors.cyan },
   [\"V\"] = { \"V-LINE\", colors.cyan },
   [\"\"] = { \"V-BLOCK\", colors.cyan },
   [\"R\"] = { \"REPLACE\", colors.orange },
   [\"Rv\"] = { \"V-REPLACE\", colors.orange },
   [\"s\"] = { \"SELECT\", colors.nord_blue },
   [\"S\"] = { \"S-LINE\", colors.nord_blue },
   [\"\"] = { \"S-BLOCK\", colors.nord_blue },
   [\"c\"] = { \"COMMAND\", colors.pink },
   [\"cv\"] = { \"COMMAND\", colors.pink },
   [\"ce\"] = { \"COMMAND\", colors.pink },
   [\"r\"] = { \"PROMPT\", colors.teal },
   [\"rm\"] = { \"MORE\", colors.teal },
   [\"r?\"] = { \"CONFIRM\", colors.teal },
   [\"!\"] = { \"SHELL\", colors.green },
}

local chad_mode_hl = function()
   return {
      fg = mode_colors[vim.fn.mode()][2],
      bg = colors.one_bg,
   }
end

components.active[3][4] = {
   provider = statusline_style.left,
   hl = function()
      return {
         fg = mode_colors[vim.fn.mode()][2],
         bg = colors.one_bg2,
      }
   end,
}

components.active[3][5] = {
   provider = statusline_style.vi_mode_icon,
   hl = function()
      return {
         fg = colors.statusline_bg,
         bg = mode_colors[vim.fn.mode()][2],
      }
   end,
}

components.active[3][6] = {
   provider = function()
      return \" \" .. mode_colors[vim.fn.mode()][1] .. \" \"
   end,
   hl = chad_mode_hl,
}

components.active[3][7] = {
   provider = statusline_style.left,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
   end,
   hl = {
      fg = colors.grey,
      bg = colors.one_bg,
   },
}

components.active[3][8] = {
   provider = statusline_style.left,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
   end,
   hl = {
      fg = colors.green,
      bg = colors.grey,
   },
}

components.active[3][9] = {
   provider = statusline_style.position_icon,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
   end,
   hl = {
      fg = colors.black,
      bg = colors.green,
   },
}

components.active[3][10] = {
   provider = function()
      local current_line = vim.fn.line \".\"
      local total_line = vim.fn.line \"$\"

      if current_line == 1 then
         return \" Top \"
      elseif current_line == vim.fn.line \"$\" then
         return \" Bot \"
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return \" \" .. result .. \"%% \"
   end,

   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
   end,

   hl = {
      fg = colors.green,
      bg = colors.one_bg,
   },
}

require(\"feline\").setup {
   colors = {
      bg = colors.statusline_bg,
      fg = colors.fg,
   },
   components = components,
}
      ";
    };

    ".config/nvim/lua/plugins/configs/telescope.lua" = {
      text = "
local present, telescope = pcall(require, \"telescope\")
if not present then
   return
end

telescope.setup {
   defaults = {
      vimgrep_arguments = {
         \"rg\",
         \"--color=never\",
         \"--no-heading\",
         \"--with-filename\",
         \"--line-number\",
         \"--column\",
         \"--smart-case\",
      },
      prompt_prefix = \"   \",
      selection_caret = \"  \",
      entry_prefix = \"  \",
      initial_mode = \"insert\",
      selection_strategy = \"reset\",
      sorting_strategy = \"ascending\",
      layout_strategy = \"horizontal\",
      layout_config = {
         horizontal = {
            prompt_position = \"top\",
            preview_width = 0.55,
            results_width = 0.8,
         },
         vertical = {
            mirror = false,
         },
         width = 0.87,
         height = 0.80,
         preview_cutoff = 120,
      },
      file_sorter = require(\"telescope.sorters\").get_fuzzy_file,
      file_ignore_patterns = { \"node_modules\" },
      generic_sorter = require(\"telescope.sorters\").get_generic_fuzzy_sorter,
      path_display = { \"absolute\" },
      winblend = 0,
      border = {},
      borderchars = { \"─\", \"│\", \"─\", \"│\", \"╭\", \"╮\", \"╯\", \"╰\" },
      color_devicons = true,
      use_less = true,
      set_env = { [\"COLORTERM\"] = \"truecolor\" }, -- default = nil,
      file_previewer = require(\"telescope.previewers\").vim_buffer_cat.new,
      grep_previewer = require(\"telescope.previewers\").vim_buffer_vimgrep.new,
      qflist_previewer = require(\"telescope.previewers\").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require(\"telescope.previewers\").buffer_previewer_maker,
   },
   extensions = {
      fzf = {
         fuzzy = true, -- false will only do exact matching
         override_generic_sorter = false, -- override the generic sorter
         override_file_sorter = true, -- override the file sorter
         case_mode = \"smart_case\", -- or \"ignore_case\" or \"respect_case\"
         -- the default case_mode is \"smart_case\"
      },
      media_files = {
         filetypes = { \"png\", \"webp\", \"jpg\", \"jpeg\" },
         find_cmd = \"rg\", -- find command (defaults to `fd`)
      },
   },
}

local extensions = { \"themes\", \"terms\", \"fzf\" }
local packer_repos = [[\"extensions\", \"telescope-fzf-native.nvim\"]]

if vim.fn.executable \"ueberzug\" == 1 then
   table.insert(extensions, \"media_files\")
   packer_repos = packer_repos .. ', \"telescope-media-files.nvim\"'
end

pcall(function()
   for _, ext in ipairs(extensions) do
      telescope.load_extension(ext)
   end
end)
      ";
    };

    ".config/nvim/lua/plugins/configs/treesitter.lua" = {
      text = "
local present, ts_config = pcall(require, \"nvim-treesitter.configs\")
if not present then
   return
end

ts_config.setup {
   ensure_installed = {
      \"maintained\",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
}
      ";
    };
  };
}
