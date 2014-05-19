module.exports = (grunt) ->
	
	require('load-grunt-tasks')(grunt)

	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		#### Compiling (CoffeeScript and LESS)
		coffee:
			server:
				files: [{
					expand: yes
					cwd: 'src/'
					src: '**/*.coffee'
					dest: 'lib/'
					ext: '.js'
				}]

			client:
				files: [{
					expand: yes
					cwd: 'app/'
					src: '**/*.coffee'
					dest: 'built-app/'
					ext: '.js'
				}]

		less:
			client:
				files: [{
					expand: true
					cwd: 'app/'
					src: '**/*.less'
					dest: 'built-app/'
					ext: '.css'
				}]

		#### Copying and cleaning
		copy:
			server:
				files: [{
					expand: true
					cwd: 'src/'
					src: ['**/*', '!**/*.coffee']
					dest: 'lib/'
				}]

			client:
				files: [{
					expand: true
					cwd: 'app/'
					src: ['**/*', '!**/*.{coffee,less}']
					dest: 'built-app/'
				}]

		clean:
			server: ['lib/']
			client: ['built-app/']

		#### Linting
		coffeelint:
			server:
				files: src: [
					'Gruntfile.coffee'
					'src/**/*.coffee'
					'test/server/**/*.coffee'
				]

			client:
				files: src: [
					'app/**/*.coffee'
					'test/client/**/*.coffee'
				]

			options:
				no_tabs: level: 'ignore' # this is tab land, boy
				indentation: value: 1 # single tabs

		#### Testing
		mochaTest:
			options:
				reporter: 'spec'
				require: ['coffee-script/register']

			server:
				src: ['test/server/**/*.test.coffee']

		karma:
			options:
				singleRun: true

				frameworks: ['mocha', 'chai', 'chai-as-promised']
				reporters: ['spec']

				preprocessors:
					'**/*.coffee': ['coffee']

				files: [
					'bower_components/angular/angular.js'
					'bower_components/angular-mocks/angular-mocks.js'
					'bower_components/jquery/dist/jquery.js'

					'app/**/*.{coffee,js}'

					'test/*.coffee'
					'test/client/unit/**/*.test.coffee'
				]

			client_unit_own:
				options:
					browsers: ['PhantomJS']

			client_unit_webdriver:
				options:
					singleRun: true
					browsers: ['WebDriver_Local']

					customLaunchers:
						WebDriver_Local:
							base: 'WebDriver'
							config:
								port: 9515

		protractor:
			client_e2e:
				options:
					keepAlive: false

					args:
						seleniumAddress: 'http://localhost:9515/'

						framework: 'mocha'

						capabilities:
							browserName: 'phantomjs'

						baseUrl: 'http://localhost:80/'

						specs: ['test/client/e2e/**/*.test.coffee']

		#### Misc (automated testing using watch)
		watch:
			server:
				files: ['src/**/*', 'test/server/**/*']
				tasks: ['server']

			server_lint_test:
				files: ['src/**/*', 'test/server/**/*']
				tasks: ['lint-server', 'test-server']

			client:
				files: ['app/**/*', 'test/client/unit/**/*']
				tasks: ['lint-client', 'test-client-unit', 'build-client']

			client_webdriver:
				files: ['app/**/*', 'test/client/unit/**/*']
				tasks: ['lint-client', 'test-client-unit-webdriver', 'build-client']

			client_lint_test:
				files: ['app/**/*', 'test/client/unit/**/*']
				tasks: ['lint-client', 'test-client-unit']

			autoreload:
				files: ['lib/**/*', 'built-app/**/*']
				options:
					livereload: yes

		concurrent:
			options: logConcurrentOutput: true

			dev:
				tasks: [
					'watch:server', 'watch:client_webdriver'
					'watch:autoreload', 'execute:main_server'
				]

			test_e2e:
				tasks: ['execute:main_server', 'protractor:client_e2e']

		execute:
			main_server:
				src: ['<%= pkg.main %>']

	grunt.registerTask 'default', ['lint', 'test', 'build']
	grunt.registerTask 'server', ['lint-server', 'test-server', 'build-server']
	grunt.registerTask 'client',
		['lint-client', 'test-client-unit-webdriver', 'test-e2e', 'build-client']

	grunt.registerTask 'lint', ['lint-server', 'lint-client']
	grunt.registerTask 'lint-server', ['coffeelint:server']
	grunt.registerTask 'lint-client', ['coffeelint:client']

	grunt.registerTask 'test',
		['test-server', 'test-client-unit-webdriver', 'test-e2e']
	grunt.registerTask 'test-unit', ['test-server', 'test-client-unit']
	grunt.registerTask 'test-server', ['mochaTest:server']
	grunt.registerTask 'test-client-unit',['karma:client_unit_own']
	grunt.registerTask 'test-client-unit-webdriver',
		['karma:client_unit_webdriver']
	grunt.registerTask 'test-e2e', ['concurrent:test_e2e']

	grunt.registerTask 'build', ['build-server', 'build-client']
	grunt.registerTask 'build-server',
		['clean:server', 'copy:server', 'coffee:server']
	grunt.registerTask 'build-client',
		['clean:client', 'copy:client', 'coffee:client', 'less:client']

	grunt.registerTask 'dev', ['concurrent:dev']