module AdminHelper
  TROOP_STATES = {
    'pending' => 'bg-amber-300',
    'active' => 'bg-green-300',
    'inactive' => 'bg-red-300'
  }
  def troop_state(state)
    TROOP_STATES[state]
  end

  def membership_url_params(source, cancel: false)
    url_params = {}
    url_params[:user_id] = @source.id if @source.is_a? User
    url_params[:troop_id] = @source.id if @source.is_a? Troop
    url_params[:cancel] = true if cancel
    url_params
  end
end
