local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    vhdl = { "vsg" },
    css = { "prettierd" },
    scss = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    vue = { "prettierd" },
    yaml = { "prettierd" },
    python = { "black" },
    rust = { "rustfmt" },
    md = { "cbfmt" },
    php = { "prettier" },
    tex = { "latexindent" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = false,
  },

  formatters = {
    black = {
      prepend_args = { "--fast" },
    },
    ["php-cs-fixer"] = {
      command = "php-cs-fixer",
      args = {
        "fix",
        "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
        "$FILENAME",
      },
      stdin = false,
    },
  },
}

return options
