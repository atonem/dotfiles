if luaeval("package.loaded.gitsigns") | finish | endif

nnoremap <leader>gb <cmd>Gitsigns blame_line<cr>
nnoremap <leader>gd <cmd>Gitsigns toggle_deleted<cr>
nnoremap <leader>gc <cmd>Gitsigns reset_buffer<cr>
nnoremap <leader>ga <cmd>Gitsigns stage_buffer<cr>
nnoremap <leader>gs <cmd>Gitsigns stage_hunk<cr>
nnoremap <leader>gS <cmd>Gitsigns undo_stage_hunk<cr>
nnoremap <leader>gp <cmd>Gitsigns preview_hunk<cr>

lua <<EOF
  require('gitsigns').setup {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true})

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true})
    end
  }
EOF
