return {
  {
    'nathom/filetype.nvim',
    lazy = false,
    opts = {
      overrides = {
        extensions = {
          justfile = 'just',
        },
        literal = {
          justfile = 'just',
          lfrc = 'conf',
          ['.swcrc'] = 'jsonc',
          ['tsconfig.json'] = 'jsonc',
          ['.envrc'] = 'bash',
          ['taskrc'] = 'dosini',
        },
        complex = {
          ['tsconfig.*.json'] = 'jsonc',
          ['*.sh'] = 'bash',
          ['.envrc*'] = 'bash',
          ['*.swcrc'] = 'jsonc',
        },
        shebang = {
          python = 'python',
        },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPre',
    enabled = true,
    opts = { mode = 'cursor' },
  },
  -- {
  --   "Scalamando/tree-sitter-bruno"
  -- },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'IndianBoy42/tree-sitter-just',
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        refactor = {
          highlight_definitions = {
            enable = true,
            -- TODO: disable for big files
            -- disable = function(lang, bufnr)
            --
            -- end,
          },
        },
        auto_install = true,
        ensure_installed = {
          'bash',
          'css',
          'dart',
          'dockerfile',
          'graphql',
          'groovy',
          'html',
          'hurl',
          'java',
          'javascript',
          'json',
          'jsonc',
          'ledger',
          'lua',
          'make',
          'markdown',
          'php',
          'python',
          'scss',
          'sparql',
          'swift',
          'toml',
          'toml',
          'tsx',
          'turtle',
          'typescript',
          'vim',
          'vue',
          'yaml',
        },
        highlight = {
          enable = true,
        },
      })
      vim.treesitter.language.register('bash', 'zsh')
    end,
  },
}
