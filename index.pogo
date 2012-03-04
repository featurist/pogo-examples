fs = require "fs"
async = require "async"
handlebars = require "handlebars"
exec = require "child_process": exec
highlight = require "./highlight/highlight"

html = fs: read file sync "./index.handlebars": to string !
template = handlebars: compile @html

title case @string =
  reg = new (RegExp "_" "g")
  string = string : replace @reg " "
  reg = new (RegExp "\w\S*" "g")
  string: replace @reg #text
    (text: char at 0 :to upper case!) + (text: substr 1: to lower case!)

remove closure from @js =
  reg = new (RegExp "(^[^\n]+\n\s*)|(\n[^\n]+$)" "g")
  js: replace @reg (new (String))

unindent @js =
  reg = new (RegExp "\n    " "g")
  js: replace @reg "\n"

simplify @js =
  unindent (remove closure from @js)

read compiled js at @path @pogo @callback =
  fs: read file @path "utf-8" #jserr #js
    js = simplify @js
    name = path: replace "./examples/" (new (String))
    name = name: replace ".js" (new (String))
    @callback @null {
      js =  @highlight: javascript @js
      pogo = @highlight: pogoscript @pogo
      name = (title case) @name
    }  

compile pogo @path @pogo @callback =
  js path = path: replace ".pogo" ".js"
  exec "pogo -c @path" #error #stdout #stderr
    read compiled js at (js path) @pogo @callback

render @file @callback =
  path = "./examples/@file"
  fs: read file @path "utf-8" #err #pogo
    compile pogo @path @pogo @callback

print @err @results =
  rendered = template { examples = @results }
  console: log @rendered

is @path pogo =
  path : index of ".pogo" > -1
  
dir @err @files =
  pogos = files: filter (is pogo)
  async: map @pogos @render @print
  
fs: readdir "./examples/" @dir

