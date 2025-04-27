return {
  -- TODO: add this, pretty cool
  -- {
  -- 	'jedrzejboczar/exrc.nvim',
  -- 	dependencies = { 'neovim/nvim-lspconfig' }, -- (optional)
  -- 	config = true,
  -- 	opts = { --[[ your config ]]
  -- 	},
  -- },
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  }
}
