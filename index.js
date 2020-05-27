const PORT = process.env.PORT || 3000
const express = require('express')
const server = express()

server.use(express.static(__dirname + '/bin'))

server.listen(PORT, () => console.log(`Server listening on port ${PORT}`))
