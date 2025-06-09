return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("render-markdown").setup({
        link = {
          custom = {
            web = { pattern = "^http", icon = "󰖟 " },
            github = { pattern = "github%.com", icon = "󰊤 " },
            gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
            stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
            wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
          },
        },
      })
    end,
  },
}
