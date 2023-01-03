--n-vchad.no_WhichKey_map()
local cmd = vim.cmd
local set = vim.opt
vim.diagnostic.config {
  virtual_text = { prefix = "" },
}

set.relativenumber = true
set.wrap = false
set.swapfile = false
set.sidescrolloff = 8
set.scrolloff = 8
cmd [[autocmd CursorHold,CursorHoldI * :Lspsaga show_cursor_diagnostics ]]
cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]
cmd [[ autocmd Filetype php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]
cmd [[ autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 ]]
cmd [[ autocmd Filetype vue setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 ]]
cmd [[ imap <silent><script><expr> <F2> copilot#Accept("")]]
cmd [[ let g:copilot_no_tab_map = v:true]]
cmd [[nmap <C-d> <Plug>(VM-Find-Under)]]
cmd [[imap <C-d> <ESC><Plug>(VM-Select-Word)]]
cmd [[vmap <C-d> <ESC><Plug>(VM-Mouse-Word)]]
-- show message when text under cursor
-- cmd [[  let g:auto_save = 1
-- ]]
