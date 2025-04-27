local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- Replace these with the tools you have installed
    -- make sure the source name is supported by null-ls
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.prettier_d_slim,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.ruff,
  },
})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'jsonls',
    'lua_ls',
    -- 'typescript-language-server',
    'diagnosticls',
    -- 'eslint_d',
    'graphql',
    'html',
    'rust_analyzer',
    'yamlls',
    'ruff_lsp',
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls({
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {
            'vim',
            'require',
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      })
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  },
})

lsp_zero.format_mapping('<leader>i', {
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = {
      'javascript',
      'typescript',
      'typescriptreact',
      'json',
      'lua',
      'python',
    },
  },
})

lsp_zero.setup({
  settings = {
    Lua = {},
  },
})
