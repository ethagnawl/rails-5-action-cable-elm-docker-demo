class ScoresChannel < ApplicationCable::Channel
  def subscribed
    stream_from "scores_channel"
  end

  def unsubscribed; end

  def simulate(message)

    redis = Redis.new(host: REDIS_ADDR, port: REDIS_PORT)
    redis.zadd 'scores',
               message['score'],
               message['initials']

    _scores = redis.zrevrange 'scores', 0, 10, with_scores: true
    scores = _scores.map do |(initials, score)|
      {
        initials: initials,
        score: score
      }
    end

    ActionCable.server.broadcast 'scores_channel',
                                 message: scores

  end
end
