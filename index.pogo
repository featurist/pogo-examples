fs = require "fs"
async = require "async"
handlebars = require "handlebars"
highlight = require "./highlight/highlight"
pogo = require 'pogo'

html = fs.read file sync("./index.handlebars").to string()
template = handlebars.compile (html)

title from filename (string) =
  string := string.replace r/\.pogo$/ ''
  string := string.replace r/_/g " "
  string.replace r/\w\S*/g @(text)
    text.char at 0.to upper case() + text.substr 1.to lower case()

render (file, callback) =
  path = "./examples/#(file)"
  fs.read file (path) "utf-8" @(error, pogo source)
    if (error)
      callback (error)
    else
      js = pogo.compile (pogo source, in scope: false)
      callback (null) {
        js = highlight.javascript (js)
        pogo = highlight.pogoscript (pogo source)
        name = title from filename (file)
      }

print (err, results) =
  rendered = template { examples = results }
  console.log (rendered)

is (path) pogo = @{ r/\.pogo$/.test (path) }

async examples last (x, y) =
  if (x.replace(r/^async/, "zzz") > y.replace(r/^async/, "zzz"))
    1
  else
    -1

dir (err, files) =
  pogos = files.filter (is pogo).sort (async examples last)
  async.map (pogos, render, print)

fs.readdir "./examples/" (dir)
