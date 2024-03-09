-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope
    -- telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core.
    -- Telescope is centered around modularity, allowing for easy customization.
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Tree-sitter
    -- Tree-sitter is an incremental parsing system, it allows for high-performance syntax highlighting, code navigation, and more.
    use('nvim-treesitter/nvim-treesitter', {run= ':TSUpdate'})

    -- Themes
    -- kanagawa.nvim is a Neovim theme inspired by the colors of the famous print "The Great Wave off Kanagawa".
    use "rebelot/kanagawa.nvim"
    -- Playground for nvim-treesitter
    use 'nvim-treesitter/playground'
    -- plenary.nvim is a Lua library required by many Neovim plugins.
    use 'nvim-lua/plenary.nvim'
    -- harpoon is a utility to navigate and manage buffers/files more efficiently.
    use 'ThePrimeagen/harpoon'
    -- undotree provides a visual representation of the undo history, allowing easier navigation.
    use 'mbbill/undotree'
    -- vim-fugitive is a Git wrapper that allows you to perform Git operations directly from Neovim.
    use 'tpope/vim-fugitive'

    -- Mason
    -- mason.nvim provides an interface to install various LSP servers, formatters, and linters.
    use 'williamboman/mason.nvim'
    -- mason-lspconfig integrates mason.nvim with nvim-lspconfig to automatically configure installed LSP servers.
    use 'williamboman/mason-lspconfig.nvim'

    -- lsp-zero
    -- lsp-zero.nvim is a configuration layer to simplify setting up Neovim LSP, completion, and snippets.
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'}, -- Basic Neovim LSP configuration
            {'hrsh7th/nvim-cmp'}, -- Autocompletion plugin
            {'hrsh7th/cmp-nvim-lsp'}, -- LSP source for nvim-cmp
            {'L3MON4D3/LuaSnip'}, -- Snippets plugin
        }
    }

    -- Status Line
    -- lualine.nvim is a fast and extensible status line for Neovim.
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
        'linux-cultist/venv-selector.nvim',
        required= { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    }
    use 'nvim-tree/nvim-web-devicons'

    -- Debugger
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'theHamsta/nvim-dap-virtual-text'
    use 'Leoluz/nvim-dap-go'
    use { "folke/neodev.nvim", opts = {} }
    use {
        "mfussenegger/nvim-dap",
        requires= {
            { "rcarriga/nvim-dap-ui" },
            { "theHamsta/nvim-dap-virtual-text" },
            { "nvim-telescope/telescope-dap.nvim" },
            { "jbyuki/one-small-step-for-vimkind" },
            { "mfussenegger/nvim-dap-python" },
        },
    }
    use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}


    use {
        "rest-nvim/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("rest-nvim").setup({
                --  Open request results in a horizontal split
                result_split_horizontal = false,
                -- Keep the http file buffer above|left when split horizontal|vertical
                result_split_in_place = false,
                -- stay in current windows (.http file) or change to results window (default)
                stay_in_current_window_after_split = false,
                -- Skip SSL verification, useful for unknown certificates
                skip_ssl_verification = false,
                -- Encode URL before making request
                encode_url = true,
                -- Highlight request on run
                highlight = {
                    enabled = true,
                    timeout = 150,
                },
                result = {
                    -- toggle showing URL, HTTP info, headers at top the of result window
                    show_url = true,
                    -- show the generated curl command in case you want to launch
                    -- the same request via the terminal (can be verbose)
                    show_curl_command = false,
                    show_http_info = true,
                    show_headers = true,
                    -- table of curl `--write-out` variables or false if disabled
                    -- for more granular control see Statistics Spec
                    show_statistics = false,
                    -- executables or functions for formatting response body [optional]
                    -- set them to false if you want to disable them
                    formatters = {
                        json = "jq",
                        html = function(body)
                            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
                        end
                    },
                },
                -- Jump to request line on run
                jump_to_request = false,
                env_file = '.env',
                -- for telescope select
                env_pattern = "\\.env$",
                env_edit_command = "tabedit",
                custom_dynamic_variables = {},
                yank_dry_run = true,
                search_back = true,
            })
        end
    }

end)

