(function() {
    var self, person;
    self = this;
    person = {
        name: "Man Ray",
        sayHiLater: function() {
            return setTimeout(function() {
                return console.log("my name is " + self.name);
            }, 1e3);
        }
    };
}).call(this);