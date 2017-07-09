defmodule Counter do

  # MODEL

  # type alias Model
  @type model :: integer

  @initial_model 0

  def model do
    @initial_model
  end


  # UPDATE

  # type Msg
  @type msg :: :Increment | :Decrement

  def messages, do:
    [:Increment,
     :Decrement,
    ]

  def update(msg, model) do
    case msg do
      :Increment ->
        model + 1
      :Decrement ->
        model - 1
    end
  end


  # VIEW

  def view(model) do
    to_string(model)
  end


  def main do
    StartApp.start(__MODULE__)
    # %{model: @initial_model,
    #   view: &view/1,
    #   update: &update/2
    # })
  end

end
