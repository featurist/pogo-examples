(function() {
    var self;
    self = this;
    connectToMysqlDatabase({
        address: "1.2.3.4",
        port: 3307
    });
    connectToMysqlDatabase({
        readonly: true
    });
    connectToMysqlDatabase({
        notReadonly: true
    });
}).call(this);