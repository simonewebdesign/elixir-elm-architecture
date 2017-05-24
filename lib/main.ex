defmodule Main do

  # def main do
  #   StartApp.start(
  #     %{model: @initial_model,
  #       view: &view/1,
  #       update: &update/2
  #     })
  # end


  # MODEL

  # type alias Model

  @initial_model 0


  # UPDATE

  # type Msg

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

end
