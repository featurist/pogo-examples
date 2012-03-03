(function() {
    var self, gen1_items, gen2_i, item, gen3_items, gen4_i;
    self = this;
    gen1_items = list;
    for (gen2_i = 0; gen2_i < gen1_items.length; gen2_i++) {
        item = gen1_items[gen2_i];
        print(item);
    }
    gen3_items = list;
    for (gen4_i = 0; gen4_i < gen3_items.length; gen4_i++) {
        item = gen3_items[gen4_i];
        print(item);
    }
}).call(this);