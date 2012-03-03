(function() {
    var self, item;
    self = this;
    item = 0;
    doWhile(function() {
        print(item);
        return item = item + 1;
    }, function() {
        return item < 10;
    });
}).call(this);