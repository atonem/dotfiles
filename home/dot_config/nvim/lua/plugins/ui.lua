return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        section_separators = "",
        component_separators = "",
        disabled_buftypes = { "quickfix", "prompt" },
        disabled_filetypes = { "neo-tree" },
      },
      sections = {
        lualine_b = { "diff", "diagnostics" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "-",
        "<cmd>Neotree current %:p:h<cr>",
        desc = "Current buffer dir in neotree",
      },
      { "<leader>T", "<cmd>Neotree toggle<cr>", desc = "Toggle neotree" },
      {
        "<leader>tt",
        "<cmd>Neotree source=filesystem<cr>",
        desc = "Show filesystem",
      },
      {
        "<leader>tc",
        "<cmd>Neotree reveal<cr>",
        desc = "Show current file in neotree",
      },
      {
        "<leader>tg",
        "<cmd>Neotree source=git_status<cr>",
        desc = "Show git status",
      },
      {
        "<leader>tb",
        "<cmd>Neotree source=buffers<cr>",
        desc = "Show buffers",
      },
    },
    opts = {
      window = {
        mappings = {
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["<CR>"] = "open_drop",
          ["<C-CR>"] = "open",
          ["<C-s>"] = "open_split",
          ["<C-v>"] = "open_vsplit",
        },
      },
      filesystem = {
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = {
            ".DS_Store",
          },
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        window = {
          mappings = {
            ["h"] = "toggle_hidden",
            ["H"] = "",
          },
          fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
          },
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
    lazy = false,
    keys = {
      {
        "<leader>gb",
        "<cmd>Gitsigns blame_line<cr>",
        desc = "Show blame line",
      },
      {
        "<leader>gd",
        "<cmd>Gitsigns toggle_deleted<cr>",
        desc = "Show deleted",
      },
      {
        "<leader>gr",
        "<cmd>Gitsigns reset_buffer<cr>",
        desc = "Reset buffer to index",
      },
      { "<leader>ga", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage buffer" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
      {
        "<leader>gS",
        "<cmd>Gitsigns undo_stage_hunk<cr>",
        desc = "Undo stage hunk",
      },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    },
    config = function()
      require("gitsigns").setup({
        attach_to_untracked = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })
        end,
      })
    end,
  },
  {
    "linrongbin16/gitlinker.nvim",
    keys = {
      {
        "<leader>gy",
        "<cmd>GitLink default_branch<cr>",
        desc = "Yank to clipboard",
        mode = "n",
      },
      {
        "<leader>gy",
        "<cmd>GitLink default_branch<cr>",
        desc = "Yank to clipboard",
        mode = "v",
      },
      -- { "<leader>go", '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', desc = "Open in browser", mode = "n" },
      -- { "<leader>go", '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', desc = "Open in browser", mode = "v" },
    },
    opts = {
      mappings = nil,
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
}
