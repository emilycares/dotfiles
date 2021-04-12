require('jumpwire').setup({ language = {
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
}})
