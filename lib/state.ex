defmodule State do
  @moduledoc """
  Collects all the triggered messages and ensures they are executed
  in the correct order.

  It also keeps track of the current application state and all the previous ones.

  For example this is how the GenServer state will look like:

      %{module: module,      # The application module name, e.g. Counter
        frames: [
          %{message: _,      # Each "frame" is a map containing the
            model: _},       # application state and the message that
          %{message: _,      # produced that state.
            model: _},
          ...
        ],
        initial_model: _     # The application's initial model
      }
  """
  use GenServer


  # Client API

  # def start_link(%{model: model, view: _v, update: _u} = config) do
  def start_link(module) do
    GenServer.start_link(__MODULE__, %{
      module: module,
      frames: [],
      initial_model: module.model()
    })
  end

  def step(pid, msg) do
    GenServer.call(pid, {:step, msg})
  end

  def undo(pid) do
    GenServer.call(pid, :undo)
  end

  # def push(pid, evt) do
    # GenServer.call(pid, {:push, evt})
  # end

  # def pop(pid) do
    # GenServer.call(pid, :pop)
  # end

  # Server (callbacks)

  def handle_call({:step, msg}, _from, state) when msg in [:Increment, :Decrement] do
    new_model = update_model(msg, state)
    new_frame = %{message: msg, model: new_model}

    {:reply, {:ok, new_model}, %{state | frames: [new_frame|state.frames]}}
  end

  def handle_call({:step, _msg}, _from, state) do
    {:reply, {:error, :invalid_message}, state}
  end


  def handle_call(:undo, _from, state) do
    {previous_model, frames} = undo_model(state)
    {:reply, {:ok, previous_model}, %{state | frames: frames}}
  end

  def handle_call(:pop, _from, [h | t]) do
    {:reply, h, t}
  end

  # Private

  defp update_model(msg, %{module: mod, frames: [], initial_model:  model}) do
    apply mod, :update, [msg, model]
  end
  defp update_model(msg, %{module: mod, frames: [head|_], initial_model: _}) do
    apply mod, :update, [msg, head.model]
  end

  defp undo_model(%{frames: [ _ | [head|tail] ]}), do: {head.model, tail}
  defp undo_model(%{frames: [], initial_model: model}), do: {model, []}

  # def handle_call(request, from, state) do
  #   # Call the default implementation from GenServer
  #   super(request, from, state)
  # end

  # def handle_cast(request, state) do
  #   super(request, state)
  # end
end
