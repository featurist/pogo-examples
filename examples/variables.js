(function() {
    var self, thisIsAVariable, thisIsAFunction, thisIsAlsoAFunction;
    self = this;
    thisIsAVariable = "variable";
    thisIsAFunction = function() {
        return "function";
    };
    thisIsAlsoAFunction = function() {
        return "function";
    };
}).call(this);