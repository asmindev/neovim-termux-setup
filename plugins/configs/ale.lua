local cmd = vim.cmd
local set = vim.g
set.ale_fix_on_save = 1
set.ale_lint_on_save = 1
set.ale_fixers = {
   javascript = { "eslint" },
   typescript = { "eslint" },
   javascriptreact = { "eslint", "prettier" },
   vue = { "eslint", "prettier" },
   html = { "prettier" },
}
set.ale_linters = {
   javascript = { "eslint", "prettier" },
   typescript = { "eslint", "prettier" },
   vue = { "eslint", "vls", "prettier" },
   html = { "prettier" },
}
cmd [[ highlight ALEErrorSign ctermbg=white ]]
cmd [[ highlight ALEWarningSign ctermbg=white ]]
set.ale_sign_error = ""
set.ale_sign_warning = ""
set.ale_echo_msg_error_str = ""
set.ale_echo_msg_warning_str = ""
set.ale_floating_window_border = { "", "", "", "", "", "", "" }
-- set.ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
set.ale_virtualtext_cursor = 1
set.ale_echo_msg_format = "%linter%: %severity%  %s"
set.ale_warn_about_trailing_whitespace = 1
set.ale_floating_preview = 1
set.ale_hover_to_floating_preview = 1
set.ale_detail_to_floating_preview = 1
set.ale_use_global_executables = 1
-- set.ale_cursor_detail = 1
set.ale_hover_cursor = 1
set.ale_close_preview_on_insert = 1

-- vue section
set.ale_linter_aliases = { vue = { "vue", "javascript" } }

-- " Do not lint or fix minified files.
-- set.ale_pattern_options = {
--   \.min\.js$ = {'ale_linters': {}, 'ale_fixers': {}},
--   \.min\.css$ = {'ale_linters': {}, 'ale_fixers': {}},
-- }

-- " If you configure g:ale_pattern_options outside of vimrc, you need this.
set.ale_pattern_options_enabled = 1
set.ale_javascript_prettier_options = "--single-quote --no-semi"
set.ale_html_prettier_options = "--single-quote --no-semi"
set.ale_vue_prettier_options = "--single-quote --no-semi"
