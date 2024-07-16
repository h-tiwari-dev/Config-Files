local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")
telescope.load_extension("git_file_history");
local gfh_actions = require("telescope").extensions.git_file_history.actions


telescope.setup({
    defaults = {
        layout_strategy = "horizontal",
        layout_config = {
            preview_width = 0.65,
            horizontal = {
                size = {
                    width = "95%",
                    height = "95%",
                },
            },
        },
        pickers = {
            find_files = {
                theme = "dropdown",
            },
        },
        mappings = {
            i = { ["<c-t>"] = open_with_trouble },
            n = { ["<c-t>"] = open_with_trouble },
        },
    },
    extensions = {
        git_file_history = {
            mappings = {
                i = {
                    ["<C-g>"] = gfh_actions.open_in_browser,
                },
                n = {
                    ["<C-g>"] = gfh_actions.open_in_browser,
                },
            },

            browser_command = nil,
        },
    },
})


vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fm', ":Telescope harpoon marks<CR>", { desc = 'Harpoon [M]arks' })

vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
