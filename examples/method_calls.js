(function() {
    var self, file;
    self = this;
    file = openFile("README.md");
    file.readLine();
    openFile("README.md").readLine();
}).call(this);