 -- This file configures galaxyline, a fast and small statusline for nvim.
 -- The configuration was taken from github.com/siduck76/neovim-dotfiles/
 -- All I did was change the colors. Full credit goes to siduck76

local gl = require("galaxyline")
    local gls = gl.section

    gl.short_line_list = {" "} -- keeping this table { } as empty will show inactive statuslines

    local colors = {
        bg_dark = "#1f2335",
        bg = "#24283b",
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
    }

    gls.left[1] = {
        leftRounded = {
            provider = function()
                return " "
            end,
            highlight = {colors.fg, colors.bg}
        }
    }

    gls.left[2] = {
        statusIcon = {
            provider = function()
                return "  "
            end,
            highlight = {colors.fg, colors.bg},
            separator = " ",
            separator_highlight = {colors.lightbg, colors.bg}
        }
    }

    gls.left[3] = {
        FileIcon = {
            provider = "FileIcon",
            condition = buffer_not_empty,
            highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg}
        }
    }

    gls.left[4] = {
        FileName = {
            provider = {"FileName", "FileSize"},
            condition = buffer_not_empty,
            highlight = {colors.fg, colors.bg}
        }
    }

    local checkwidth = function()
        local squeeze_width = vim.fn.winwidth(0) / 2
        if squeeze_width > 40 then
            return true
        end
        return false
    end

    gls.left[5] = {
        DiffAdd = {
            provider = "DiffAdd",
            condition = checkwidth,
            icon = "   ",
            highlight = {colors.green, colors.bg}
        }
    }

    gls.left[6] = {
        DiffModified = {
            provider = "DiffModified",
            condition = checkwidth,
            icon = " ",
            highlight = {colors.orange, colors.bg}
        }
    }

    gls.left[7] = {
        DiffRemove = {
            provider = "DiffRemove",
            condition = checkwidth,
            icon = " ",
            highlight = {colors.red, colors.bg}
        }
    }

    gls.left[8] = {
        LeftEnd = {
            provider = function()
                return " "
            end,
            separator = " ",
            separator_highlight = {colors.bg, colors.bg},
            highlight = {colors.bg, colors.bg}
        }
    }

    gls.left[9] = {
        DiagnosticError = {
            provider = "DiagnosticError",
            icon = "  ",
            highlight = {colors.red, colors.bg}
        }
    }

    gls.left[10] = {
        Space = {
            provider = function()
                return " "
            end,
            highlight = {colors.bg, colors.bg}
        }
    }

    gls.left[12] = {
        DiagnosticWarn = {
            provider = "DiagnosticWarn",
            icon = "  ",
            highlight = {colors.orange, colors.bg}
        }
    }

    gls.right[1] = {
        GitIcon = {
            provider = function()
                return "   "
            end,
            condition = require("galaxyline.provider_vcs").check_git_workspace,
            highlight = {colors.teal, colors.bg}
        }
    }

    gls.right[2] = {
        GitBranch = {
            provider = "GitBranch",
            condition = require("galaxyline.provider_vcs").check_git_workspace,
            highlight = {colors.teal, colors.bg}
        }
    }

    gls.right[3] = {
        right_LeftRounded = {
            provider = function()
                return " " 
            end,
            separator = " ",
            separator_highlight = {colors.bg, colors.bg},
            highlight = {colors.fg, colors.bg}
        }
    }

    gls.right[4] = {
        ViMode = {
            provider = function()
                local alias = {
                    n = "NORMAL",
                    i = "INSERT",
                    c = "COMMAND",
                    V = "VISUAL",
                    [""] = "VISUAL",
                    v = "VISUAL",
                    R = "REPLACE"
                }
                return alias[vim.fn.mode()]
            end,
            highlight = {colors.blue, colors.bg}
        }
    }

    gls.right[5] = {
        PerCent = {
            provider = "LinePercent",
            separator = " ",
            separator_highlight = {colors.fg, colors.bg},
            highlight = {colors.fg, colors.bg}
        }
    }

    gls.right[6] = {
        rightRounded = {
            provider = function()
                return " "
            end,
            highlight = {colors.fg, colors.bg}
        }
    }
