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
			(this[k] = v) for k, v of props
			done()

	app: ->
		done = @async()
		walk = require 'walk'

		folder = path.join __dirname, 'templates'
		walker = walk.walk folder

		walker.on 'directories', (root, dirStats, next) =>
			root = path.relative folder, root
			dirs = dirStats.map (d) -> path.join root, d.name
			
			@mkdir dir for dir in dirs

			next()

		walker.on 'file', (root, fileStats, next) =>
			root = path.relative folder, root
			file = path.join root, fileStats.name

			if file[0] is '_' then @template file, file[1..]
			else @copy file, file

			next()

		walker.on 'end', done