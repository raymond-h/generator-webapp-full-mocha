chai = require 'chai'
chai.use require 'chai-as-promised'

{expect} = chai
chai.should()

describe 'Common', ->
	it 'should provide an asyncCatch function', ->
		(require '../common').asyncCatch.should.exist