local navic = require("nvim-navic")
local venv_selector = require('venv-selector')

-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
  green  = '#00ff00',
  yellow = '#E2AB3B';
  brown = '#A68D65';
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.brown},
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.blue, bg = colors.black },
    x = { fg = colors.green, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.yellow} },
  visual = { a = { fg = colors.black, bg = colors.white} },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.blue, bg = colors.black },
    x = { fg = colors.green, bg = colors.black },
  },
}

local function directory_exists(path)
  local success, _, code = os.execute('cd ' .. path)
  return success and code == 0
end

-- Get the directory name if it exists
local function get_venv_name(path)
  local last_sep = path:find("/[^/]*$")
  if last_sep then
    return path:sub(last_sep + 1)
  end
end

local function get_venv()
    local venv = venv_selector.get_active_venv()
    if venv then
        return get_venv_name(venv)
    else
        return ""
    end
end

require('lualine').setup {
    options = {
        theme = bubbles_theme,
        component_separators = '|',
    },
    sections = {
        lualine_a = {
            { 'mode',  right_padding = 2 },
        },
        lualine_b = { 
            'filename',
            'branch'
        },
        lualine_c = {
            {
                function()
                    return navic.get_location()
                end,
                cond = function()
                    return navic.is_available()
                end
            },
        },
        lualine_x = {
            get_venv,
        },
        lualine_y = {
            'filetype',
            'progress'
        },
        lualine_z = {
            { 'location',  left_padding = 2 },
        },
    },
    tabline = {},
    extensions = {},
}

