defmodule State.Impl do

  def step(msg, state) do
    new_model = update_model(msg, state)
    new_frame = %{message: msg, model: new_model}
    { new_model, new_frame }
  end


  def undo(state) do
    undo_model(state)
  end


  ## private

  defp update_model(msg, %{module: mod, frames: [], initial_model:  model}) do
    apply mod, :update, [msg, model]
  end
  defp update_model(msg, %{module: mod, frames: [head|_], initial_model: _}) do
    apply mod, :update, [msg, head.model]
  end

  %{frames: [%{message: {:Name, "John"}, model: %{name: "John", password: "", password_again: ""}}], initial_model: %{name: "", password: "", password_again: ""}, module: Form}

  defp undo_model(%{frames: [ _ | [head|tail] ]}), do: {head.model, tail}
  defp undo_model(%{frames: [_], initial_model: model}), do: {model, []}
  defp undo_model(%{frames: [], initial_model: model}), do: {model, []}
end
