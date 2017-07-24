defmodule Checkboxes do

  # MODEL

  @type model :: %{
    notifications: boolean,
    autoplay: boolean,
    location: boolean,
  }

  @initial_model %{
    notifications: false,
    autoplay: false,
    location: false,
  }

  def model do
    @initial_model
  end


  # UPDATE

  @type msg ::
      :ToggleNotifications
    | :ToggleAutoplay
    | :ToggleLocation

  @spec messages() :: list(msg)
  def messages, do:
    [:ToggleNotifications,
     :ToggleAutoplay,
     :ToggleLocation
    ]

  @spec update(msg, model) :: model
  def update(msg, model) do
    case msg do
      :ToggleNotifications ->
        %{ model | notifications: !model.notifications }
      :ToggleAutoplay ->
        %{ model | autoplay: !model.autoplay }
      :ToggleLocation ->
        %{ model | location: !model.location }
    end
  end


  # VIEW

  def view(model) do
    """
    Email Notifications:  #{model.notifications}
    Video Autoplay:       #{model.autoplay}
    Use Location:         #{model.location}
    """
  end


  def main do
    StartApp.start(__MODULE__)
  end

end
