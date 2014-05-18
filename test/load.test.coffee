assert = require 'assert'

describe 'webapp-generic generator', ->
	it 'can be imported without blowing up', ->
		app = require '../src/app'
		assert(app?)