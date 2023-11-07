class MessagesController < ApplicationController
  before_action :load_event

  def index
    @messages = @event.messages.order(created_at: :desc)
    @new_message = @event.messages.build
  end

  def create
    @message = @event.messages.build(message_params)
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.html { redirect_to current_troop_with_event_path(event_id: @event.id) }
        format.turbo_stream
      else
        format.html { render :new }
        format.turbo_stream
      end
    end
  end

  def destroy
    @message = @event.messages.find(params[:id])
    @message.destroy
    redirect_to @event
  end

  private

    def message_params
      params.require(:message).permit(:message)
    end

    def load_event
      @event = Event.find(params[:event_id])
    end
end
