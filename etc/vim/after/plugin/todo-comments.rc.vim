lua << EOF
  require("todo-comments").setup {
    -- config goes here
  }
EOF

nnoremap <leader>ft <cmd>TodoTelescope<cr>
