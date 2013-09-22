EventEmitter = require('events').EventEmitter

shouter = new (EventEmitter)

shouter.on 'shout'
    console.log "calm down"

shouter.emit 'shout'