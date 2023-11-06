class EventsController < ApplicationController
  before_action :load_troop
  before_action :load_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = @troop.events.where('ends_at > ?', Time.current).order(starts_at: :desc)
  end

  def show; end

  def new
    @event = @troop.events.new
  end

  def create
    @event = @troop.events.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to troop_event_path(@troop, @event), notice: 'Event was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@event, partial: "events/form", locals: { event: @event }) }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to troop_event_path(@troop, @event), notice: 'Event was successfully updated.', status: :see_other }
        format.turbo_stream
      else
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@event, partial: "events/form", locals: { event: @event }) }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to troop_events_path(@troop), notice: 'Event was successfully destroyed.', status: :see_other }
      format.turbo_stream
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :description, :starts_at, :ends_at, address_attributes: [:id, :address_text])
    end

    def load_troop
      @troop = current_user.troops.find(params[:troop_id])
    end

    def load_event
      @event = @troop.events.find(params[:id])
    end
end
