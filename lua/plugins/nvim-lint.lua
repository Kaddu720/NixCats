return {
  "nvim-lint",
  event = "BufReadPost",
  after = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      lua = { "selene" },
      nix = { "deadnix" },
      yaml = { "yamllint" },
      markdown = { "vale" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      dotenv = { "dotenv_linter" },
    }

    local function lint_buffer(bufnr)
      if vim.bo[bufnr].buftype ~= "" then return end
      local name = vim.api.nvim_buf_get_name(bufnr)
      local opts
      if vim.bo[bufnr].filetype == "markdown" then
        local config = name ~= "" and vim.fs.find(".vale.ini", { path = vim.fs.dirname(name), upward = true })[1]
        if not config then return end
        opts = { cwd = vim.fs.dirname(config) }
      end
      vim.api.nvim_buf_call(bufnr, function() lint.try_lint(nil, opts) end)
    end

    local group = vim.api.nvim_create_augroup("NvimLint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      group = group,
      callback = function(args) lint_buffer(args.buf) end,
    })
    vim.schedule(function()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then lint_buffer(bufnr) end
      end
    end)
  end,
}
