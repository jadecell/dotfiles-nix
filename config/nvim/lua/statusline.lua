local colors = {
  none = "NONE",
  bg_dark = "#1f2335",
  bg = "#1f2335",
  bg_highlight = "#292e42",
  terminal_black = "#414868",
  fg = "#c0caf5",
  fg_dark = "#a9b1d6",
  fg_gutter = "#3b4261",
  dark3 = "#545c7e",
  comment = "#565f89",
  dark5 = "#737aa2",
  blue0 = "#3d59a1",
  blue = "#7aa2f7",
  cyan = "#7dcfff",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#B4F9F8",
  blue7 = "#394b70",
  magenta = "#bb9af7",
  magenta2 = "#ff007c",
  purple = "#9d7cd8",
  orange = "#ff9e64",
  yellow = "#e0af68",
  green = "#9ece6a",
  green1 = "#73daca",
  green2 = "#41a6b5",
  teal = "#1abc9c",
  red = "#f7768e",
  red1 = "#db4b4b",
  git = { change = "#6183bb", add = "#449dab", delete = "#914c54", conflict = "#bb7a61" },
  gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
}

if not pcall(require, "feline") then
  return
end

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = ' '
    elseif os == 'MAC' then
        icon = ' '
    else
        icon = ' '
    end
    return icon .. os
end

local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

local lsp_get_diag = function(str)
  local count = vim.lsp.diagnostic.get_count(0, str)
  return (count > 0) and ' '..count..' ' or ''
end

-- LuaFormatter off

local comps = {
    vi_mode = {
        left = {
            provider = function()
              return '  ' .. vi_mode_utils.get_vim_mode()
            end,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color(),
                    -- fg = colors.bg
                }
                return val
            end,
            right_sep = ' '
        },
        right = {
            -- provider = '▊',
            provider = '' ,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color()
                }
                return val
            end,
            left_sep = ' ',
            right_sep = ' '
        }
    },
    file = {
        info = {
            provider = {
              name = 'file_info',
              opts = {
                file_readonly_icon = '  ',
                -- file_readonly_icon = '  ',
                -- file_readonly_icon = '  ',
                -- file_readonly_icon = '  ',
                -- file_modified_icon = '',
                file_modified_icon = '',
                -- file_modified_icon = 'ﱐ',
                -- file_modified_icon = '',
                -- file_modified_icon = '',
                -- file_modified_icon = '',
              }
            },
            hl = {
                fg = colors.blue,
                style = 'bold'
            }
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        type = {
            provider = 'file_type'
        },
        os = {
            provider = file_osinfo,
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        position = {
            provider = 'position',
            left_sep = ' ',
            hl = {
                fg = colors.cyan,
                -- style = 'bold'
            }
        },
    },
    left_end = {
        provider = function() return '' end,
        hl = {
            fg = colors.bg,
            bg = colors.blue,
        }
    },
    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold'
        }
    },
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = {
            fg = colors.blue,
            style = 'bold'
        }
    },
    diagnos = {
        err = {
            -- provider = 'diagnostic_errors',
            provider = function()
                return '' .. lsp_get_diag("Error")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Error') end,
            hl = {
                fg = colors.red
            }
        },
        warn = {
            -- provider = 'diagnostic_warnings',
            provider = function()
                return '' ..  lsp_get_diag("Warning")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Warning') end,
            hl = {
                fg = colors.yellow
            }
        },
        info = {
            -- provider = 'diagnostic_info',
            provider = function()
                return '' .. lsp_get_diag("Information")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Information') end,
            hl = {
                fg = colors.blue
            }
        },
        hint = {
            -- provider = 'diagnostic_hints',
            provider = function()
                return '' .. lsp_get_diag("Hint")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Hint') end,
            hl = {
                fg = colors.cyan
            }
        },
    },
    lsp = {
        name = {
            provider = 'lsp_client_names',
            -- left_sep = ' ',
            right_sep = ' ',
            -- icon = '  ',
            icon = '慎',
            hl = {
                fg = colors.yellow
            }
        }
    },
    git = {
        branch = {
            provider = 'git_branch',
            icon = ' ',
            -- icon = ' ',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            },
        },
        add = {
            provider = 'git_diff_added',
            hl = {
                fg = colors.green
            }
        },
        change = {
            provider = 'git_diff_changed',
            hl = {
                fg = colors.orange
            }
        },
        remove = {
            provider = 'git_diff_removed',
            hl = {
                fg = colors.red
            }
        }
    }
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.inactive[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info)
table.insert(components.active[3], comps.diagnos.err)
table.insert(components.active[3], comps.diagnos.warn)
table.insert(components.active[3], comps.diagnos.hint)
table.insert(components.active[3], comps.diagnos.info)
table.insert(components.active[3], comps.lsp.name)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.scroll_bar)

-- TreeSitter
-- local ts_utils = require("nvim-treesitter.ts_utils")
-- local ts_parsers = require("nvim-treesitter.parsers")
-- local ts_queries = require("nvim-treesitter.query")
--[[ table.insert(components.active[2], {
  provider = function()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    return ("%d:%s [%d, %d] - [%d, %d]")
      :format(node:symbol(), node:type(), node:range())
  end,
  enabled = function()
    local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
    return ok and ts_parsers.has_parser()
  end
}) ]]

-- require'feline'.setup {}
require'feline'.setup {
    colors = { bg = colors.bg, fg = colors.fg },
    components = components,
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
        filetypes = {
            'packer',
            'NvimTree',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = {'terminal'},
        bufnames = {}
    }
}
