App.scores = App.cable.subscriptions.create "ScoresChannel",
    connected: ->
        console.log 'connected', arguments

    disconnected: ->

    received: (data) ->
        console.log 'received', arguments

    simulate: -> @perform 'simulate'

setInterval ->
    do App.scores.simulate
, 1500
