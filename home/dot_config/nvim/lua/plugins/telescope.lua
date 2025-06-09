return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require("telescope").load_extension("fzf")
    end,
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            -- TODO: not sure this works well in subdirs?
            -- cwd = vim.fn.finddir(".git/..", ".;"),
          })
        end,
        desc = "Find File",
      },
      {
        "<leader>fl",
        function()
          require("telescope.builtin").live_grep({
            hidden = true,
            cwd = vim.fn.finddir(".git/..", ".;"),
          })
        end,
        desc = "Find Lines",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers({})
        end,
        desc = "Find Buffers",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").registers({})
        end,
        desc = "Find Registers",
      },
      {
        "<leader>gc",
        function()
          require("telescope.builtin").git_bcommits({})
        end,
        desc = "Find Buffer Commits",
      },
      {
        "q:",
        function()
          require("telescope.builtin").command_history({})
        end,
        desc = "Command History",
      },
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
      defaults = {
        theme = "dropdown",
        file_ignore_patterns = { ".git/" },
        mappings = {
          i = {
            ["<CR>"] = function(bufnr)
              require("telescope.actions.set").edit(bufnr, "tab drop")
            end,
            ["<C-o>"] = "select_default",
            ["<C-s>"] = "select_horizontal",
            ["<C-v>"] = "select_vertical",
          },
        },
      },
    },
  },
}
