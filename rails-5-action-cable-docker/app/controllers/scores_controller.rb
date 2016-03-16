class ScoresController < ApplicationController
  def show
    @messages = Message.all
  end
end
