return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "asm" },
      },
      matchup = {
        enable = true,
      },
    },

    {
      "nvim-tree/nvim-tree.lua",
      opts = {
        view = {
          adaptive_size = true,
        },
      },
    },

    {
      "andrewferrier/wrapping.nvim",
      config = function()
        require("wrapping").setup()
      end,
      lazy = false,
      opts = {
        auto_set_mode_heuristically = false,
      },
      softener = { tex = true, latex = true, markdown = true },
    },

    {
      "christoomey/vim-tmux-navigator",
      lazy = false,
    },

    {
      -- testing custom nuxt-goto plugin
      "erlestor/nuxt-goto.nvim",
      branch = "monorepo-support",
      ft = "vue",
      event = "BufEnter",
      opts = {
        check_directories = { "/apps/web" },
      },
    },

    {
      "lervag/vimtex",
      lazy = false, -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "skim"
        vim.g.vimtex_quickfix_autoclose_ufter_keystrokes = 1
        vim.g.vimtex_compiler_latexmk = {
          out_dir = "out",
        }
        vim.g.vimtex_quickfix_ignore_filters = {
          "Underfull",
          "Overfull",
        }
      end,
    },
  },

  {
    "ThePrimeagen/vim-be-good",
    lazy = false,
  },

  {
    "edte/normal-colon.nvim",
    opts = {},
    lazy = false,
  },

  {
    "fedepujol/move.nvim",
    lazy = false,
    opts = {
      --- Config
    },
  },
  {
    "javiorfo/nvim-soil",

    -- Optional for puml syntax highlighting:
    dependencies = { "javiorfo/nvim-nyctophilia" },

    lazy = true,
    ft = "plantuml",
    opts = {
      -- If you want to change default configurations

      -- This option closes the image viewer and reopen the image generated
      -- When true this offers some kind of online updating (like plantuml web server)
      actions = {
        redraw = false,
      },

      -- If you want to use Plant UML jar version instead of the installed version
      puml_jar = "/usr/local/plantuml/plantuml-1.2025.0.jar",

      -- If you want to customize the image showed when running this plugin
      image = {
        darkmode = false, -- Enable or disable darkmode
        format = "svg", -- Choose between png or svg
        -- This is a default implementation of using nsxiv to open the resultant image
        -- Edit the string to use your preferred app to open the image (as if it were a command line)
        -- Some examples:
        -- return "feh " .. img
        -- return "xdg-open " .. img
        -- return "feh " .. img .. " --reload 5"
        execute_to_open = function(img)
          return "open " .. img
        end,
      },
    },
  },

  {
    "evesdropper/luasnip-latex-snippets.nvim",
  },
}
