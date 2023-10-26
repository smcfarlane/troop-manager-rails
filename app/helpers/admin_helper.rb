module AdminHelper
  TROOP_STATES = {
    'pending' => 'bg-amber-300',
    'active' => 'bg-green-300',
    'inactive' => 'bg-red-300'
  }
  def troop_state(state)
    TROOP_STATES[state]
  end
end
