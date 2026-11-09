-- Native global statusline (replaces lualine). Branch comes from gitsigns;
-- diagnostics and LSP progress use the same helpers as the 0.12 default.
local M = {}

function M.render()
	local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
	local bo = vim.bo[buf]
	local head = vim.b[buf].gitsigns_head

	local left = (head and head ~= "") and ("%#StatusLineBranch#  " .. head .. " %*") or ""
	local right = vim.tbl_filter(function(s)
		return s ~= ""
	end, {
		vim.diagnostic.status(),
		vim.ui.progress_status(),
		bo.filetype,
		bo.fileencoding ~= "" and bo.fileencoding or vim.o.encoding,
		bo.fileformat,
		"%P",
		"%l:%c",
	})
	return left .. " %<%f %h%m%r%=" .. table.concat(right, "  ") .. " "
end

vim.o.laststatus = 3
vim.o.statusline = "%!v:lua.require'config.statusline'.render()"

return M
