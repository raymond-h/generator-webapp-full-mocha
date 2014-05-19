# Helper function for testing
#
# This function will take a function to be called if an error is caught.
# In turn, it returns a function that takes the callback in which assertions
# are to be made. Finally, it returns a callback to be passed to the
# function being tested. This means that any errors thrown in the callback
# will be caught and automatically passed to the done callback.
#
# If no errors are thrown, done isn't automatically called - you need to
# call it yourself (in case you need to do more async function calls)

(exports ? window).asyncCatch = (done) ->
	(callback) -> (args...) ->
		try callback args...
		catch e then done e

# Example usage with fs.readFile (assuming 'done' is a callback)
#
# fs.readFile 'log.txt', asyncCatch(done) (err, data) ->
#
# 	expect(err).to.not.exist
# 	expect(data).to.exist.and.be.length 20
#
# 	done()