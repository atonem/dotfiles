vim.filetype.add({
  extension = {
    ["swcrc"] = "jsonc",
  },
  filename = {
    [".swcrc"] = "jsonc",
    taskrc = "dosini",
  },
  pattern = {
    [".*/ghostty/config"] = "dosini",
    [".*"] = {
      function(_, bufnr)
        -- check shebang
        local content = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
        if vim.regex([[^#!.*]]):match_str(content) ~= nil then
          -- uv shebang is for python
          if vim.regex([[.*uv.*]]):match_str(content) ~= nil then
            return "python"
          end
        end
      end,
      { priority = -math.huge },
    },
  },
})
