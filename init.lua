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

-- setup nvim-navic

local notify = require "notify"
notify.setup { background_colour = "#000000" }
local client_notifs = {}
local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" } -- spinners

local function update_spinner(notif_data) -- update spinner helper function to defer
  if notif_data.spinner then
    local new_spinner = (notif_data.spinner + 1) % #spinner_frames
    notif_data.spinner = new_spinner

    notif_data.notification = notify(nil, nil, {
      hide_from_history = true,
      icon = spinner_frames[new_spinner],
      replace = notif_data.notification,
    })

    vim.defer_fn(function()
      update_spinner(notif_data)
    end, 100)
  end
end

vim.api.nvim_create_augroup("lsp_notify", { clear = true }) -- create augroup
vim.api.nvim_create_autocmd("User", {
  pattern = "LspProgressUpdate", -- LSP Progress Update autocommand
  group = "lsp_notify",
  desc = "LSP progress notification",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf() -- get buffer number
    for _, client in pairs(vim.lsp.buf_get_clients()) do -- loop over each client to check notifications
      if not client_notifs[bufnr] then -- create buffer specific notification table if not exists
        client_notifs[bufnr] = {}
      end
      if not client_notifs[bufnr][client.id] then -- create buffers client  specific  notification table if not exists
        client_notifs[bufnr][client.id] = {}
      end
      local notif_data = client_notifs[bufnr][client.id] -- set notif_data variable
      local progress = nil
      for _, progress_msg in pairs(client.messages.progress) do
        progress = true -- expose if a progress exists
        if not progress_msg.done then
          progress = progress_msg -- get clients first not done progress messages
          break
        end
      end
      if type(progress) == "table" and progress.percentage and progress.percentage ~= 0 then -- if there is a progress message
        local notify_opts = {} -- define notification options
        local new_msg = notif_data.notification == nil -- if it's a new message set different options
        if new_msg then -- for new messages set a title, initialize icone and disable timeout
          notify_opts = {
            title = client.name .. (#progress.title > 0 and ": " .. progress.title or ""),
            icon = spinner_frames[1],
            timeout = false,
          }
        else -- for existing messages just update the existing notification
          notify_opts = { replace = notif_data.notification }
        end
        notif_data.notification = notify( -- notify with percentage and message
          (progress.percentage and progress.percentage .. "%\t" or "") .. (progress.message or ""),
          "info",
          notify_opts
        )
        if new_msg then -- if it's a new message, start the update spinner background job
          update_spinner(notif_data)
        end
      elseif progress and not vim.tbl_isempty(notif_data) then -- if there is finished progress and a notification, complete it
        notif_data.notification =
          notify("Complete", "info", { icon = "", replace = notif_data.notification, timeout = 3000 })
        notif_data = {} -- clear notification data
      end
    end
  end,
})
