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
      "catgoose/vue-goto-definition.nvim",
      event = "BufReadPre",
      opts = {
        filters = {
          auto_imports = true,
          auto_components = true,
          import_same_file = true,
          declaration = true,
          duplicate_filename = true,
        },
        filetypes = { "vue", "typescript" },
        detection = {
          nuxt = function()
            return vim.fn.glob ".nuxt/" ~= ""
          end,
          vue3 = function()
            return vim.fn.filereadable "vite.config.ts" == 1 or vim.fn.filereadable "src/App.vue" == 1
          end,
          priority = { "nuxt", "vue3" },
        },
        lsp = {
          override_definition = true, -- override vim.lsp.buf.definition
        },
        debounce = 200,
      },
    },

    {
      "lervag/vimtex",
      lazy = false, -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = "mupdf"
        vim.g.vimtex_compiler_latexmk = {
          out_dir = "out",
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
}
