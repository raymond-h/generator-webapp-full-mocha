module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt)
	
	grunt.initConfig
		clean:
			app: ['generators/**/*']

		copy:
			templates:
				files: [{
					expand: true
					cwd: 'src/'
					src: ['*/templates/**']
					dest: 'generators/'
				}]

		coffee:
			generators:
				files: [
					{
						expand: yes
						cwd: 'src/'
						src: ['**/*.coffee', '!*/templates/**']
						dest: 'generators/'
						ext: '.js'
					}
				]

		coffeelint:
			options:
				no_tabs: level: 'ignore' # this is tab land, boy
				indentation: value: 1 # single tabs

			generators:
				src: [
					'src/**/*.coffee'
					'!src/*/templates/**'
				]

			misc:
				src: [
					'Gruntfile.coffee' # even gruntfiles need linting
					'test/**/*.coffee'
				]

		mochaTest:
			options:
				reporter: 'spec'
				require: ['coffee-script/register']

			generators:
				src: [
					'test/**/*.test.coffee'
				]
	
	grunt.registerTask 'default', [
		'lint'
		'test'
		'clean'
		'build'
	]

	grunt.registerTask 'lint', ['coffeelint']
	grunt.registerTask 'test', ['mochaTest:generators']
	grunt.registerTask 'build', ['coffee:generators', 'copy:templates']