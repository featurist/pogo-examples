(function() {
    var self, oneLowerThan, oneHigherThan, eitherOr;
    self = this;
    oneLowerThan = function(n) {
        return n - 1;
    };
    oneHigherThan = function(n) {
        return n + 1;
    };
    eitherOr = function(thing, other) {
        return other;
    };
}).call(this);