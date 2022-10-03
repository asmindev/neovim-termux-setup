local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "pyright", "cssls", "emmet_ls", "clangd", "jsonls", "tsserver", "tailwindcss", "intelephense" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- html config for php
lspconfig.html.setup {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "php", "ejs" },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- emmet config for php and html files
lspconfig.emmet_ls.setup {
  filetypes = { "html", "php", "ejs" },
  on_attach = on_attach,
  capabilities = capabilities,
}
