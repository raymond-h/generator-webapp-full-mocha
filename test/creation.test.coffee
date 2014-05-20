path = require 'path'
fs = require 'fs'
helpers = require('yeoman-generator').test
chai = require 'chai'
_ = require 'underscore'

{expect} = chai
chai.should()

{asyncCatch} = require './common'

describe 'webapp-full-mocha generator', ->
	origCwd = process.cwd()
	mockParams =
		webappName: 'spline-destroyer'
		desc: 'Why reticulate when you can destroy?'
		author: 'John Dope'
		checkinCompiled: false

	beforeEach (done) ->
		helpers.testDirectory path.join(__dirname, 'temp'), (err) =>
			if err
				return done(err)

			@app = helpers.createGenerator 'webapp-full-mocha:src:app', [
				'../../src/app'
			]

			@app.options['skip-install'] = true

			done()

	it 'creates expected files', (done) ->
		expected = [
			'bower.json'
			'package.json'
			'Gruntfile.coffee'
			'index.coffee'
			'.gitignore'

			'app/index.html'
			'src/main.coffee'
			'test/common.coffee'
			'test/server/sample.test.coffee'
			'test/client/unit/sample.test.coffee'
			'test/client/e2e/sample.test.coffee'
		]

		helpers.mockPrompt @app, mockParams

		@app.run {}, ->
			helpers.assertFiles(expected)

			done()

	it 'should insert params into package.json and bower.json', (done) ->
		helpers.mockPrompt @app, mockParams

		@app.run {}, ->
			packageJson = JSON.parse fs.readFileSync 'package.json', encoding: 'utf-8'

			packageJson.name.should.equal mockParams.webappName
			packageJson.description.should.equal mockParams.desc
			packageJson.author.should.equal mockParams.author

			bowerJson = JSON.parse fs.readFileSync 'bower.json', encoding: 'utf-8'

			bowerJson.name.should.equal mockParams.webappName
			bowerJson.description.should.equal mockParams.desc
			bowerJson.authors.should.deep.equal [mockParams.author]

			done()

	it 'should add /lib and /built-app to .gitignore if compiled output is not
	    to be checked into git', (done) ->

		helpers.mockPrompt @app, _.extend {}, mockParams,
			checkinCompiled: false

		@app.run {}, ->
			lines = (fs.readFileSync '.gitignore', encoding: 'utf-8').split /\r?\n|\r/

			lines.should.include.members ['lib/', 'built-app/']

			done()

	it 'should not add /lib and /built-app to .gitignore if compiled output is
	    to be checked into git', (done) ->

		helpers.mockPrompt @app, _.extend {}, mockParams,
			checkinCompiled: true

		@app.run {}, ->
			lines = (fs.readFileSync '.gitignore', encoding: 'utf-8').split /\r?\n|\r/

			lines.should.not.include.members ['lib/', 'built-app/']

			done()

	afterEach ->
		process.chdir origCwd