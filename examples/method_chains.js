(function() {
    var self;
    self = this;
    list.mapInto(function(i) {
        return i + 1;
    }).includeWhere(function(i) {
        return i < 5;
    }).eachDo(function(i) {
        return console.log(i);
    });
}).call(this);