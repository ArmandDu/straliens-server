# modules
express = require("express");
app = express();
colors = require 'colors'
db = require './models/db'
http = require './services/http'
logger = require './services/logger'
# config
net = require './config/networking'


# DATABASE
# --------
do db.syncSchemas


# EXPRESS BOOTSTRAP
# -----------------
# add middlewares
http.addThirdPartyMiddlewares app
http.tuneResponses app
# def routing
api = require './api'
api app
# listen
app.listen net.http.port
logger.info "HTTP REST API listening on port #{net.http.port}".green

# SHOW INDEX
# -------------------
app.use(express.static(__dirname + '/index'));
app.get '/', (req, res) ->
  res.sendFile '/index.html'

# SOCKET.IO BOOTSTRAP
# -------------------

# todo ;p