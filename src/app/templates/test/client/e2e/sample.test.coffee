chai = require 'chai'
chai.use require 'chai-as-promised'

{expect} = chai
chai.should()

describe "Authentication capabilities", ->
	fail = ->
		true.should.be.true

	it "should redirect to the login page if trying to load
	    protected page while not authenticated", fail

	it "should warn on missing/malformed credentials", fail

	it "should accept a valid email address and password", fail
	
	it "should return to the login page after logout", fail