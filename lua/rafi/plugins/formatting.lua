-- Plugins: Formatting
-- https://github.com/rafi/vim-config

local M = {}

---@param opts ConformOpts
function M.setup(_, opts)
	for name, formatter in pairs(opts.formatters or {}) do
		if type(formatter) == 'table' then
			---@diagnostic disable-next-line: undefined-field
			if formatter.extra_args then
				---@diagnostic disable-next-line: undefined-field
				formatter.prepend_args = formatter.extra_args
				LazyVim.deprecate(
					('opts.formatters.%s.extra_args'):format(name),
					('opts.formatters.%s.prepend_args'):format(name)
				)
			end
		end
	end

	require('conform').setup(opts)
end

return {

	-- Import LazyVim's formatting spec in its entirety.
	{ import = 'lazyvim.plugins.formatting' },

	-- Lightweight yet powerful formatter plugin
	{
		'stevearc/conform.nvim',
		-- stylua: ignore
		keys = {
			{ '<leader>cic', '<cmd>ConformInfo<CR>', silent = true, desc = 'Conform Info' },
		},
		opts = function()
			local plugin = require('lazy.core.config').plugins['conform.nvim']
			---@class ConformOpts
			local opts = {
				-- Use these options when formatting with the conform.nvim formatter
				log_level = vim.log.levels.ERROR,
				-- format_after_save = {
				-- 	lsp_format = "fallback",
				-- },
				default_format_opts = {
					timeout_ms = 3000,
					async = false, -- not recommended to change
					quiet = false, -- not recommended to change
					lsp_fallback = true, -- not recommended to change
				},
				---@type table<string, conform.FormatterUnit[]>
				formatters_by_ft = {
					lua = { 'stylua' },
					fish = { 'fish_indent' },
					sh = { 'shfmt' },
					twig = { 'twig' },
					php = { 'pint' },
					css = { 'prettier' },
					scss = { 'prettier' },
					javascript = { 'prettier' },
					json = { 'prettier' },
					vue = { 'prettier' },
					typescript = { 'prettier' },
					sql = { 'sql' },
					mysql = { 'sql' },
				},
				-- The options you set here will be merged with the builtin formatters.
				-- You can also define any custom formatters here.
				---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
				formatters = {
					injected = { options = { ignore_errors = true } },
					sql = {
						command = "/Users/cknott/.cargo/bin/sleek",
						args = {
							"$FILENAME"
						}
					},
					twig = {
						command = "prettier",
						args = {
							"--plugin",
							"/Users/cknott/Library/pnpm/global/5/node_modules/@zackad/prettier-plugin-twig-melody/src/index.js",
							"--stdin-filepath",
							"$FILENAME"
						}
					},
					-- # Example of using dprint only when a dprint.json file is present
					-- dprint = {
					--   condition = function(ctx)
					--     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
					--   end,
					-- },
					--
					-- # Example of using shfmt with extra args
					shfmt = {
					  prepend_args = { "-i", "2", "-ci" },
					},
				},
			}
			return opts
		end,
	},
}
