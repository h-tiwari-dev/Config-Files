require('trouble').setup({
    modes = {
        -- preview_float = {
        --     mode = "diagnostics",
        --     preview = {
        --         type = "float",
        --         relative = "editor",
        --         border = "rounded",
        --         title = "Preview",
        --         title_pos = "center",
        --         position = { 0, -2 },
        --         size = { width = 0.3, height = 0.3 },
        --         zindex = 200,
        --     },
        -- },
        -- diagnostics_buffer = {
        --     mode = "diagnostics", -- inherit from diagnostics mode
        --     filter = { buf = 0 }, -- filter diagnostics to the current buffer
        -- },
        -- mydiags = {
        --     mode = "diagnostics", -- inherit from diagnostics mode
        --     filter = {
        --         any = {
        --             buf = 0, -- current buffer
        --             {
        --                 severity = vim.diagnostic.severity.ERROR, -- errors only
        --                 -- limit to files in the current project
        --                 function(item)
        --                     return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
        --                 end,
        --             },
        --         },
        --     },
        -- },
        cascade = {
            mode = "diagnostics", -- inherit from diagnostics mode
            preview = {
                type = "split",
                relative = "win",
                position = "right",
                size = 0.5,
            },
            filter = function(items)
                local severity = vim.diagnostic.severity.HINT
                for _, item in ipairs(items) do
                    severity = math.min(severity, item.severity)
                end
                return vim.tbl_filter(function(item)
                    return item.severity == severity
                end, items)
            end,
        },
    },
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})

