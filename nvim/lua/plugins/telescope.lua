return {
  "nvim-telescope/telescope.nvim",
  opts = function()
    local open_with_trouble = require("trouble.sources.telescope").open

    return {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
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
    }
  end,
}
