# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ScoresChannel < ApplicationCable::Channel
  def broadcast(message)
    ActionCable.server.broadcast 'scores_channel', message: message
  end

  def subscribed
    stream_from 'scores_channel'
    broadcast 'hullo!'
  end

  def unsubscribed; end

  def simulate
    broadcast 'fake score'
  end
end
