http = require 'http'
http. create server @(request, response)
    response. write (head: 200, "Content-Type": "text/plain")
    response. end "Hello World\n"
. listen 1337