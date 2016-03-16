class TestJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'scores_channel', message: message
    sleep rand(1..10)
    TestJob.perform_later rand(111...999)
  end
end
