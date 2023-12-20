const express = require('express');
const path = require('path');

const app = express();
const port = process.env.PORT || 8008;

app.use(express.static(__dirname + '/public'))

app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname, '/index.html'));
});

app.listen(port);
console.log('Server started at http://localhost:' + port);
