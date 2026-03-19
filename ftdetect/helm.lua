local group = vim.api.nvim_create_augroup("HelmFiletypeDetect", { clear = true })

local function is_helm_file(path)
	if not path or path == "" then
		return false
	end

	local normalized = path:gsub("\\", "/")
	local filename = vim.fs.basename(normalized)

	if normalized:match("/templates/.*%.ya?ml$") or normalized:match("/templates/.*%.tpl$") or normalized:match("/templates/.*%.txt$") then
		return true
	end

	if filename:match("%.gotmpl$") then
		return true
	end

	if filename:match("^helmfile.*%.ya?ml$") then
		return true
	end

	return false
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = group,
	pattern = "*",
	callback = function(args)
		local path = vim.api.nvim_buf_get_name(args.buf)
		if is_helm_file(path) then
			vim.bo[args.buf].filetype = "helm"
			vim.bo[args.buf].commentstring = "{{/* %s */}}"
		end
	end,
})
