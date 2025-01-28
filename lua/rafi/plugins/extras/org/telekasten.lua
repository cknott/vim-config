-- rafi.plugins.extras.org.telekasten
--

return {

	-- Manage text-based, markdown zettelkasten or wiki with telescope
	{
		'renerocksai/telekasten.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim' },
		cmd = { 'Telekasten' },
		-- stylua: ignore
		keys = {
			{ '<leader>zn', function() require('telekasten').new_note() end, desc = 'Create note'},
			{ '<leader>zN', function() require('telekasten').new_templated_note() end, desc = 'Create templated note' },
			{ '<leader>zf', function() require('telekasten').find_notes() end, desc = 'Find note' },
			{ '<leader>zg', function() require('telekasten').search_notes() end, desc = 'Search'  },
			{ '<leader>zo', function() require('telekasten').panel() end, desc = 'Panel'  },
			{ '<leader>zt', function() require('telekasten').show_tags() end, desc = 'Show tags'  },
			{ '<leader>zd', function() require('telekasten').find_daily_notes() end, desc = 'Find daily notes'  },
			{ '<leader>zb', function() require('telekasten').show_backlinks() end, desc = 'Show backlinks'  },
			{ '<leader>zl', function() require('telekasten').find_friends() end, desc = 'Find friends'  },
			{ '<leader>zm', function() require('telekasten').browse_media() end, desc = 'Browse media'  },
		},
		opts = {
			home = vim.fn.expand('~/docs/wiki'),
		},
	},
}
