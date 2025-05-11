return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    enabled = true,
    opts = { mode = "cursor" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        refactor = {
          highlight_definitions = {
            enable = true,
            -- TODO: disable for big files
            -- disable = function(lang, bufnr)
            --
            -- end,
          },
        },
        indent = {
          enable = true,
        },
        auto_install = true,
        ensure_installed = {
          "bash",
          "beancount",
          "css",
          "csv",
          "dart",
          "diff",
          "dockerfile",
          "editorconfig",
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "graphql",
          "groovy",
          "html",
          "hurl",
          "java",
          "javascript",
          "jinja",
          "jq",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "make",
          "markdown",
          "mermaid",
          "nginx",
          "passwd",
          "perl",
          "php",
          "properties",
          "python",
          "rust",
          "scss",
          "sparql",
          "sql",
          "ssh_config",
          "swift",
          "tmux",
          "toml",
          "toml",
          "tsv",
          "tsx",
          "turtle",
          "typescript",
          "vim",
          "vue",
          "xml",
          "yaml",
        },
        highlight = {
          enable = true,
        },
      })
      vim.treesitter.language.register("bash", "zsh")
    end,
  },
}
