class ScoresChannel < ApplicationCable::Channel
  def subscribed
    stream_from "scores_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def simulate(message)
    ActionCable.server.broadcast 'scores_channel', message: message
    # TestJob.perform_now data
  end
end
