class MessagesController < ApplicationController
  def index
    @messages = SupportMessage.order(created_at: :desc).limit(20)
  end
end
