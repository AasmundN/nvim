-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local mason_registry = require "mason-registry"

local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "vhdl_ls", "gopls", "rust_analyzer" }

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Typescript setup with vue plugin
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path .. "/node_modules/@vue/language-server",
        languages = { "vue" },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}

-- Setup for Vue
lspconfig.volar.setup {
  init_options = {
    typescript = {
      tsdk = vue_language_server_path .. "/node_modules/typescript/lib/",
    },
  },
}

local build_clangd_command = function()
  local path = ""
  local handle = io.popen "which avr-gcc"

  if handle ~= nil then
    local output = handle:read "*a"
    path = output:gsub("[\n\r]", "")
    handle:close()
  end

  return {
    "clangd",
    string.format("--query-driver=%s", path),
  }
end

lspconfig["clangd"].setup {
  cmd = build_clangd_command(),
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
