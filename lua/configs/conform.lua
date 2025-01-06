local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    vhdl = { "vsg" },
    c = { "clang-formater" },
    css = { "prettier" },
    html = { "prettier" },
    py = { "black" },
    rust = { "rustfmt" },
    typescript = { "prettierd", "prettier" },
    md = { "cbfmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options
