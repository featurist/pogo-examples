http = require 'http'
http. create server @(request, response)
    response.end "Hello World\n"
.listen 1337