local venv_selector = require('venv-selector')

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
        theme = 'auto',
        -- section_separators = { left = '', right = '' },
        -- component_separators = '|',
    },
    sections = {
        lualine_a = {
            { 'mode', right_padding = 2 },
        },
        lualine_b = {
            'filename',
            'branch',
        },
        lualine_c = {
            {
                'filename',
                path = 1,
            },
        },
        lualine_x = {
            get_venv,
            -- {
            --     require("noice").api.status.message.get_hl,
            --     cond = require("noice").api.status.message.has,
            -- },
            {
                require("noice").api.status.command.get,
                cond = require("noice").api.status.command.has,
                color = { fg = "#ff9e64" },
            },
            {
                require("noice").api.status.mode.get,
                cond = require("noice").api.status.mode.has,
                color = { fg = "#ff9e64" },
            },
            {
                require("noice").api.status.search.get,
                cond = require("noice").api.status.search.has,
                color = { fg = "#ff9e64" },
            },
        },
        lualine_y = {
            'filetype',
            'progress',
        },
        lualine_z = {
            { 'location', left_padding = 2 },
        },
    },
    tabline = {},
    extensions = {},
}
