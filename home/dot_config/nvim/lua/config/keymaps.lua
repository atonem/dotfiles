local opts = { noremap = true, silent = true }

-- Switch panes without C-W lead
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", opts)
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", opts)
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", opts)
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", opts)

-- Tab commands
vim.api.nvim_set_keymap("n", "tn", ":tabnew<CR>", opts)
vim.api.nvim_set_keymap("n", "tc", ":tabclose<CR>", opts)
vim.api.nvim_set_keymap("n", "H", ":tabprev<CR>", opts)
vim.api.nvim_set_keymap("n", "L", ":tabnext<CR>", opts)

-- Open new line below and above current line
vim.api.nvim_set_keymap("n", "<leader>o", "o<esc>", opts)
vim.api.nvim_set_keymap("n", "<leader>O", "O<esc>", opts)

-- yanking
local function createCopyExpand(expr)
  local function copyExpand()
    local filepath = vim.fn.expand(expr)
    vim.fn.setreg("+", filepath) -- write to clippoard
    print("yanked:", filepath)
  end
  return copyExpand
end
-- end of line
vim.api.nvim_set_keymap("n", "Y", "y$", opts)
-- -- full buffer path
vim.keymap.set("n", "yp", createCopyExpand("%:p"), { noremap = true, silent = true, desc = "Full Path" })
-- -- relative buffer path
vim.keymap.set("n", "yr", createCopyExpand("%:~:."), { noremap = true, silent = true, desc = "Relative Path" })

-- qq to record, Q to replay
vim.api.nvim_set_keymap("n", "Q", "@q", opts)

-- use ctrl+hjkl in insert mode
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", opts)
vim.api.nvim_set_keymap("i", "<C-j>", "<Down>", opts)
vim.api.nvim_set_keymap("i", "<C-k>", "<Up>", opts)
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", opts)
