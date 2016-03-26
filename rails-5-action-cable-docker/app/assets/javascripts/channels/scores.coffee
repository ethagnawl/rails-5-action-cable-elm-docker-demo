App.scores = App.cable.subscriptions.create "ScoresChannel",
    connected: ->
        # Called when the subscription is ready for use on the server

    disconnected: ->
        # Called when the subscription has been terminated by the server

    received: (data) ->
        score = data.message
        scoreboardApp.ports.incomingScore.send({
            initials: data.message.initials,
            score: data.message.score
        })

    simulate: (gameObject) ->
        @perform 'simulate', gameObject

