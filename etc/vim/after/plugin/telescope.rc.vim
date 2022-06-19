if !exists('g:loaded_telescope') | finish | endif

nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fl <cmd>Telescope live_grep hidden=true<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope registers<cr>
nnoremap <leader>gc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap q: <cmd>Telescope command_history<cr>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  extensions = {
    fzf = {
      fuzzy = true,                    
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
  defaults = {
    theme = "dropdown",
    file_ignore_patterns = { ".git" },
    -- vimgrep_arguments = {
    --   'rg',
    --   '--color=never',
    --   '--no-heading',
    --   '--with-filename',
    --   '--line-number',
    --   '--column',
    --   '--smart-case',
    --   '-uu'
    -- },
    -- mappings = { },
  }
}
require('telescope').load_extension('fzf')
EOF
