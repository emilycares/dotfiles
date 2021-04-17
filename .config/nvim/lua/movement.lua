-- telescope
local actions = require('telescope.actions')
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-q>"] = actions.send_to_qflist
			}
		}
	}
}
require("telescope").load_extension("git_worktree")

-- jumpwire
require('jumpwire').setup({ language = {
	['html'] = {
		implementation = { type = 'fileExtension', data = 'ts'},
		test = { type = 'fileExtension', data = 'spec.ts'},
		style = { type = 'fileExtension', data = 'scss'}
	},
	['scss'] = {
		implementation = { type = 'fileExtension', data = 'ts'},
		test = { type = 'fileExtension', data = 'spec.ts'},
		markup = { type = 'fileExtension', data = 'html'},
	},
	['spec.ts'] = {
		implementation = { type = 'fileExtension', data = 'ts'},
		markup = { type = 'fileExtension', data = 'html'},
		style = { type = 'fileExtension', data = 'scss'}
	},
	['ts'] = {
		test = { type = 'fileExtension', data = 'spec.ts'},
		markup = { type = 'fileExtension', data = 'html'},
		style = { type = 'fileExtension', data = 'scss'},
	},
}})

-- harpoon
require("harpoon").setup()
