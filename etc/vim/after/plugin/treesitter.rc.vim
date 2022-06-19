if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "bash",
    "css",
    "dart",
    "dockerfile",
    "graphql",
    "html",
    "java",
    "javascript",
    "json",
    "jsonc",
    "ledger",
    "lua",
    "make",
    "markdown",
    "php",
    "python",
    "scss",
    "sparql",
    "swift",
    "toml",
    "toml",
    "tsx",
    "turtle",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
EOF
