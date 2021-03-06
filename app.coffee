express = require('express')
connect_assets = require('connect-assets')
redis = require('redis')
sockjs = require('sockjs')
http = require('http')
path = require('path')

app = express()

app.set 'port', process.env.PORT || 3000
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger('dev')
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.cookieParser('your secret here')
app.use express.session()
app.use app.router
app.use connect_assets()
app.use require('stylus').middleware(path.join(__dirname, 'public'))
app.use express.static(path.join(__dirname, 'public'))

if 'development' == app.get('env')
  app.use express.errorHandler()

db = redis.createClient()

echo = sockjs.createServer()
echo.on 'connection', (conn) ->
  conn.on 'data', (message) ->
    conn.write(message)

app.get '/', (req, res) ->
  res.render 'play', sess: req.sessionID

server = http.createServer(app)
echo.installHandlers server, prefix: '/echo'
server.listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')
