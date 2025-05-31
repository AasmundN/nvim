-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local mason_path = vim.fn.stdpath "data" .. "/mason"
local vue_language_server_path = mason_path .. "/packages/vue-language-server"

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "pyright", "cssls", "vhdl_ls", "gopls", "rust_analyzer", "texlab" }

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
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end,
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

-- lsp remaps
local custom_on_attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  -- KEYMAPS HERE
  -- copied from nuxt-goto readme
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
end

-- hack to make sure volar finds typescript even if its a monorepo. can be made more specific to turborepo
local util = require "lspconfig.util"
local function get_typescript_server_path(root_dir)
  local global_ts = "/Users/aasmundnorsett/.nvm/versions/node/v18.18.1/lib/node_modules/typescript/lib"
  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "typescript", "lib")
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

-- Setup for Vue
lspconfig.volar.setup {
  on_attach = custom_on_attach(),
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
  init_options = {
    typescript = {
      tsdk = vue_language_server_path .. "/node_modules/typescript/lib/",
    },
    vue = {
      hybridMode = false,
    },
  },
}

local build_clangd_command = function()
  local path = ""
  -- select depending on which project
  local handle = io.popen "which avr-gcc"
  -- local handle = io.popen "which clang++"

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

-- Create an event handler for the FileType autocommand
-- vim.api.nvim_create_autocmd("FileType", {
--   -- This handler will fire when the buffer's 'filetype' is "python"
--   pattern = { "verilog", "systemverilog" },
--   callback = function()
--     vim.lsp.start {
--       name = "verible",
--       cmd = { "verible-verilog-ls", "--rules_config_search" },
--     }
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*.v",
--   callback = function()
--     vim.lsp.buf.format { async = false }
--   end,
-- })
