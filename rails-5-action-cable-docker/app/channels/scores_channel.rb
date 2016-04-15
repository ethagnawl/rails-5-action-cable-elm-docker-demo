class ScoresChannel < ApplicationCable::Channel
  def subscribed
    stream_from "scores_channel"
  end

  def unsubscribed; end

  def simulate(message)

    redis = Redis.new
    redis.zadd 'scores',
               message['score'],
               message['initials']

    scores = redis.zrevrange 'scores', 0, 10, with_scores: true

    ActionCable.server.broadcast 'scores_channel',
                                 message: scores

  end
end
