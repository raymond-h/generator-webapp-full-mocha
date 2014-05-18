path = require 'path'
helpers = require('yeoman-generator').test

describe 'webapp-generic generator', ->
	origCwd = process.cwd()

	before (done) ->
		helpers.testDirectory path.join(__dirname, 'temp'), (err) =>
			if err
				return done(err)

			@app = helpers.createGenerator 'webapp-generic:src:app', [
				'../../src/app'
			]

			done()

	after ->
		process.chdir origCwd

	it 'creates expected files', (done) ->
		expected = [
			# add files you expect to exist here.
		]

		helpers.mockPrompt @app,
			'someOption': true

		@app.options['skip-install'] = true
		@app.run {}, ->
			helpers.assertFiles(expected)
			done()