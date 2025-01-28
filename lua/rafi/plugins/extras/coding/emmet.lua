return {

	-- Provides support for expanding abbreviations alá emmet
	{
		'mattn/emmet-vim',
		ft = { 'html', 'html5', 'php', 'css', 'vue', 'javascript', 'javascriptreact', 'svelte', 'twig' },
		init = function()
			vim.g.user_emmet_mode = 'i'
			vim.g.user_emmet_install_global = 0
			vim.g.user_emmet_install_command = 0
			vim.g.user_emmet_complete_tag = 0
		end,
		config = function()
			vim.api.nvim_create_autocmd('FileType', {
				group = vim.api.nvim_create_augroup('rafi_emmet', {}),
				pattern = {
					'css',
					'html',
					'twig',
					'html5',
					'php',
					'javascript',
					'javascriptreact',
					'svelte',
					'vue',
				},
				callback = function()
					vim.cmd([[
						EmmetInstall
						imap <silent><buffer> <C-y> <Plug>(emmet-expand-abbr)
					]])
				end,
			})
		end,
	},
}
