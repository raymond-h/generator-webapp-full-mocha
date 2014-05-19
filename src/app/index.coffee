path = require 'path'
yeoman = require 'yeoman-generator'
npm = require 'npm'

module.exports = class WebappGenericGenerator extends yeoman.generators.Base
	constructor: (args, options, config) ->
		super
		
		@on 'end', ->
			@installDependencies unless options['skip-install']

		@pkg = JSON.parse @readFileAsString path.join __dirname, '../../package.json'

	loadNpm: ->
		done = @async()

		npm.load (err, @npm) => done err

	askFor: ->
		done = @async()

		# have Yeoman greet the user.
		console.log @yeoman

		prompts = [
			{
				name: 'webappName'
				message: 'What should your web app be called?'
				default: path.basename(process.cwd())
			}
			{
				name: 'desc'
				message: 'Describe the web app!'
				default: 'Reticulate splines using ducks!'
			}
			{
				type: 'input'
				name: 'author'
				message: 'Who is the author?'
				default: this.npm.config.get('init.author.name')
			}
			{
				type: 'confirm'
				name: 'checkinCompiled'
				message: 'Should the compiled JS output be checked in to git as well?'
				default: false
			}
		]

		@prompt prompts, (props) =>
			this[k] = v for k, v of props
			done()

	app: ->
		# @mkdir 'app'
		# @mkdir 'app/templates'
		# @copy '_package.json', 'package.json'
		# @copy '_bower.json', 'bower.json'
		# @copy 'hurr.coffee', 'hurr.coffee'
