return {
  -- we are just modifying lspconfig's packer definition table
  -- put this in your custom plugins section i.e M.plugins.user field
  ["treesitter/nvim-treesitter"] = {
    override_options = function()
      return {
        ensure_installed = {
          "vim",
          "html",
          "css",
          "javascript",
          "json",
          "markdown",
          "c",
          "python",
          "bash",
          "lua",
        },
      }
    end,
  },
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = function()
      return {
        view = {
          hide_root_folder = false,
        },
      }
    end,
  },
  -- gitsigns override_options
  ["lewis6991/gitsigns.nvim"] = {
    override_options = function()
      return {
        signs = {
          add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
          change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
          delete = { hl = "DiffDelete", text = "│", numhl = "GitSignsDeleteNr" },
          topdelete = { hl = "DiffDelete", text = "│", numhl = "GitSignsDeleteNr" },
          changedelete = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
        },
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 10,
          ignore_whitespace = true,
        },
      }
    end,
  },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspserver"
    end,
  },
  ["hrsh7th/nvim-cmp"] = {
    override_options = function()
      local cmp = require "cmp"
      return {
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        sources = {
          -- { name = "copilot" },
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
      }
    end,
  },
  ["nikvdp/ejs-syntax"] = {},
  ["907th/vim-auto-save"] = {
    config = function()
      require "custom.plugins.configs.autosave"
    end,
  },
  ["dense-analysis/ale"] = {
    config = function()
      require "custom.plugins.configs.ale"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.configs.null_ls"
    end,
  },
  ["mg979/vim-visual-multi"] = {},
  ["dsznajder/vscode-es7-javascript-react-snippets"] = {
    run = "yarn install --frozen-lockfile && yarn compile",
  },
  ["alvan/vim-closetag"] = {
    config = function()
      require "custom.plugins.configs.closetag"
    end,
  },
  ["github/copilot.vim"] = {},
  ["m-demare/hlargs.nvim"] = {
    requires = "nvim-treesitter/nvim-treesitter",
  },
  ["nanotee/sqls.nvim"] = {},
  ["p00f/nvim-ts-rainbow"] = {
    config = function()
      require "custom.plugins.configs.rainbow"
    end,
  },
  -- ["windwp/nvim-ts-autotag"] = {
  --    config = function()
  --       require "custom.configs.autotags"
  --    end,
  -- },
  ["tami5/lspsaga.nvim"] = {
    config = function()
      require "custom.plugins.configs.lspsaga"
    end,
  },
  ["mvllow/modes.nvim"] = {
    config = function()
      require("modes").setup()
    end,
  },
}
