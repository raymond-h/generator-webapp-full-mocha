{expect} = chai
chai.should()

describe 'Common', ->
	it 'should add asyncCatch to global scope', ->
		asyncCatch.should.exist