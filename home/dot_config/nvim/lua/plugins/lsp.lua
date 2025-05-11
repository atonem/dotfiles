return {
  { "neovim/nvim-lspconfig" },
  { "mason-org/mason.nvim", opts = {} },
  { "mason-org/mason-lspconfig.nvim", opts = {} },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      -- 'diagnosticls',
      ensure_installed = {
        "beautysh",
        "eslint_d",
        "graphql",
        "html",
        "jq",
        "jsonls",
        "lua_ls",
        "prettierd",
        "pylsp",
        "ruff",
        "rust_analyzer",
        "shellcheck",
        "shfmt",
        "stylua",
        "taplo",
        "ts_ls",
        "yamlfmt",
        "yamlls",
      },
      integrations = {
        ["mason-lspconfig"] = true,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        bash = { "shellcheck" },
        python = { "ruff" },
        yaml = { "yq" },
        zsh = { "zsh" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      local defaults = require("formatter.defaults")

      require("formatter").setup({
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.DEBUG,
        filetype = {
          bash = { require("formatter.filetypes.sh").shfmt },
          html = { defaults.prettierd },
          json = { require("formatter.filetypes.json").jq },
          lua = { require("formatter.filetypes.lua").stylua },
          python = { require("formatter.filetypes.python").ruff },
          sh = { require("formatter.filetypes.sh").shfmt },
          toml = { require("formatter.filetypes.toml").taplo },
          yaml = { require("formatter.filetypes.yaml").yamlfmt },
          zsh = { require("formatter.filetypes.zsh").beautysh },
          javascript = { defaults.prettierd },
          javascriptreact = { defaults.prettierd },
          typescript = { defaults.prettierd },
          typescriptreact = { defaults.prettierd },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })
    end,

    keys = {
      {
        "<leader>i",
        "<cmd>FormatLock<cr>",
        desc = "Format current buffer",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
      })
    end,
  },
}
