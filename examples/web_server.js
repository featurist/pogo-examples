(function() {
    var self, http, server;
    self = this;
    http = require("http");
    server = http.createServer(function(request, response) {
        response.writeHead(200, {
            "Content-Type": "text/plain"
        });
        return response.end("Hello World\n");
    });
}).call(this);