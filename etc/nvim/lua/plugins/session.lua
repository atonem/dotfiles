return {
  {
    'jedrzejboczar/possession.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      local function current_dir_name()
        local cwd = vim.fn.getcwd()
        return vim.fn.fnamemodify(cwd, ':t')
      end

      vim.api.nvim_create_user_command('PossessionInitEmpty', function()
        local branch = current_git_branch()
        local repo = current_dir_name()
        if branch then
          branch = branch:gsub('/', '_')
          local session_name = repo .. '-' .. branch
          require('possession.commands').save(session_name)
        end
      end, { nargs = 0 })
    end,

    opts = {},
  },
}
