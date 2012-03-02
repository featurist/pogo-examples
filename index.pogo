fs = require "fs"
async = require "async"
handlebars = require "handlebars"
exec = require "child_process" : exec
highlight = require "highlight" : Highlight

html = "
<html>
  <head>
    <title>Pogo Examples</title>
    <style>
      pre { width: 24em; border: 1px solid #ccc; }
    </style>
    <link rel=\"stylesheet\" type=\"text/css\" href=\"highlight.css\" />
  </head>
  <body>
    <ul>
      {{#each examples}}
      <li>
        Pogo:
        <pre><code class=\"pogo\">{{{pogo this}}}</code></pre>
        JavaScript:
        <pre><code class=\"javascript\">{{{js this}}}</code></pre>
      </li>
      {{/each}}
    </ul>
    
  </body>
</html>
"
template = @handlebars: compile @html

remove closure from @js =
  reg = new (RegExp "(^[^\n]+\n\s*)|(\n[^\n]+$)" "g")
  js : replace @reg (new (String))

unindent @js =
  reg = new (RegExp "\n    " "g")
  js : replace @reg "\n"

simplify @js =
  unindent (remove closure from @js)

read compiled js at @path @pogo @callback =
  fs : read file @path "utf-8" #jserr #js
    js = simplify @js
    @callback @null {
      js = @highlight @js
      pogo = @highlight @pogo
    }  

compile pogo @path @pogo @callback =
  js path = @path: replace ".pogo" ".js"
  exec "pogo -c @path" #error #stdout #stderr
    read compiled js at (js path) @pogo @callback

render @file @callback =
  path = "./examples/@file"
  fs: read file @path "utf-8" #err #pogo
    compile pogo @path @pogo @callback

print @err @results =
  rendered = @template { examples = @results }
  console: log @rendered

is @path pogo =
  @path : index of ".pogo" > -1
  
dir @err @files =
  pogos = @files : filter (is pogo)
  async: map @pogos @render @print
  
fs: readdir "./examples/" @dir

