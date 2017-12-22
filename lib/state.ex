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
  alias State.Impl


  # Client API

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


  # Server (callbacks)

  def handle_call({:step, msg}, _from, state) when is_atom(msg) or is_tuple(msg) do
      {new_model, new_frame} = Impl.step(msg, state)

      {:reply, {:ok, new_model}, %{state | frames: [new_frame|state.frames]}}
  end


  def handle_call(:undo, _from, state) do
    {previous_model, frames} = Impl.undo(state)

    {:reply, {:ok, previous_model}, %{state | frames: frames}}
  end

  def handle_call(:pop, _from, [h | t]) do
    {:reply, h, t}
  end
end
