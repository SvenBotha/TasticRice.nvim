return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    local is_transparent = true

    -- Initial Tokyonight setup
    require("tokyonight").setup({
      style = "storm",
      transparent = is_transparent,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    })

    vim.cmd("colorscheme tokyonight-storm")

    -- Toggle transparency logic
    local function toggle_transparency()
      is_transparent = not is_transparent
      require("tokyonight").setup({
        style = "storm",
        transparent = is_transparent,
        styles = {
          sidebars = is_transparent and "transparent" or "dark",
          floats = is_transparent and "transparent" or "dark",
        },
      })
      vim.cmd("colorscheme tokyonight-storm")
    end

    -- Keymap: <leader>bg toggles transparency
    vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
  end,
}

