"   vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
"   vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
"   vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
"   vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})
lua << EOF
require("luasnip").log.set_loglevel("debug")
EOF
