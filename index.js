(function() {
    var self, fs, async, handlebars, exec, highlight, html, template, titleCase, removeClosureFrom, unindent, simplify, readCompiledJsAt, compilePogo, render, print, isPogo, dir;
    self = this;
    fs = require("fs");
    async = require("async");
    handlebars = require("handlebars");
    exec = require("child_process").exec;
    highlight = require("highlight").Highlight;
    html = '\n<html>\n  <head>\n    <title>Pogo Examples</title>\n    <link rel="stylesheet" type="text/css" href="samples.css" />\n    <link rel="stylesheet" type="text/css" href="highlight.css" />\n  </head>\n  <body>\n    <a href="https://github.com/featurist/pogo-examples"><img style="position: absolute; top: 0; right: 0; border: 0;" src="http://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png" alt="Fork me on GitHub" /></a>\n    <h1>PogoScript to JavaScript Examples</h1>\n    <ul>\n      {{#each examples}}\n      <li>\n<h2>{{this.name}}</h2>\n<div class="pogo">\n  <pre><code class="pogoscript">{{{this.pogo}}}</code></pre>\n</div>\n<div class="javascript">\n  <pre><code class="pogoscript">{{{this.js}}}</code></pre>\n</div>\n<hr />\n      </li>\n      {{/each}}\n    </ul>\n    \n  </body>\n</html>\n';
    template = handlebars.compile(html);
    titleCase = function(string) {
        var reg, string;
        reg = new RegExp("_", "g");
        string = string.replace(reg, " ");
        reg = new RegExp("\\w\\S*", "g");
        return string.replace(reg, function(text) {
            return text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();
        });
    };
    removeClosureFrom = function(js) {
        var reg;
        reg = new RegExp("(^[^\n]+\n\\s*)|(\n[^\n]+$)", "g");
        return js.replace(reg, new String);
    };
    unindent = function(js) {
        var reg;
        reg = new RegExp("\n    ", "g");
        return js.replace(reg, "\n");
    };
    simplify = function(js) {
        return unindent(removeClosureFrom(js));
    };
    readCompiledJsAt = function(path, pogo, callback) {
        return fs.readFile(path, "utf-8", function(jserr, js) {
            var js, name;
            js = simplify(js);
            name = path.replace("./examples/", new String);
            name = name.replace(".js", new String);
            return callback(null, {
                js: js,
                pogo: pogo,
                name: titleCase(name)
            });
        });
    };
    compilePogo = function(path, pogo, callback) {
        var jsPath;
        jsPath = path.replace(".pogo", ".js");
        return exec("pogo -c " + path, function(error, stdout, stderr) {
            return readCompiledJsAt(jsPath, pogo, callback);
        });
    };
    render = function(file, callback) {
        var path;
        path = "./examples/" + file;
        return fs.readFile(path, "utf-8", function(err, pogo) {
            return compilePogo(path, pogo, callback);
        });
    };
    print = function(err, results) {
        var rendered;
        rendered = template({
            examples: results
        });
        rendered = highlight(rendered);
        return console.log(rendered);
    };
    isPogo = function(path) {
        return path.indexOf(".pogo") > -1;
    };
    dir = function(err, files) {
        var pogos;
        pogos = files.filter(isPogo);
        return async.map(pogos, render, print);
    };
    fs.readdir("./examples/", dir);
}).call(this);