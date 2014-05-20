assert = require 'assert'

describe 'webapp-full-mocha generator', ->
	it 'can be imported without blowing up', ->
		app = require '../src/app'
		assert(app?)