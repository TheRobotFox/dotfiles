return {
	"akinsho/git-conflict.nvim",
	config = function()
		require("git-conflict").setup {
				default_mappings = true, -- disable buffer local mapping created by this plugin
				default_commands = true, -- disable commands created by this plugin
				disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
				highlights = { -- They must have background color, otherwise the default color will be used
					incoming = 'DiffText',
					current = 'DiffAdd',
				}
		}
		vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)')
		vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)')
		vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)')
		vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)')
		vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)')
		vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)')
		vim.api.nvim_create_autocmd('User', {
		  pattern = 'GitConflictDetected',
		  callback = function()
			vim.notify('Conflict detected in '..vim.fn.expand('<afile>'))
			vim.keymap.set('n', 'cww', function()
			  engage.conflict_buster()
			  create_buffer_local_mappings()
			end)
		  end
		})
	end
}

