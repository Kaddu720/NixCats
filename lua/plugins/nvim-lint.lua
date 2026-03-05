return {
	"nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			lua = { "selene" },
			python = { "mypy" },
			nix = { "deadnix" },
			yaml = { "yamllint" },
			markdown = { "vale" },
			sh = { "dotenv_linter" },
			bash = { "dotenv_linter" },
		}

		local function find_vale_root(bufname)
			if not bufname or bufname == "" then
				return nil
			end
			local dir = vim.fn.fnamemodify(bufname, ":p:h")
			local found = vim.fs.find(".vale.ini", { path = dir, upward = true })[1]
			if not found then
				return nil
			end
			return vim.fn.fnamemodify(found, ":h")
		end

		local function try_lint_buf(bufnr)
			if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
				return
			end
			if vim.bo[bufnr].buftype ~= "" then
				return
			end

			local ft = vim.bo[bufnr].filetype
			if ft == "markdown" and not find_vale_root(vim.api.nvim_buf_get_name(bufnr)) then
				return
			end

			vim.api.nvim_buf_call(bufnr, function()
				lint.try_lint()
			end)
		end

		local group = vim.api.nvim_create_augroup("NvimLint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "FileType", "InsertLeave", "BufWritePost" }, {
			group = group,
			callback = function(args)
				try_lint_buf(args.buf)
			end,
		})

		vim.defer_fn(function()
			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				try_lint_buf(bufnr)
			end
		end, 120)
	end,
}
