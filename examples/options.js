(function() {
    var self, connectTo;
    self = this;
    connectTo = function(gen1_options) {
        var port, host;
        port = gen1_options && gen1_options.port != null ? gen1_options.port : 3306;
        host = gen1_options && gen1_options.host != null ? gen1_options.host : "127.0.0.1";
        return console.log("connecting to " + host + ":" + part);
    };
}).call(this);