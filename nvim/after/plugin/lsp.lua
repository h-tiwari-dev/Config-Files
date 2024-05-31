local lsp_zero = require('lsp-zero')
local util = require('lspconfig.util')
local lspconfig = require('lspconfig')
local venv_selector = require('venv-selector')
require("neodev").setup({
      -- add any options here, or leave empty to use the default settings
      library = { plugins = { "nvim-dap-ui" }, types = true },
})


-- Function to execute a command and capture its output
local function execute_command(command)
    local handle = io.popen(command)
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result and result:gsub("\n$", "") or nil
    end
end

-- Custom hook for changing Pyright setup Python path
function CUSTOM_PYRIGHT_HOOK(venv_path, venv_python)
    lspconfig.pyright.setup {
        settings = {
            pyright = {
                autoImportCompletion = true,
            },
            python = {
                pythonPath = venv_python,
                venvPath = venv_path,
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = 'openFilesOnly',
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = 'off'
                }
            }
        },
        on_attach = function(client, bufnr)
            lsp_zero.async_autoformat(client, bufnr)
        end,
    }
end

-- Function to set up Pyright with the nearest, cached, or default virtual environment
function SETUP_PYRIGHT_WITH_NEAREST_OR_DEFAULT_ENV()
    local nearest_venv = venv_selector.get_active_venv()
    local nearest_python = venv_selector.get_active_path()

    -- If no active virtual environment found, try to retrieve from cache
    if not nearest_venv or not nearest_python then
        venv_selector.retrieve_from_cache()
        nearest_venv = venv_selector.get_active_venv()
        nearest_python = venv_selector.get_active_path()
    end

    -- If a virtual environment is found, configure Pyright with the Python path
    if nearest_venv and nearest_python then
        CUSTOM_PYRIGHT_HOOK(nearest_venv, nearest_python)
    else
        -- If no virtual environment found, calculate default Python path at runtime
        local default_python_path = execute_command("which python3")
        print(default_python_path)
        CUSTOM_PYRIGHT_HOOK(nil, default_python_path)
    end
end

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
    local opts = {buffer = bufnr}

    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)

end)

lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»',
})

require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	ensure_installed = {
        'tsserver',
        'rust_analyzer',
        'lua_ls',
        'gopls',
        'glint',
        'pyright',
    },
	handlers = {
		lsp_zero.default_setup,
        tsserver = function ()
            lspconfig.tsserver.setup {
                on_attach = function(client, bufnr)
                    lsp_zero.async_autoformat(client, bufnr)
                end,
            }
        end,
        gopls = function ()
            lspconfig.gopls.setup {
                cmd = {"gopls"},
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
                on_attach = function(client, bufnr)
                    lsp_zero.async_autoformat(client, bufnr)
                end,
            }
        end,
        pyright = function ()
            if vim.fn.isdirectory(vim.fn.getcwd() .. '/.venv') == 1 then
                venv_selector.setup {
                    changed_venv_hooks = { CUSTOM_PYRIGHT_HOOK },
                    pipenv_path = vim.fn.getcwd(),  -- Set to the current folder
                    parents = 1
                }
            end
            SETUP_PYRIGHT_WITH_NEAREST_OR_DEFAULT_ENV()
        end,
        lua_ls = function ()
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        }
                    }
                }
            })
        end
    },
})
