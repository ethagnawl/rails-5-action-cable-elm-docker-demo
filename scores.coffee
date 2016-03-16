App.scores = App.cable.subscriptions.create "ScoresChannel",
    connected: ->
        console.log 'connected', arguments

    disconnected: ->

    received: (data) ->
        console.log 'received', data.message

        # score = data.message.score
        # elmApp.ports.encryptionCompleted.send(score)

    simulate: (score) -> @perform 'simulate', { score }

recur = ->
    tick = 3333
    score = Math.floor((Math.random() * 5000) + 1)
    App.scores.simulate score
    setTimeout(recur, tick)

do recur
