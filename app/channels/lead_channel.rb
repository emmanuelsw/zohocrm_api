class LeadChannel < ApplicationCable::Channel
  def subscribed
    stream_from "leads"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
