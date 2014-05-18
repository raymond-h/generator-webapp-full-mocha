module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt)
	
	grunt.initConfig
		clean:
			app: ['app/*']
			test: ['test/*']

		copy:
			app:
				expand: true
				cwd: 'src/app'
				src: 'templates/**/*'
				dest: 'app/'

			test:
				expand: true
				cwd: 'src/test'
				src: ['temp/**/*']
				dest: 'test/'

		coffee:
			src:
				expand: true
				cwd: 'src/app/'
				src: 'index.coffee'
				dest: 'app/'
				ext: '.js'

			test:
				expand: true
				cwd: 'src/test/'
				src: ['test-creation.coffee', 'test-import.coffee']
				dest: 'test/'
				ext: '.js'

		watch:
			src:
				files: 'src/**/*'
				tasks: ['default']

		mochacli:
			all: ['test/**/*.js']
	
	grunt.registerTask 'build', ['clean', 'copy', 'coffee']
	grunt.registerTask 'test', ['build', 'mochacli']
	grunt.registerTask 'default', ['test']
