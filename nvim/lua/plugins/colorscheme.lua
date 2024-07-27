return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
    keys = {
      { "<leader>tt", ":CombinedToggle<CR>", noremap = true, silent = true, desc = "Toggle Theme" },
    },
    opts = {
      transparent = true,

      -- Enable italics comments
      italic_comments = false,

      -- Replace all fillchars with ' ' for the ultimate clean look
      hide_fillchars = true,

      -- Modern borderless telescope theme
      borderless_telescope = false,

      -- Set terminal colors used in `:terminal`
      terminal_colors = false,

      theme = {
        variant = "auto", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
      },

      -- Disable or enable colorscheme extensions
      extensions = {
        telescope = true,
        notify = true,
        mini = true,
      },
    },
    init = function(_, opts)
      -- Define the combined toggle function
      function CombinedToggle()
        -- Call CyberdreamToggleMode
        require("cyberdream").setup({
          -- Enable transparent background
          transparent = false,

          -- Enable italics comments
          italic_comments = false,

          -- Replace all fillchars with ' ' for the ultimate clean look
          hide_fillchars = true,

          -- Modern borderless telescope theme
          borderless_telescope = true,

          -- Set terminal colors used in `:terminal`
          terminal_colors = false,

          theme = {
            variant = "auto", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
          },
          -- Disable or enable colorscheme extensions
          extensions = {
            telescope = true,
            notify = true,
            mini = true,
          },
        })

        vim.cmd("colorscheme cyberdream")
        vim.cmd("CyberdreamToggleMode")
        print("Color Mode Changed")
      end

      -- Define a command to toggle both
      vim.api.nvim_create_user_command("CombinedToggle", CombinedToggle, {})
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
}
