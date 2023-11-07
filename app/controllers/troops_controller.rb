class TroopsController < ApplicationController
  def current
    @event = Event.find(params[:event_id]) if params[:event_id]
  end

  def not_a_member
  end
end
