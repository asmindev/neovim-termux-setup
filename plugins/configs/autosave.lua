vim.g.auto_save = 1 -- enable AutoSave on Vim startup
vim.cmd [[ let g:auto_save = 1]]
vim.g.auto_save_events = { "InsertLeave", "TextChanged", "CompleteDone" }
