-- custom.mappings

local M = {}
M.nvimtree = {
  -- mode_opts = { silent = false }, -- this is completely optional
  n = {
    ["C-n"] = { "", "toggle " },
    ["<CR>"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
    ["<C-f>"] = { "<cmd> Telescope <CR>", "open telescope" },
  },
}
M.comment = {
  n = {
    ["<leader>c"] = {
      "gcc",
      "蘒  toggle comment",
    },
  },

  v = {
    ["<leader>c"] = {
      "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
      "蘒  toggle comment",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Telescope" },
  },
}
M.lspsaga = {
  n = {
    ["<space>"] = { "<Cmd> :Lspsaga hover_doc <CR>", "LSP Saga" },
  },
}

return M
