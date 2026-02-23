local M = {}

local function normalize_opts(lhs, opts)
	opts = opts or {}
	if opts.desc == false then
		opts.desc = nil
	elseif opts.desc == nil then
		vim.notify("Keymap missing desc: " .. lhs, vim.log.levels.WARN)
	end
	if opts.silent == nil then
		opts.silent = true
	end
	return opts
end

function M.set(mode, lhs, rhs, opts)
	opts = normalize_opts(lhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

function M.buf(bufnr, mode, lhs, rhs, opts)
	opts = opts or {}
	opts.buffer = bufnr
	M.set(mode, lhs, rhs, opts)
end

return M
