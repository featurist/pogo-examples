(function() {
    var self, person;
    self = this;
    person = function(gen1_options) {
        var name;
        name = gen1_options && gen1_options.name != null ? gen1_options.name : undefined;
        return object(function() {
            var self;
            self = this;
            return self.name = name;
        });
    };
}).call(this);