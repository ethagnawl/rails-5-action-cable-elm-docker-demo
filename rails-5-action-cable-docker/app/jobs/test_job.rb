class TestJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'scores_channel', message: message
  end
end
