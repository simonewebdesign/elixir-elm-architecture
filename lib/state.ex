defmodule State do
  @moduledoc """
  Collect all the triggered messages and ensures that they are executed
  in the correct order.
  """
  use GenServer

  # Client API

  def start_link(%{model: model, view: _v, update: _u} = config) do
    GenServer.start_link(__MODULE__, model)
  end

  def step(pid, msg) do
    GenServer.call(pid, {:step, msg})
  end

  # def undo(pid, msg) do

  # end

  # def push(pid, evt) do
    # GenServer.call(pid, {:push, evt})
  # end

  # def pop(pid) do
    # GenServer.call(pid, :pop)
  # end

  # Server (callbacks)

  def handle_call({:step, msg}, _from, state) do
    IO.puts "######"
    # IO.inspect state
    # IO.inspect
    # new_state = %{state | model: state.update(msg, state.model)}
    new_state = apply(Main, :update, [msg, state])

    IO.puts "@@@@@"

    {:reply, "asd", new_state}
  end

  def handle_call(:pop, _from, [h | t]) do
    {:reply, h, t}
  end

  # def handle_call(request, from, state) do
  #   # Call the default implementation from GenServer
  #   super(request, from, state)
  # end

  # def handle_cast(request, state) do
  #   super(request, state)
  # end
end
