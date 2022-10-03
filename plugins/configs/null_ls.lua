local present, null = pcall(require, "null-ls")
if not present then
  return
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local formatter = null.builtins.formatting
local diagnostics = null.builtins.diagnostics
local sources = {
  formatter.clang_format,
  formatter.stylua,
  -- formatter.reorder_python_imports,
  formatter.black,
  -- formatter.eslint,
  -- formatter.prettier.with { args = { "--no-semi", "--single-qoute" } },
  -- diagnostics.eslint_dd,
  -- php formatter
  formatter.phpcbf,
  formatter.phpcsfixer,
  diagnostics.cppcheck,
  diagnostics.php,
  diagnostics.luacheck,
}

null.setup {
  -- you can reuse a shared lspconfig on_attach callback here
  corb = { "cok" },
  debug = true,
  sources = { sources = sources },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
}
