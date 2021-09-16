local M = {}
-- telescope
local actions = require('telescope.actions')
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-q>"] = actions.send_to_qflist
			}
		}
	},
	extensions = {
		fzf = {
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
		}
	}
}
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzf")
require("telescope").load_extension("frecency")

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
	['java'] = {
		implementation = { type = 'jvm', data = 'implementation'},
		test = { type = 'jvm', data = 'test'},
	},
}})

-- harpoon
require("harpoon").setup()

M.switch_branch = function ()

end

return M
