-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Telescope
	-- telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core.
	-- Telescope is centered around modularity, allowing for easy customization.
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local telescope = require("telescope")

			-- first setup telescope
			telescope.setup({
				-- your config
			})

			-- then load the extension
			telescope.load_extension("live_grep_args")
		end,
	})

	-- Tree-sitter
	-- Tree-sitter is an incremental parsing system, it allows for high-performance syntax highlighting, code navigation, and more.
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- Themes
	use({ "scottmckendry/cyberdream.nvim" })

	-- Playground for nvim-treesitter
	use("nvim-treesitter/playground")
	-- plenary.nvim is a Lua library required by many Neovim plugins.
	use("nvim-lua/plenary.nvim")
	-- harpoon is a utility to navigate and manage buffers/files more efficiently.
	use("ThePrimeagen/harpoon")
	-- undotree provides a visual representation of the undo history, allowing easier navigation.
	use("mbbill/undotree")
	-- vim-fugitive is a Git wrapper that allows you to perform Git operations directly from Neovim.
	use("tpope/vim-fugitive")

	-- Mason
	-- mason.nvim provides an interface to install various LSP servers, formatters, and linters.
	use("williamboman/mason.nvim")
	-- mason-lspconfig integrates mason.nvim with nvim-lspconfig to automatically configure installed LSP servers.
	use("williamboman/mason-lspconfig.nvim")

	-- lsp-zero
	-- lsp-zero.nvim is a configuration layer to simplify setting up Neovim LSP, completion, and snippets.
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "neovim/nvim-lspconfig" }, -- Basic Neovim LSP configuration
			{ "hrsh7th/nvim-cmp" }, -- Autocompletion plugin
			{ "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
			{ "L3MON4D3/LuaSnip" }, -- Snippets plugin
		},
	})

	-- Status Line
	-- lualine.nvim is a fast and extensible status line for Neovim.
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	use({
		"linux-cultist/venv-selector.nvim",
		required = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
	})
	use("nvim-tree/nvim-web-devicons")

	-- A library for asynchronous IO in Neovim, inspired by the asyncio library in Python
	use({ "nvim-neotest/nvim-nio" })

	-- Debugger
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("theHamsta/nvim-dap-virtual-text")
	use("Leoluz/nvim-dap-go")
	use({ "folke/neodev.nvim", opts = {} })
	use({
		"mfussenegger/nvim-dap",
		requires = {
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "nvim-telescope/telescope-dap.nvim" },
			{ "jbyuki/one-small-step-for-vimkind" },
			{ "mfussenegger/nvim-dap-python" },
		},
	})
	use({
		"ellisonleao/glow.nvim",
		config = function()
			require("glow").setup()
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({ "mfussenegger/nvim-dap-python" })

	use({ "folke/trouble.nvim" })

	use({ "lewis6991/gitsigns.nvim" })

	use({ "isak102/telescope-git-file-history.nvim" })

	use({ "folke/noice.nvim" })

	use({ "tpope/vim-surround" })

	use({
		"lukas-reineke/indent-blankline.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})

	use("ThePrimeagen/vim-be-good")

	use({
		"luckasRanarison/tailwind-tools.nvim",
		require = { "nvim-treesitter/nvim-treesitter" },
	})

	use({
		"nvim-lua/popup.nvim",
	})

	use({
		"nvim-telescope/telescope-media-files.nvim",
	})
end)
