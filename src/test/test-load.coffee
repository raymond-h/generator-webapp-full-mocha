assert = require 'assert'

describe 'webapp-generic generator', ->
  it 'can be imported without blowing up', ->
    app = require '../app'
    assert(app?)
