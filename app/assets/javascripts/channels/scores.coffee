App.scores = App.cable.subscriptions.create "ScoresChannel",
    connected: ->
        # Called when the subscription is ready for use on the server

    disconnected: ->
        # Called when the subscription has been terminated by the server

    received: (data) ->
        scores = data.message
        scoreboardApp.ports.incomingScores.send(scores)

    simulate: (gameObject) ->
        @perform 'simulate', gameObject

