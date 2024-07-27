local dap = require('dap')
local dapui = require('dapui')
local dapgo = require('dap-go')

require('telescope').load_extension('dap')

dapui.setup()
dapgo.setup {
    dap_configurations = {
        {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
        },
    },

}


-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<CR>t', dapui.toggle, { desc = 'Debug: See last session result.' })

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
--
--
vim.keymap.set('n', '<leader>t', dapui.toggle, { desc = 'Debug: Toggle UI' })
vim.keymap.set('n', '<leader>c', dap.continue, { desc = 'Debug: Continue' })
vim.keymap.set('n', '<leader>i', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<leader>o', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<leader>U', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })

