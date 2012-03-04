fs = require "fs"
async = require "async"
handlebars = require "handlebars"
exec = require "child_process": exec
highlight = require "./highlight/highlight"
pogo = require 'pogo'

html = fs: read file sync "./index.handlebars": to string!
template = handlebars: compile (html)

title case (string) =
  reg = `_`g
  string = string : replace (reg) " "
  reg = `\w\S*`g
  string: replace (reg) @(text)
    text: char at 0 :to upper case! + text: substr 1: to lower case!

remove closure from (js) =
  reg = `(^[^\n]+\n\s*)|(\n[^\n]+$)`g
  js: replace (reg, '')

unindent (js) =
  reg = `\n    `g
  js: replace (reg) "\n"

simplify (js) =
  unindent (remove closure from (js))

read compiled js at (path, pogo, callback) =
  fs: read file (path) "utf-8" @(jserr, js)
    js = simplify (js)
    name = path: replace "./examples/" ''
    name = name: replace ".js" ''
    callback (null) {
      js = highlight: javascript (js)
      pogo = highlight: pogoscript (pogo)
      name = title case (name)
    }

compile pogo (path, pogo, callback) =
  js path = path: replace ".pogo" ".js"
  exec "pogo -c @path" @(error, stdout, stderr)
    read compiled js at (js path, pogo, callback)

render (file, callback) =
  path = "./examples/@file"
  fs: read file (path) "utf-8" @(error, pogo source)
    if (error)
      callback (error)
    else
      js = pogo: compile (pogo source); in scope (false)
      callback (null) {
        js = highlight: javascript (js)
        pogo = pogo source
        name = title case (file)
      }

print (err, results) =
  rendered = template { examples = results }
  console: log (rendered)

is (path) pogo =
  `\.pogo$`: test (path)
  
dir (err, files) =
  pogos = files: filter (is pogo)
  async: map (pogos, render, print)
  
fs: readdir "./examples/" (dir)
