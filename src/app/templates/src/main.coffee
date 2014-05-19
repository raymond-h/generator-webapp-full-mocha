path = require 'path'
querystring = require 'querystring'
https = require 'https'

express = require 'express'
morgan = require 'morgan'
serveStatic = require 'serve-static'
favicon = require 'serve-favicon'

app = express()

app.use morgan()

# app.use favicon path.join __dirname, '..', 'built-app/favicon.ico'

app.use '/bower_deps',
	serveStatic path.join __dirname, '..', 'bower_components'

app.use serveStatic path.join __dirname, '..', 'built-app'

# routes go here

app.listen 80